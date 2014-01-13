//
//  TimetableViewController.h
//  IT-sektionen 2.0
//
//  Created by Åke Lagercrantz on 2012-09-06.
//  Copyright (c) 2012 Shervin Shoravi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import "TimetableParser.h"

@interface TimetableViewController : UITableViewController <NSFetchedResultsControllerDelegate, UIScrollViewDelegate, TimeTableParserDelegate>

@end
