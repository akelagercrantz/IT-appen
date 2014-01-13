//
//  TimetableViewController.m
//  IT-sektionen 2.0
//
//  Created by Åke Lagercrantz on 2012-09-06.
//  Copyright (c) 2012 Shervin Shoravi. All rights reserved.
//

#import "TimetableViewController.h"
#import "TimetableCell.h"
#import "TimetableHeaderView.h"
#import "Event.h"

static NSString * const SelectedClassKey = @"SELECTED_CLASS";

@interface TimetableViewController()

@property (weak, nonatomic) IBOutlet UIButton *chooseClassButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshButton;
@property (weak, nonatomic) IBOutlet UIButton *nextClassButton;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@property (nonatomic, strong) NSMutableArray *sectionHeaderArray;
@property (nonatomic, strong) NSArray *nextClasses;
@property (nonatomic, strong) NSIndexPath *nextClass;

@property (nonatomic, strong) UIView *selectClassView;
@property (nonatomic, strong) UISegmentedControl *classSelector;
@property (nonatomic, strong) NSString *selectedClass;
@property (nonatomic, strong) TimetableParser *timeTableParser;

@property (nonatomic) BOOL choosingClass;


@end

@implementation TimetableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpClassPicker];
    
    NSString *selectedClass = [[NSUserDefaults standardUserDefaults] valueForKey:SelectedClassKey];
    
    if (selectedClass) {
        [self.chooseClassButton setTitle:selectedClass forState:UIControlStateNormal];
        self.selectedClass = selectedClass;
        [self.timeTableParser fetchScheduleFor:self.selectedClass];
    }
    
    [self performFetchRequest];
}

- (NSMutableArray *)sectionHeaderArray {
    if (!_sectionHeaderArray) {
        _sectionHeaderArray = [[NSMutableArray alloc] init];
    }
    
    return _sectionHeaderArray;
}

#pragma mark - TimetableParser methods & delegate

- (TimetableParser *)timeTableParser {
    if (!_timeTableParser) {
        _timeTableParser = [[TimetableParser alloc] init];
        _timeTableParser.delegate = self;
    }
    
    return _timeTableParser;
}

- (void)scheduleHasBeenParsed {

}

- (void)errorWhileFetchingSchedule {
    
}

- (IBAction)refresh:(id)sender {
    [self.timeTableParser refresh];
}

- (void)performFetchRequest {
    NSError *error;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error: %@, %@", error, [error localizedDescription]);
    }
}

#pragma mark - Class picker

- (void)setUpClassPicker {
    [self.chooseClassButton.titleLabel setFont:[UIFont fontWithName:@"Ubuntu" size:17.0f]];
    CALayer *layer = self.chooseClassButton.layer;
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:6.0f];
    [layer setBorderColor:[[UIColor whiteColor] CGColor]];
    [layer setBorderWidth:1];
    [self.chooseClassButton setOpaque:YES];
    
    [self.nextClassButton.titleLabel setFont:[UIFont fontWithName:@"Ubuntu" size:12.0f]];
    CGRect nextButtonFrame = self.nextClassButton.frame;
    nextButtonFrame.origin.x = 10.0;
    nextButtonFrame.origin.y = 8;
    self.nextClassButton.frame = nextButtonFrame;
    [self.nextClassButton setOpaque:YES];
    
    self.selectClassView = [[UIView alloc] initWithFrame:CGRectMake(0, 64.0f, self.view.frame.size.width, 0)];
    [self.selectClassView setBackgroundColor:[UIColor colorWithRed:50.0f/255.0f green:77.0f/255.0f blue:113.0f/255.0f alpha:1]];
    self.selectClassView.alpha = 1;
    self.selectClassView.opaque = YES;
    
    self.classSelector = [[UISegmentedControl alloc] initWithItems:@[@"IT1", @"IT2", @"IT3", @"IT4"]]; //, @"IT5"
    CGRect frame = self.classSelector.frame;
    frame.size.height = 26.0f;
    frame.size.width = self.selectClassView.frame.size.width - 32;
    frame.origin.x = 17.0f;
    frame.origin.y = 7.0f;
    self.classSelector.frame = frame;
    
    self.classSelector.tintColor = [UIColor whiteColor];
    self.classSelector.alpha = 0;
    [self.selectClassView addSubview:self.classSelector];
    
    [self.classSelector addTarget:self action:@selector(handleClassChange:) forControlEvents:UIControlEventValueChanged];
    [self.navigationController.view addSubview:self.selectClassView];
}

- (IBAction)chooseClassButton:(id)sender {
    if (!self.choosingClass) {
        self.choosingClass = YES;
        [UIView animateWithDuration:0.30
                              delay:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             CGRect frame = self.selectClassView.frame;
                             frame.size.height = 40.0f;
                             self.selectClassView.frame = frame;
                             frame = self.tableView.frame;
                             frame.origin.y += 40.0f;
                             self.tableView.frame = frame;
                             self.classSelector.alpha = 1;
                         } completion:nil];
    } else {
        self.choosingClass = NO;
        [UIView animateWithDuration:0.30
                              delay:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             self.classSelector.alpha = 0;
                             CGRect frame = self.selectClassView.frame;
                             frame.size.height = 0.0f;
                             self.selectClassView.frame = frame;
                             frame = self.tableView.frame;
                             frame.origin.y -= 40.0f;
                             self.tableView.frame = frame;
                         } completion:nil];
    }
}

