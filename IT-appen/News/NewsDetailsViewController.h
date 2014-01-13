//
//  NewsDetailsViewController.h
//  IT-sektionen 2.0
//
//  Created by Åke Lagercrantz on 2012-10-05.
//  Copyright (c) 2012 Shervin Shoravi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"

@interface NewsDetailsViewController : UIViewController
@property (strong, nonatomic) News *news;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
- (IBAction)openSourceButtonTapped:(id)sender;

@end
