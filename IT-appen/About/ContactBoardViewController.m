//
//  ContactBoardViewController.m
//  IT-sektionen 2.0
//
//  Created by Shervin Shoravi on 29/8/12.
//  Copyright (c) 2012 Shervin Shoravi. All rights reserved.
//

#import "ContactBoardViewController.h"
#import "BoardMember.h"

#define ACTIVITYINDICATOR_SIZE 20

@interface ContactBoardViewController ()

@property (nonatomic, strong) NSArray *board;

@end

@implementation ContactBoardViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self getAllBoardMembers];
    [self loadBoard];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return (self.board != nil);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.board count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BoardMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BoardMemberCell"];
    
    BoardMember *boardmember = [self.board objectAtIndex:indexPath.row];

    [cell configureCellWithBoardMember:boardmember];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setDelegate:self];
 
    return cell;
}

- (double)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
}


#pragma mark - RestKit Methods
- (void)loadBoard {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    RKResponseDescriptor *boardMembersResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[BoardMember objectMapping] method:RKRequestMethodGET pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://it.sektionen.se/bokforsaljning/board.php"]];
    
    RKManagedObjectRequestOperation *operation = [[RKManagedObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[boardMembersResponseDescriptor]];
    operation.managedObjectContext = [RKManagedObjectStore defaultStore].mainQueueManagedObjectContext;
    operation.managedObjectCache = [RKManagedObjectStore defaultStore].managedObjectCache;

    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        [self getAllBoardMembers];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }];
    
    [operation start];
}

- (void)getAllBoardMembers {
    NSManagedObjectContext *context = [[RKManagedObjectStore defaultStore] mainQueueManagedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"BoardMember"];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"boardMemberId" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    NSError *error;
    self.board = [context executeFetchRequest:fetchRequest error:&error];
    
    if (error) {
        NSLog(@"Something went wrong when loading board members: %@", error);
    }
    
    [self.tableView reloadData];
}

- (void)sendMailButtonPressedFor:(NSString *)boardMemberMail {
    MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
	mail.mailComposeDelegate = self;
	
	// Set up recipients
    [mail setToRecipients:@[boardMemberMail]];
    //@[[[self.board objectAtIndex:indexPath.row] valueForKey:@"mail"]]
	//[mail setToRecipients:[self.board objectAtIndex:indexPath.row] objectForKey:@"mail"]]];
	
	//[self presentModalViewController:mail animated:YES];
    [self presentViewController:mail animated:YES completion:nil];
}

#pragma mark - MFMailComposeDelegate

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end
