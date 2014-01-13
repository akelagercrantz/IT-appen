//
//  TimetableCell.m
//  IT-sektionen 2.0
//
//  Created by Åke Lagercrantz on 2012-09-06.
//  Copyright (c) 2012 Shervin Shoravi. All rights reserved.
//

#import "TimetableCell.h"
#import "Event.h"

@interface TimetableCell()

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UILabel *programmes;
@property (weak, nonatomic) IBOutlet UILabel *organiser;
@property (weak, nonatomic) IBOutlet UILabel *note;

@end

@implementation TimetableCell

- (void)configureCellWithEvent:(Event *)event {
    UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, 0.5)];
    [tempView setBackgroundColor:[UIColor colorWithRed:193.0f/255.0f green:201.0f/255.0f blue:212.0f/255.0f alpha:1]];
    [self addSubview:tempView];
    
    [self.name setText:[event name]];
    [self.time setText:[event time]];
    [self.location setText:[event location]];
    [self.type setText:[event type]];
    [self.programmes setText:[event programmes]];
    [self.organiser setText:[event organiser]];
    [self.note setText:[event note]];
    
    //Ubuntu fonts
    [self.name setFont:[UIFont fontWithName:@"Ubuntu-Medium" size:16.0]];
    [self.time setFont:[UIFont fontWithName:@"Ubuntu-Medium" size:16.0]];
    [self.location setFont:[UIFont fontWithName:@"Ubuntu" size:16.0]];
    [self.type setFont:[UIFont fontWithName:@"Ubuntu-Medium" size:12.0]];
    [self.programmes setFont:[UIFont fontWithName:@"Ubuntu" size:12.0]];
    [self.organiser setFont:[UIFont fontWithName:@"Ubuntu" size:10.0]];
    [self.note setFont:[UIFont fontWithName:@"Ubuntu" size:10.0]];
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self.name setAdjustsFontSizeToFitWidth:YES];
}

@end
