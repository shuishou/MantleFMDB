//
//  DMRow.m
//  FlyingMantle
//
//  Created by Zhou Shaolin on 11/7/14.
//  Copyright (c) 2014 Zhou Shaolin. All rights reserved.
//

#import "DMRow.h"

@implementation DMRow

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{@"headline"  : @"headline"};
}

-(NSString*)description
{
    NSDictionary* dict = [MTLJSONAdapter JSONDictionaryFromModel: self];
    if ([NSJSONSerialization isValidJSONObject:dict])
        
    {
        
        NSError *error;
        
        //创超一个json从Data,NSJSONWritingPrettyPrinted指定的JSON数据产的空白，使输出更具可读性
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                            
                                                        options:NSJSONWritingPrettyPrinted
                            
                                                          error:&error];
        
        NSString *jsonString = [[NSString alloc]initWithData:jsonData
                                
                                                    encoding:NSUTF8StringEncoding];
        
        return jsonString;
        
    }
    else {
        return @"";
    }
}

@end
