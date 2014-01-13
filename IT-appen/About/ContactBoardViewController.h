//
//  ContactBoardViewController.h
//  IT-sektionen 2.0
//
//  Created by Shervin Shoravi on 29/8/12.
//  Copyright (c) 2012 Shervin Shoravi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import <MessageUI/MessageUI.h>
#import "BoardMemberCell.h"

@interface ContactBoardViewController : UITableViewController <MFMailComposeViewControllerDelegate, BoardMemberCellDelegate>

@end
