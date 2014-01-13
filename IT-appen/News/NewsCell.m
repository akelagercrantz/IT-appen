//
//  NewsCell.m
//  IT-sektionen 2.0
//
//  Created by Åke Lagercrantz on 2012-10-03.
//  Copyright (c) 2012 Shervin Shoravi. All rights reserved.
//

#import "NewsCell.h"
#import "News.h"
#import "CustomAccessory.h"
#import "NSString_stripHtml.h"

@interface NewsCell()

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *excerpt;
@property (weak, nonatomic) IBOutlet UILabel *authorDate;

@end

@implementation NewsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    return self;
}

- (void)configureCellWithNews:(News *)news {
    [self.title setText:[news title]];
    [self.excerpt setText:[[news excerpt] stripHtml]];
    [self.authorDate setText:[NSString stringWithFormat:@"%@ - %@", [news author], [news date]]];
    
    //Custom Accessory
    CustomAccessory *accessory = [CustomAccessory accessoryWithColor:[UIColor colorWithRed:0.153 green:0.275 blue:0.451 alpha:1.0]];
    accessory.highlightedColor = [UIColor whiteColor];
    self.accessoryView = accessory;
    //self.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    
    //Ubuntu fonts
    [self.title setFont:[UIFont fontWithName:@"Ubuntu-Medium" size:17.0]];
    [self.excerpt setFont:[UIFont fontWithName:@"Ubuntu" size:13.0]];
    [self.authorDate setFont:[UIFont fontWithName:@"Ubuntu" size:13.0]];
    
    /*
    // Sizing for multiline UILabels
    CGSize titleSize = [self.title.text sizeWithFont:self.title.font constrainedToSize:CGSizeMake(250.0f, 40.0f) lineBreakMode:self.title.lineBreakMode];
    self.title.frame = CGRectMake(16.0f, 14.0f, titleSize.width, titleSize.height);
    
    // Background
    self.backgroundView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"IT_cell_thin"] resizableImageWithCapInsets:UIEdgeInsetsMake(35, 5, 35, 5)]];
    self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"IT_selected_cell_thin"] resizableImageWithCapInsets:UIEdgeInsetsMake(35,5,35,5)]];
    */
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
