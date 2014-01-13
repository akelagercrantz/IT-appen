#import "BoardMember.h"


@interface BoardMember ()

// Private interface goes here.

@end


@implementation BoardMember


+ (RKEntityMapping *)objectMapping {
    RKEntityMapping *mapping = [RKEntityMapping mappingForEntityForName:@"BoardMember" inManagedObjectStore:[RKManagedObjectStore defaultStore]];
    
    [mapping addAttributeMappingsFromDictionary:@{
                                                  @"id": @"boardMemberId",
                                                  @"imageUrl": @"imageUrl",
                                                  @"mail": @"mail",
                                                  @"person": @"person",
                                                  @"title": @"postTitle"}];
    
    mapping.identificationAttributes = @[ @"boardMemberId" ];
    
    return mapping;
}

@end
