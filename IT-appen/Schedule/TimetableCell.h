//
//  TimetableCell.h
//  IT-sektionen 2.0
//
//  Created by Åke Lagercrantz on 2012-09-06.
//  Copyright (c) 2012 Shervin Shoravi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface TimetableCell : UITableViewCell

- (void)configureCellWithEvent:(Event *)event;

@end
