//
//  PhonesCategory.h
//  MantleDemo
//
//  Created by Zhou Shaolin on 11/4/14.
//  Copyright (c) 2014 Zhou Shaolin. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"
#import "MTLManagedObjectAdapter.h"

@interface PhonesCategory : MTLModel <MTLJSONSerializing, MTLManagedObjectSerializing>

@property (copy, nonatomic, readonly) NSString *categoryId;
@property (copy, nonatomic, readonly) NSString *title;

@end
