//
//  UserModel.m
//  MantleDemo
//
//  Created by Zhou Shaolin on 11/4/14.
//  Copyright (c) 2014 Zhou Shaolin. All rights reserved.
//

#import "UserModel.h"
#import "MTLValueTransformer.h"
#import <UIKit/UIGeometry.h>

@implementation UserModel
+ (NSDictionary*)JSONKeyPathsByPropertyKey
{
    return @{@"enabled": @"on",  // a BOOL in JSON
             @"index" : @"id",  // a NSNumber in JSON
             @"z" : @"zPos",  // a NSNumber in JSON
             @"position" : @"xyPosString"};  // assume I get a point from my JSON response but it's in a string format
}

// Not even sure if I need this.  Actually I don't.  I believe if the JSON returned it as a string I would  need this.
//+ (NSValueTransformer*)enabledJSONTransformer
//{
//    return [NSValueTransformer valueTransformerForName:@"MTLURLValueTransformerName"];
//}

// this I need however because otherwise Mantle won't know what to do with the string that should become a CGPoint.
// notice I return an NSValue and also assume that when the CGPoint is converted to a string, it is already a NSValue
+ (NSValueTransformer*)positionJSONTransformer
{
    MTLValueTransformerBlock forwardBlock = (id)^(NSString* positionString) {
        
        CGPoint point = CGPointFromString(positionString);
        return [NSValue valueWithCGPoint:point];
        
    };
    
    MTLValueTransformerBlock reverseBlock = (id)^(NSValue *position) {
        return NSStringFromCGPoint(position.CGPointValue);
    };
    
    return [MTLValueTransformer reversibleTransformerWithForwardBlock: forwardBlock reverseBlock:reverseBlock];
   // return [MTLValueTransformer reversibleTransformerWithBlock:nil reverseBlock:nil];
}
@end
