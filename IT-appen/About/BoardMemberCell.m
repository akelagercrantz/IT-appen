//
//  BoardMemberCell.m
//  IT-sektionen 2.0
//
//  Created by Åke Lagercrantz on 2012-10-10.
//  Copyright (c) 2012 Shervin Shoravi. All rights reserved.
//

#import "BoardMemberCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface BoardMemberCell()

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UIButton *sendMailButton;

@property (nonatomic, strong) BoardMember *boardMember;

@end

@implementation BoardMemberCell

- (void)configureCellWithBoardMember:(BoardMember *)boardmember {
    self.boardMember = boardmember;
    
    UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 0.5)];
    [tempView setBackgroundColor:[UIColor colorWithRed:193.0f/255.0f green:201.0f/255.0f blue:212.0f/255.0f alpha:1]];
    [self addSubview:tempView];
    
    [self.picture setImageWithURL:[NSURL URLWithString:[boardmember valueForKey:@"imageUrl"]]];
    
    [self.name setText:[boardmember valueForKey:@"person"]];
    [self.title setText:[boardmember valueForKey:@"postTitle"]];
    
    //Ubuntu fonts
    [self.name setFont:[UIFont fontWithName:@"Ubuntu-Medium" size:18.0]];
    [self.title setFont:[UIFont fontWithName:@"Ubuntu-Medium" size:13.0]];
    //[self.sendMailButton.titleLabel setFont:[UIFont fontWithName:@"Ubuntu-Medium" size:18.0]];
}

- (IBAction)sendMail:(id)sender {
    [self.delegate sendMailButtonPressedFor:[self.boardMember valueForKey:@"mail"]];
    
}

@end
