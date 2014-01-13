//
//  TimetableParser.m
//  IT-appen
//
//  Created by Farshid Besharati on 2013-10-30.
//  Copyright (c) 2013 IT-sektionen. All rights reserved.
//

#define scheduleUrl "https://se.timeedit.net/web/uu/db1/schema/ri.csv?sid=3&\
objects=%@&p=0.d,4.w&ox=0&types=0&fe=0" // CSV URL

#define IT1 "251065.207" // Object ID's
#define IT2 "251067.207" //
#define IT3 "251068.207" //
#define IT4 "251069.207" //
#define IT5 "251070.207" //

#import "TimetableParser.h"
#import "AFNetworking.h"
#import "Event.h"

static NSString * const SelectedClassKey = @"SELECTED_CLASS";

@interface TimetableParser()

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSString *currentClass;
@property (nonatomic, strong) NSArray *eventArray;
@property (nonatomic) BOOL successFlag;

@end

@implementation TimetableParser

- (NSManagedObjectContext *)managedObjectContext {
    if (!_managedObjectContext) {
        _managedObjectContext = [[RKManagedObjectStore defaultStore] mainQueueManagedObjectContext];
    }
    
    return _managedObjectContext;
}

- (id)init {
    self = [super init];
    
    if (self) {
        self.eventArray = [self populateEventArray];
    }
    
    return self;
}

- (void)refresh {
    self.currentClass = [[NSUserDefaults standardUserDefaults] valueForKey:SelectedClassKey];
    [self fetchScheduleFor:self.currentClass];
}

- (void)fetchScheduleFor:(NSString *)class {
    [self clearDatabase];
    NSString *urlString = [NSString stringWithFormat:@"http://schema.besharati.se/schedule/%@/", class];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    RKResponseDescriptor *scheduleResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[Event objectMapping] method:RKRequestMethodGET pathPattern:nil keyPath:@"classes" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    RKManagedObjectRequestOperation *operation = [[RKManagedObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[scheduleResponseDescriptor]];
    operation.managedObjectContext = [RKManagedObjectStore defaultStore].mainQueueManagedObjectContext;
    operation.managedObjectCache = [RKManagedObjectStore defaultStore].managedObjectCache;
    
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
        NSLog(@"Successfully mapped Events!");
        self.successFlag = YES;
        self.eventArray = [self populateEventArray];
        [self.delegate scheduleHasBeenParsed];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"Failed with error: %@", [error localizedDescription]);
        [self.delegate errorWhileFetchingSchedule];
    }];
    
    [operation start];
}

- (NSArray *)populateEventArray {
    NSManagedObjectContext *context = self.managedObjectContext;
    NSFetchRequest *fetchReq = [[NSFetchRequest alloc] initWithEntityName:@"Event"];
    
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchReq error:&error];
    
    return fetchedObjects;
}

- (void)clearDatabase {
    NSManagedObjectContext *context = self.managedObjectContext;
    NSFetchRequest *fetchReq = [[NSFetchRequest alloc] initWithEntityName:@"Event"];
    
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchReq error:&error];
    for (Event *event in fetchedObjects) {
        [self.managedObjectContext deleteObject:event];
    }
    
    if (![self.managedObjectContext saveToPersistentStore:&error]) {
        NSLog(@"Error while deleting: %@", error);
    }
}

#pragma mark - Background updating

- (void)updateDatabaseUsingFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    if ([[NSUserDefaults standardUserDefaults] valueForKey:SelectedClassKey]) {
        [self fetchScheduleFor:self.currentClass];
    }
    
    if (self.successFlag) {
        self.successFlag = NO;
        completionHandler(UIBackgroundFetchResultNewData);
    } else {
        completionHandler(UIBackgroundFetchResultFailed);
    }
}

@end
