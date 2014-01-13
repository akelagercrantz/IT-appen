//
//  BoardMemberCell.h
//  IT-sektionen 2.0
//
//  Created by Åke Lagercrantz on 2012-10-10.
//  Copyright (c) 2012 Shervin Shoravi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoardMember.h"

@class BoardMemberCell;

@protocol BoardMemberCellDelegate

- (void)sendMailButtonPressedFor:(NSString *)boardMemberMail;

@end

@interface BoardMemberCell : UITableViewCell

@property (nonatomic, strong) id <BoardMemberCellDelegate> delegate;

- (void)configureCellWithBoardMember:(BoardMember *)boardmember;

@end
