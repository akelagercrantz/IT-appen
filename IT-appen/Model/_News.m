// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to News.m instead.

#import "_News.h"

const struct NewsAttributes NewsAttributes = {
	.author = @"author",
	.content = @"content",
	.date = @"date",
	.excerpt = @"excerpt",
	.identifier = @"identifier",
	.title = @"title",
	.url = @"url",
};

const struct NewsRelationships NewsRelationships = {
};

const struct NewsFetchedProperties NewsFetchedProperties = {
};

@implementation NewsID
@end

@implementation _News

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"News" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"News";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"News" inManagedObjectContext:moc_];
}

- (NewsID*)objectID {
	return (NewsID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"identifierValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"identifier"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic author;






@dynamic content;






@dynamic date;






@dynamic excerpt;






@dynamic identifier;



- (int16_t)identifierValue {
	NSNumber *result = [self identifier];
	return [result shortValue];
}

- (void)setIdentifierValue:(int16_t)value_ {
	[self setIdentifier:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveIdentifierValue {
	NSNumber *result = [self primitiveIdentifier];
	return [result shortValue];
}

- (void)setPrimitiveIdentifierValue:(int16_t)value_ {
	[self setPrimitiveIdentifier:[NSNumber numberWithShort:value_]];
}





@dynamic title;






@dynamic url;











@end
