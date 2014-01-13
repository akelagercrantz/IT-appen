//
//  CustomAccessory.h
//  SMC
//
//  Created by Shervin Shoravi on 19/6/12.
//  Copyright (c) 2012 ShervinShoravi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomAccessory : UIControl
{
	UIColor *_accessoryColor;
	UIColor *_highlightedColor;
}

@property (nonatomic, retain) UIColor *accessoryColor;
@property (nonatomic, retain) UIColor *highlightedColor;

+ (CustomAccessory *)accessoryWithColor:(UIColor *)color;

@end