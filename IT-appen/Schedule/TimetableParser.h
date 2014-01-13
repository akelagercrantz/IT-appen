//
//  TimetableParser.h
//  IT-appen
//
//  Created by Farshid Besharati on 2013-10-30.
//  Copyright (c) 2013 IT-sektionen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TimeTableParserDelegate <NSObject>

- (void)scheduleHasBeenParsed;
- (void)errorWhileFetchingSchedule;

@end

@interface TimetableParser : NSObject

- (void)fetchScheduleFor:(NSString *)class;
- (void)refresh;

- (void)updateDatabaseUsingFetchWithCompletionHandler:(void (^) (UIBackgroundFetchResult))completionHandler;

@property (nonatomic, weak) id <TimeTableParserDelegate> delegate;

@end
