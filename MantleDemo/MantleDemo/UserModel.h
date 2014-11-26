//
//  UserModel.h
//  MantleDemo
//
//  Created by Zhou Shaolin on 11/4/14.
//  Copyright (c) 2014 Zhou Shaolin. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"
#import <CoreGraphics/CGGeometry.h>

@interface UserModel : MTLModel<MTLJSONSerializing>
@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, assign) NSUInteger index;
@property (nonatomic, assign) float z;
@property (nonatomic, assign) CGPoint position;
@end
