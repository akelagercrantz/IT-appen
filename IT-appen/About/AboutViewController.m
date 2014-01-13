//
//  AboutViewController.m
//  IT-sektionen 2.0
//
//  Created by Shervin Shoravi on 28/8/12.
//  Copyright (c) 2012 Shervin Shoravi. All rights reserved.
//

#import "AboutViewController.h"
//#import "AboutCell.h"
#define ITSEKTIONEN 0
#define ITFACEBOOK 1
#define STUDENTPORTALEN 2
#define ANTAGNING 3
#define UTN 4

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
/*
#pragma mark - Table view datasource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AboutCell *cell = (AboutCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
    // Background
    cell.backgroundView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"IT_cell_thin"] resizableImageWithCapInsets:UIEdgeInsetsMake(35,5,35,5)]];
    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"IT_selected_cell_thin"] resizableImageWithCapInsets:UIEdgeInsetsMake(35,5,35,5)]];
    
    //Ubuntu fonts
    [cell.label setFont:[UIFont fontWithName:@"Ubuntu-Medium" size:17.0]];
    
    return cell;
}
*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    cell.textLabel.font = [UIFont fontWithName:@"Ubuntu-Medium" size:17.0f];
    
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 25.0f)];
    [headerView setBackgroundColor:[UIColor colorWithRed:193.0f/255.0f green:201.0f/255.0f blue:212.0f/255.0f alpha:1]];
    [headerView setOpaque:YES];
    
    UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 160, 20)];
    [tempLabel setBackgroundColor:[UIColor colorWithRed:193.0f/255.0f green:201.0f/255.0f blue:212.0f/255.0f alpha:1]];
    [tempLabel setOpaque:YES];
    [tempLabel setFont:[UIFont fontWithName:@"Ubuntu-Medium" size:15.0]];
    [headerView addSubview:tempLabel];
    
    if (section == 0) {
        tempLabel.text = @"Nyttiga länkar";
    } else if (section == 1) {
        tempLabel.text = @"";
    } else {
        NSLog(@"Something went very wrong in viewForHeaderInSection...");
    }
    
    return headerView;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // Handle links
    if (indexPath.section == 0) {
        NSURL *url;
        
        switch (indexPath.row) {
            case ITSEKTIONEN:
                url = [NSURL URLWithString:@"http://it.sektionen.se/"];
                break;
            case ITFACEBOOK:
                url = [NSURL URLWithString:@"fb://profile/273652315983282"];
                if ([[UIApplication sharedApplication] canOpenURL:url]) {
                    ;
                } else {
                    url = [NSURL URLWithString:@"https://www.facebook.com/ituppsala"];
                }
                break;
            case STUDENTPORTALEN:
                url = [NSURL URLWithString:@"http://studentportalen.uu.se/"];
                break;
            case ANTAGNING:
                url = [NSURL URLWithString:@"http://antagning.se/"];
                break;
            case UTN:
                url = [NSURL URLWithString:@"http://www.utn.se"];
                break;
            default:
                break;
        }
        
        [[UIApplication sharedApplication] openURL:url];
    }
}

@end
