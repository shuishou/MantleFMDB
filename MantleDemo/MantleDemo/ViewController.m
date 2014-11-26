//
//  ViewController.m
//  MantleDemo
//
//  Created by Zhou Shaolin on 11/4/14.
//  Copyright (c) 2014 Zhou Shaolin. All rights reserved.
//

#import "ViewController.h"
#import "PhonesCategory.h"
#import "UserModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testCreateModelWithJSONDictionary];
    [self testSerializationOfPrimitives];
    // Do any additional setup after loading the view, typically from a nib.
}

- (id)jsonStringToObject:(NSString*)jsonString
{
    
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    
    id object = [NSJSONSerialization JSONObjectWithData:data
                 
                                             options:NSJSONReadingAllowFragments
                 
                                               error:&error];
    
    return object;
    
}

- (void)testCreateModelWithJSONDictionary
{
    NSError *jsonError = nil;
    NSDictionary* JSONModelDictionary = [self jsonStringToObject:@"{\"id\":\"cateId\", \"title\": \"Category title\"}"];
    
//    NSDictionary *JSONModelDictionary = @{
//                                          @"id"     : @"catId",
//                                          @"title"  : @"Category title"
//                                          };
    
    NSError *error;
    PhonesCategory *category = [MTLJSONAdapter modelOfClass:[PhonesCategory class] fromJSONDictionary:JSONModelDictionary error:&error];
    
    PhonesCategory *testCategory = [[PhonesCategory alloc] initWithDictionary: JSONModelDictionary
                                                           error: &error];
    int a = 0;
    a++;
    
}


- (void)testSerializationOfPrimitives
{
    NSError *error = nil;
    
    
    
    
    NSDictionary *json = @{@"on" : @YES,
                           @"id" : @3,
                           @"zPos" : @7.4f,
                           @"xyPosString" : NSStringFromCGPoint((CGPoint){20, 20})};
    
    UserModel *testModel = [[UserModel alloc] initWithDictionary: json
                                                           error: &error];
    // This is how you create a model from JSON, not initWithDictionary: !!
    UserModel *jsonModel = [MTLJSONAdapter modelOfClass:[UserModel class] fromJSONDictionary:json error:&error];
    
    // Here we see that it also works fine with Serialization / Deserialization
    NSData *modelData = [NSKeyedArchiver archivedDataWithRootObject:jsonModel];
    UserModel* model = [NSKeyedUnarchiver unarchiveObjectWithData:modelData];
    int a = 0;
    a++;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
