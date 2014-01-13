// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to News.h instead.

#import <CoreData/CoreData.h>


extern const struct NewsAttributes {
	__unsafe_unretained NSString *author;
	__unsafe_unretained NSString *content;
	__unsafe_unretained NSString *date;
	__unsafe_unretained NSString *excerpt;
	__unsafe_unretained NSString *identifier;
	__unsafe_unretained NSString *title;
	__unsafe_unretained NSString *url;
} NewsAttributes;

extern const struct NewsRelationships {
} NewsRelationships;

extern const struct NewsFetchedProperties {
} NewsFetchedProperties;










@interface NewsID : NSManagedObjectID {}
@end

@interface _News : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (NewsID*)objectID;





@property (nonatomic, strong) NSString* author;



//- (BOOL)validateAuthor:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* content;



//- (BOOL)validateContent:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* date;



//- (BOOL)validateDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* excerpt;



//- (BOOL)validateExcerpt:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* identifier;



@property int16_t identifierValue;
- (int16_t)identifierValue;
- (void)setIdentifierValue:(int16_t)value_;

//- (BOOL)validateIdentifier:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* title;



//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* url;



//- (BOOL)validateUrl:(id*)value_ error:(NSError**)error_;






@end

@interface _News (CoreDataGeneratedAccessors)

@end

@interface _News (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveAuthor;
- (void)setPrimitiveAuthor:(NSString*)value;




- (NSString*)primitiveContent;
- (void)setPrimitiveContent:(NSString*)value;




- (NSDate*)primitiveDate;
- (void)setPrimitiveDate:(NSDate*)value;




- (NSString*)primitiveExcerpt;
- (void)setPrimitiveExcerpt:(NSString*)value;




- (NSNumber*)primitiveIdentifier;
- (void)setPrimitiveIdentifier:(NSNumber*)value;

- (int16_t)primitiveIdentifierValue;
- (void)setPrimitiveIdentifierValue:(int16_t)value_;




- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;




- (NSString*)primitiveUrl;
- (void)setPrimitiveUrl:(NSString*)value;




@end
