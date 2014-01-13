#import "_News.h"

@interface News : _News {}

+ (RKEntityMapping *)objectMapping;
+ (News *)newsWithUniqueId:(NSNumber *)identifier inManagedObjectContext:(NSManagedObjectContext *)context;

@end