- (void)handleClassChange:(id)sender {
    UISegmentedControl *segCon = (UISegmentedControl *)sender;
    
    [self.chooseClassButton setTitle:[NSString stringWithFormat:@"%@",[segCon titleForSegmentAtIndex:[segCon selectedSegmentIndex]]] forState:UIControlStateNormal];
    
    self.selectedClass = [segCon titleForSegmentAtIndex:[segCon selectedSegmentIndex]];
    
    [self chooseClassButton:nil];
    [self.timeTableParser refresh];
}

// Saving our choice for the future
- (void)setSelectedClass:(NSString *)selectedClass {
    if (![_selectedClass isEqualToString:selectedClass]) {
        [[NSUserDefaults standardUserDefaults] setObject:selectedClass forKey:SelectedClassKey];
        _selectedClass = selectedClass;
    }
}

#pragma mark - NSFetchedResultsController methods

- (NSManagedObjectContext *)managedObjectContext {
    if (!_managedObjectContext) {
        _managedObjectContext = [[RKManagedObjectStore defaultStore] mainQueueManagedObjectContext];
    }
    
    return _managedObjectContext;
}

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:[self managedObjectContext]];
    
    [fetchRequest setEntity:entity];
    [fetchRequest setFetchBatchSize:20];
    
    NSSortDescriptor *dateDescriptor = [[NSSortDescriptor alloc] initWithKey:@"startDate" ascending:YES];
    NSSortDescriptor *timeDescriptor = [[NSSortDescriptor alloc] initWithKey:@"startTime" ascending:YES];
    [fetchRequest setSortDescriptors:@[dateDescriptor, timeDescriptor]];
    
    NSFetchedResultsController *fetchResultController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[self managedObjectContext] sectionNameKeyPath:@"startDate" cacheName:nil];
    self.fetchedResultsController = fetchResultController;
    self.fetchedResultsController.delegate = self;
    
    return self.fetchedResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    UITableView *tableView = self.tableView;
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationNone];
            break;
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationNone];
            break;
        case NSFetchedResultsChangeUpdate:
            [self.tableView cellForRowAtIndexPath:indexPath];
            break;
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationNone];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationNone];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id )sectionInfo
           atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type {
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationNone];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationNone];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger sections = [[self.fetchedResultsController sections] count];
    return sections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    TimetableHeaderView *headerView = [[TimetableHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 25.0f)];
    
    Event *event = [[[[self.fetchedResultsController sections] objectAtIndex:section] objects] objectAtIndex:0];
    [headerView setDateLabelForEvent:event];
    
    if (section != 0) {
        NSString *previousSection = [[[self.fetchedResultsController sections] objectAtIndex:section-1] name];
        NSString *currentSection = [[[self.fetchedResultsController sections] objectAtIndex:section] name];
        
        if (![previousSection isEqualToString:currentSection]) {
            [headerView setDateLabelForEvent:event];
        }
    }
    
    [self.sectionHeaderArray addObject:headerView];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TimetableCell";
    TimetableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    Event *event = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    [cell configureCellWithEvent:event];
    
    /*
    if ([self.nextClasses containsObject:indexPath]) {
        cell.backgroundColor = [UIColor colorWithRed:223.0f/255.0f green:231.0f/255.0f blue:242.0f/255.0f alpha:1];
    }
    */
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Scrolling and indices

- (IBAction)scrollToNextEvent:(id)sender {
    self.nextClasses = [self indexPathsForUpcomingEvents];
    if ([[self.fetchedResultsController fetchedObjects] count] > 0 && [self.nextClasses count] > 0) {
        [self.tableView scrollToRowAtIndexPath:[self.nextClasses lastObject] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

- (NSArray *)indexPathsForUpcomingEvents {
    NSDate *currentDate = [NSDate date];
    NSDate *upcomingEventDate;
    
    NSMutableArray *upcomingEvents = [[NSMutableArray alloc] init];
    BOOL found = NO;
    
    for (Event* event in [self.fetchedResultsController fetchedObjects]) {
        // The first event with a date larger than now.
        if ((!found && [[event eventDate] compare:currentDate] == NSOrderedDescending)) {
            [upcomingEvents addObject:[self.fetchedResultsController indexPathForObject:event]];
            found = YES;
            upcomingEventDate = [event eventDate];
        } else if (found && [[event eventDate] compare:upcomingEventDate] == NSOrderedSame) {
            // There might be several events with the same start date, mark them all.
            [upcomingEvents addObject:[self.fetchedResultsController indexPathForObject:event]];
        } else if (found) {
            // No more events with the same start date, no need to keep going.
            break;
        }
    }
    return [upcomingEvents copy];
}

@end