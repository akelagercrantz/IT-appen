#import "News.h"


@interface News ()

// Private interface goes here.

@end


@implementation News

+ (RKEntityMapping *)objectMapping {
    RKEntityMapping *mapping = [RKEntityMapping mappingForEntityForName:@"News" inManagedObjectStore:[RKManagedObjectStore defaultStore]];
    
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"title": @"title",
                                                  @"content": @"content",
                                                  @"id": @"identifier",
                                                  @"url": @"url",
                                                  @"excerpt": @"excerpt",
                                                  @"author.nickname": @"author",
                                                  @"date": @"date"}];
    
    mapping.identificationAttributes = @[ @"identifier" ];
    
    return mapping;
}

- (NSString *) authorDateString {
    return [NSString stringWithFormat:@"Skrivet av %@ den %@", [self author], [self date]];
}

+ (News *)newsWithUniqueId:(NSNumber *)identifier inManagedObjectContext:(NSManagedObjectContext *)context
{
    News *news = nil;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    request.entity = [NSEntityDescription entityForName:@"News" inManagedObjectContext:context];
    request.predicate = [NSPredicate predicateWithFormat:@"identifier = %@", identifier];
    NSError *executeFetchError = nil;
    news = [[context executeFetchRequest:request error:&executeFetchError] lastObject];
    
    if (executeFetchError) {
        NSLog(@"[%@, %@] error looking up ean with id: %@ with error: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), identifier, [executeFetchError localizedDescription]);
    } else if (!news) {
        news = [NSEntityDescription insertNewObjectForEntityForName:@"Entry"
                                              inManagedObjectContext:context];
        news.identifier = identifier;
    }
    
    return news;
}

@end
