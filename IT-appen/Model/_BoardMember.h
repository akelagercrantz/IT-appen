// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BoardMember.h instead.

#import <CoreData/CoreData.h>


extern const struct BoardMemberAttributes {
	__unsafe_unretained NSString *boardMemberId;
	__unsafe_unretained NSString *imageUrl;
	__unsafe_unretained NSString *mail;
	__unsafe_unretained NSString *person;
	__unsafe_unretained NSString *postTitle;
} BoardMemberAttributes;

extern const struct BoardMemberRelationships {
} BoardMemberRelationships;

extern const struct BoardMemberFetchedProperties {
} BoardMemberFetchedProperties;








@interface BoardMemberID : NSManagedObjectID {}
@end

@interface _BoardMember : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (BoardMemberID*)objectID;





@property (nonatomic, strong) NSString* boardMemberId;



//- (BOOL)validateBoardMemberId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* imageUrl;



//- (BOOL)validateImageUrl:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* mail;



//- (BOOL)validateMail:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* person;



//- (BOOL)validatePerson:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* postTitle;



//- (BOOL)validatePostTitle:(id*)value_ error:(NSError**)error_;






@end

@interface _BoardMember (CoreDataGeneratedAccessors)

@end

@interface _BoardMember (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveBoardMemberId;
- (void)setPrimitiveBoardMemberId:(NSString*)value;




- (NSString*)primitiveImageUrl;
- (void)setPrimitiveImageUrl:(NSString*)value;




- (NSString*)primitiveMail;
- (void)setPrimitiveMail:(NSString*)value;




- (NSString*)primitivePerson;
- (void)setPrimitivePerson:(NSString*)value;




- (NSString*)primitivePostTitle;
- (void)setPrimitivePostTitle:(NSString*)value;




@end
