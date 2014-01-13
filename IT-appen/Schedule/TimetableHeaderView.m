//
//  TimetableHeaderView.m
//  IT-appen
//
//  Created by Farshid Besharati on 2013-11-03.
//  Copyright (c) 2013 IT-sektionen. All rights reserved.
//

#import "TimetableHeaderView.h"

@interface TimetableHeaderView()

@property (nonatomic, strong) UILabel *dateLabel;

@end

@implementation TimetableHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 25.0f)];
        [self setBackgroundColor:[UIColor colorWithRed:193.0f/255.0f green:201.0f/255.0f blue:212.0f/255.0f alpha:1]];
        
        [self.dateLabel setFrame:CGRectMake(10, 0, 160, 20)];
        [self.dateLabel setFont:[UIFont fontWithName:@"Ubuntu-Medium" size:15]];
        [self.dateLabel setTextColor:[UIColor blackColor]];
        [self.dateLabel setBackgroundColor:[UIColor colorWithRed:193.0f/255.0f green:201.0f/255.0f blue:212.0f/255.0f alpha:1]];
        [self.dateLabel setOpaque:YES];
        [self addSubview:self.dateLabel];
    }
    return self;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
    }
    
    return _dateLabel;
}

- (void)setDateLabelForEvent:(Event *)event {
    self.dateLabel.text = [[event titleForHeader] capitalizedString];
}
/*
- (void)isAtTop:(BOOL)flag {
    if (flag) {
        [self setBackgroundColor:[UIColor colorWithRed:50.0f/255.0f green:77.0f/255.0f blue:113.0f/255.0f alpha:1]];
    } else {
        [self setBackgroundColor:[UIColor colorWithRed:50.0f/255.0f green:77.0f/255.0f blue:113.0f/255.0f alpha:0.3]];
    }
}
*/

@end
