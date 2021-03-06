#import "AboutLauncherViewController.h"

#include "utils.h"

#import <sys/utsname.h>


@interface AboutLauncherViewController () {
}
@property (nonatomic, strong) UIActivityViewController *activityViewController;
@end

@implementation AboutLauncherViewController
@synthesize activityViewController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"About PojavLauncher"];

    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGFloat screenScale = [[UIScreen mainScreen] scale];

    int width = (int) roundf(screenBounds.size.width);
    int height = (int) roundf(screenBounds.size.height) - self.navigationController.navigationBar.frame.size.height;
    int rawHeight = (int) roundf(screenBounds.size.height);

    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height + 5, width, height)];
    [self.view addSubview:scrollView];
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

    // Update color mode once
    if(@available(iOS 13.0, *)) {
        [self traitCollectionDidChange:nil];
    } else {
        self.view.backgroundColor = [UIColor whiteColor];
    }

    struct utsname systemInfo;
    uname(&systemInfo);
    NSString* deviceModel = [NSString stringWithCString:systemInfo.machine
                          encoding:NSUTF8StringEncoding];
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];

    UILabel *logoVerView = [[UILabel alloc] initWithFrame:CGRectMake(20, scrollView.frame.size.height - 5, width, 20)];
    logoVerView.text = [NSString stringWithFormat:@"version 1.3 (development) on %@ with iOS %@", deviceModel, currSysVer];
    logoVerView.lineBreakMode = NSLineBreakByWordWrapping;
    logoVerView.numberOfLines = 1;
    [logoVerView sizeToFit];
    [scrollView addSubview:logoVerView];
    [logoVerView setFont:[UIFont boldSystemFontOfSize:10]];

    UILabel *logoNoteView = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 10.0, width - 40, 700)];
    logoNoteView.text = @"Created by PojavLauncherTeam in 2021. We do not exist on TikTok. No one from the dev team makes TikTok videos.\n\nDuyKhanhTran - lead iOS port developer\nDoregon - UI/UX design\n\nSpecial thanks to Hayden Seay, for porting OpenJDK 16, making this possible, and hosting on Procursus.";
    logoNoteView.lineBreakMode = NSLineBreakByWordWrapping;
    logoNoteView.numberOfLines = 0;
    [logoNoteView sizeToFit];
    [scrollView addSubview:logoNoteView];

    UITextView *links = [[UITextView alloc] initWithFrame:CGRectMake(15, logoNoteView.frame.size.height + 9, width - 40, height - (logoNoteView.frame.size.height + 9))];
    links.text = @"Discord: https://discord.gg/pojavlauncher\nGitHub: https://bit.ly/2TIXhAA\nSubreddit: https://reddit.com/r/PojavLauncher\nWiki: https://pojavlauncherteam.github.io";
    links.editable = NO;
    links.dataDetectorTypes = UIDataDetectorTypeAll;
    [scrollView addSubview:links];
    [links setFont:[UIFont systemFontOfSize:17]];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Send your logs" style:UIBarButtonItemStyleDone target:self action:@selector(latestLogShare)];

    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height + 20);

}

-(void)latestLogShare
{
    activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[@"latestlog.txt", [NSURL URLWithString:@"file:///var/mobile/Documents/.pojavlauncher/latestlog.txt"]] applicationActivities:nil];

    [self presentViewController:activityViewController animated:YES completion:nil];
}

-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    if(@available(iOS 13.0, *)) {
        if (UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            self.view.backgroundColor = [UIColor blackColor];
        } else {
            self.view.backgroundColor = [UIColor whiteColor];
        }
    }
}

@end
