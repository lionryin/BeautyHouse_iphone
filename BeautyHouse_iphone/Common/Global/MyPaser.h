

#import <UIKit/UIKit.h>

typedef enum {
    returnType,
    noneType
} NodeType;


@interface MyPaser : NSObject<NSXMLParserDelegate>

@property (nonatomic, strong) NSString* content;
@property (nonatomic, strong) NSXMLParser* parser;

@property NodeType CurrentType;

@property (strong, nonatomic) NSMutableString *result;


-(id) initWithContent:(NSString*) aContent;
-(void) BeginToParse;

@end
