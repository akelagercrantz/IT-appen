#import "Event.h"

@implementation Event

+ (Event *)initEventInContext:(NSManagedObjectContext *)context {
    Event *event = [NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:context];
    
    return event;
}

+ (RKEntityMapping *)objectMapping {
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"HH:mm"];
    [[RKValueTransformer defaultValueTransformer] insertValueTransformer:timeFormatter atIndex:0];
    
    RKEntityMapping *mapping = [RKEntityMapping mappingForEntityForName:@"Event" inManagedObjectStore:[RKManagedObjectStore defaultStore]];
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"kommentar": @"note",
                                                  @"kurs": @"name",
                                                  @"kursgrupp": @"group",
                                                  @"lärare": @"organiser",
                                                  @"lokal": @"location",
                                                  @"moment": @"type",
                                                  @"program": @"programmes",
                                                  @"slutdatum": @"endDate",
                                                  @"sluttid": @"endTime",
                                                  @"startdatum": @"startDate",
                                                  @"starttid": @"startTime",
                                                  @"utrustning": @"equipment"
                                                  }];
    [mapping setIdentificationAttributes:@[@"startDate", @"startTime"]];
    
    return mapping;
}

- (NSString *)titleForHeader {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"sv_SE"]];
    [dateFormatter setDateFormat:@"EEEE, d MMMM"];
    return [dateFormatter stringFromDate:[self startDate]];
}

- (NSString *)titleForIndex {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"sv_SE"]];
    [dateFormatter setDateFormat:@"d/M"];
    
    return [dateFormatter stringFromDate:[self startDate]];
}

- (NSDate *)eventDate {
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:unitFlags fromDate:self.startDate];
    NSDate *tempDate = [[NSCalendar currentCalendar] dateFromComponents:components];
    
    unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    components = [[NSCalendar currentCalendar] components:unitFlags fromDate:self.startTime];
    tempDate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:tempDate options:0];
    
    return tempDate;
}

- (NSString *)time {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *startTime = [dateFormatter stringFromDate:[self startTime]];
    NSString *endTime = [dateFormatter stringFromDate:[self endTime]];
    
    NSString *time = [[NSArray arrayWithObjects:startTime, endTime, nil] componentsJoinedByString:@"-"];
    
    return time;
}

@end
