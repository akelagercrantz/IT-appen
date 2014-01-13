//
//  NewsDetailsViewController.m
//  IT-sektionen 2.0
//
//  Created by Åke Lagercrantz on 2012-10-05.
//  Copyright (c) 2012 Shervin Shoravi. All rights reserved.
//

#import "NewsDetailsViewController.h"

@interface NewsDetailsViewController ()

@end

@implementation NewsDetailsViewController
@synthesize news;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *html = [self htmlFromTitle:[news title] author:[news author] date:[news date] content:[news content]];
    self.title = [news title];
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    
    [[self webView] loadHTMLString:html baseURL:baseURL];
    [self.webView setScalesPageToFit:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setWebView:nil];
    [super viewDidUnload];
}

#pragma mark - Nav Button delegate

- (IBAction)openSourceButtonTapped:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[self news] url]]];
}

#pragma mark - WebView delegate

-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}


#pragma mark - HTML-related

- (NSString *)htmlFromTitle:(NSString *)title author:(NSString *)author date:(NSDate *)date content:(NSString *)content
{
    return [NSString stringWithFormat:@"<html><head>"
            "<META name='viewport' content='width=device-width, initial-scale=1.0, user-scalable=yes' />"
            "<style type='text/css'>"
                "body {font-family:ubuntu;font-size:12px;margin: 2em;background-image: url(%@);background-sºize:320px 640px}"
                "h2 {color:#1E335D;}"
                ".author-date {color:grey;}"
                "img {max-width:100%%;height:auto}"
            "</style>"
            "</head><body>"
            "<h2>%@</h2>"
            "<p class='author-date'>Skrivet av %@ den %@</p>"
            "%@", @"background@2x.png", title, author, date, content];
}

@end
