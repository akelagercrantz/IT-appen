// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BoardMember.m instead.

#import "_BoardMember.h"

const struct BoardMemberAttributes BoardMemberAttributes = {
	.boardMemberId = @"boardMemberId",
	.imageUrl = @"imageUrl",
	.mail = @"mail",
	.person = @"person",
	.postTitle = @"postTitle",
};

const struct BoardMemberRelationships BoardMemberRelationships = {
};

const struct BoardMemberFetchedProperties BoardMemberFetchedProperties = {
};

@implementation BoardMemberID
@end

@implementation _BoardMember

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"BoardMember" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"BoardMember";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"BoardMember" inManagedObjectContext:moc_];
}

- (BoardMemberID*)objectID {
	return (BoardMemberID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic boardMemberId;






@dynamic imageUrl;






@dynamic mail;






@dynamic person;






@dynamic postTitle;











@end
