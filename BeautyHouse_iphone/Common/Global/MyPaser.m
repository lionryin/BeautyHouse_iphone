//
//  myPaser.m
//  Word4S
//
//  Created by m on 12-4-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MyPaser.h"

@interface MyPaser ()


@end

@implementation MyPaser
{
    BOOL success;
}


-(id) initWithContent:(NSString*) aContent
{
    if ([super init]) {
        self.content = aContent;
        self.parser = [[NSXMLParser alloc] initWithData:
                       [_content dataUsingEncoding:NSUTF8StringEncoding]];
        _parser.delegate = self;
        _CurrentType = noneType;
        _result = [[NSMutableString alloc] init];
    }
    return self; 
}

-(void) BeginToParse 
{
    [_parser parse];
}

#pragma mark - 
#pragma mark XML delegate methods 

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    //NSLog(@"start element:%@",elementName);
    
    if ([elementName isEqualToString:@"return"]) {
        _CurrentType = returnType;
    }
}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    //NSLog(@"character:%@",string);
    if (_CurrentType == returnType) {
       // NSLog(@"character:%@",string);
        [_result appendString:string];
    }

}

-(void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if (_CurrentType == returnType) {
        //NSLog(@"string:%@",_result);
        
        
    }
    
    
}

@end
