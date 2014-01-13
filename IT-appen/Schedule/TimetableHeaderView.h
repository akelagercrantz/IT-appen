//
//  TimetableHeaderView.h
//  IT-appen
//
//  Created by Farshid Besharati on 2013-11-03.
//  Copyright (c) 2013 IT-sektionen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface TimetableHeaderView : UIView

- (void)setDateLabelForEvent:(Event *)event;
//- (void)isAtTop:(BOOL)flag;

@end
