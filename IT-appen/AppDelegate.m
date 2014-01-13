//
//  AppDelegate.m
//  IT-appen
//
//  Created by Farshid Besharati on 2013-10-29.
//  Copyright (c) 2013 IT-sektionen. All rights reserved.
//

static NSString * const SelectedClassKey = @"SELECTED_CLASS";

#import "AppDelegate.h"
#import "News.h"
#import "Event.h"
#import "BoardMember.h"
#import "TimetableParser.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Set TabBar colors
    [[UITabBar appearance] setBackgroundColor:[UIColor colorWithRed:50.0f/255.0f green:77.0f/255.0f blue:113.0f/255.0f alpha:1]];
    [[UITabBar appearance] setBarTintColor:[UIColor colorWithRed:50.0f/255.0f green:77.0f/255.0f blue:113.0f/255.0f alpha:1]];
    
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Ubuntu" size:10.0f],
                                                        NSForegroundColorAttributeName: [UIColor whiteColor]}
                                             forState:UIControlStateSelected];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Ubuntu" size:10.0f],
                                                        NSForegroundColorAttributeName: [UIColor colorWithRed:193.0f/255.0f green:201.0f/255.0f blue:212.0f/255.0f alpha:1]
                                                        } forState:UIControlStateNormal];
    
    UITabBarController *controller = (UITabBarController *)self.window.rootViewController;
    UITabBarItem *schedule = [controller.tabBar.items objectAtIndex:0];
    [schedule setImage:[[UIImage imageNamed:@"timetableIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    UITabBarItem *news = [controller.tabBar.items objectAtIndex:1];
    [news setImage:[[UIImage imageNamed:@"newsIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    UITabBarItem *about = [controller.tabBar.items objectAtIndex:2];
    [about setImage:[[UIImage imageNamed:@"infoIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    //Enable background fetching
    [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:10800];
    
    // Set NavBar colors and fonts
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:50.0f/255.0f green:77.0f/255.0f blue:113.0f/255.0f alpha:1]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Ubuntu" size:17.0f], NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    // Initialize RestKit here
    NSURL *baseURL = [NSURL URLWithString:@"http://it.sektionen.se/"];
    RKObjectManager *objectManager = [RKObjectManager managerWithBaseURL:baseURL];
    
    // Enable Activity Indicator Spinner
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    // Initialize managed object store
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    objectManager.managedObjectStore = managedObjectStore;
    
    [managedObjectStore createPersistentStoreCoordinator];
    NSString *storePath = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"ITAppen.sqlite"];
    NSString *seedPath = [[NSBundle mainBundle] pathForResource:@"RKSeedDatabase" ofType:@"sqlite"];
    NSError *error;
    NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption: @(NO), NSInferMappingModelAutomaticallyOption: @(NO)};
    NSPersistentStore *persistentStore = [managedObjectStore addSQLitePersistentStoreAtPath:storePath fromSeedDatabaseAtPath:seedPath withConfiguration:nil options:options error:&error];
    NSAssert(persistentStore, @"Failed to add persistent store with error: %@", error);
    
    // Create the managed object contexts
    [managedObjectStore createManagedObjectContexts];
    
    // Configure a managed object cache to ensure we do not create duplicate objects
    managedObjectStore.managedObjectCache = [[RKInMemoryManagedObjectCache alloc] initWithManagedObjectContext:managedObjectStore.persistentStoreManagedObjectContext];
    
    //[self addResponseDescriptorForNews];
    [self addResponseDescriptorForBoardMembers];
    
    return YES;
}
/*
- (void)addResponseDescriptorForSchedule {
    RKResponseDescriptor *newsResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[Event objectMapping] method:RKRequestMethodGET pathPattern:nil keyPath:@"classes" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
#warning implement this! :D
}
*/
- (void)addResponseDescriptorForNews {
    RKResponseDescriptor *newsResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[News objectMapping] method:RKRequestMethodGET pathPattern:nil keyPath:@"posts" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [[RKObjectManager sharedManager] addResponseDescriptor:newsResponseDescriptor];
}

- (void)addResponseDescriptorForBoardMembers {
    RKResponseDescriptor *boardMembersResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:[BoardMember objectMapping] method:RKRequestMethodGET pathPattern:@"bokforsaljning/board.php" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [[RKObjectManager sharedManager] addResponseDescriptor:boardMembersResponseDescriptor];
}

- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    TimetableParser *parser = [[TimetableParser alloc] init];
    [parser updateDatabaseUsingFetchWithCompletionHandler:completionHandler];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}
@end
