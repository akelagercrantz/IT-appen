//
//  NewsCell.h
//  IT-sektionen 2.0
//
//  Created by Åke Lagercrantz on 2012-10-03.
//  Copyright (c) 2012 Shervin Shoravi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"

@interface NewsCell : UITableViewCell

- (void)configureCellWithNews:(News *)news;

@end
