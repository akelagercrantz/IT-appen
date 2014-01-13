// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Event.m instead.

#import "_Event.h"

const struct EventAttributes EventAttributes = {
	.endDate = @"endDate",
	.endTime = @"endTime",
	.equipment = @"equipment",
	.group = @"group",
	.location = @"location",
	.name = @"name",
	.note = @"note",
	.organiser = @"organiser",
	.programmes = @"programmes",
	.startDate = @"startDate",
	.startTime = @"startTime",
	.type = @"type",
};

const struct EventRelationships EventRelationships = {
};

const struct EventFetchedProperties EventFetchedProperties = {
};

@implementation EventID
@end

@implementation _Event

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Event";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Event" inManagedObjectContext:moc_];
}

- (EventID*)objectID {
	return (EventID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic endDate;






@dynamic endTime;






@dynamic equipment;






@dynamic group;






@dynamic location;






@dynamic name;






@dynamic note;






@dynamic organiser;






@dynamic programmes;






@dynamic startDate;






@dynamic startTime;






@dynamic type;











@end
