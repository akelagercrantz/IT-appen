#import "_Event.h"

@interface Event : _Event {}

+ (RKEntityMapping *)objectMapping;

+ (Event *)initEventInContext:(NSManagedObjectContext *)context;

- (NSString*)titleForHeader;
- (NSString*)titleForIndex;
- (NSDate *)eventDate;
- (NSString*)time;

@end
