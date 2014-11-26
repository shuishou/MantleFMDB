//
//  DMRow.h
//  MantleDemo
//
//  Created by Zhou Shaolin on 11/7/14.
//  Copyright (c) 2014 Zhou Shaolin. All rights reserved.
//

#import "FMTLModel.h"

@interface DMRow : FMTLModel

@property (strong, nonatomic) NSString *identifier;
@property (strong, nonatomic, readonly) NSString *headline;
@property (strong, nonatomic, readonly) NSString *detail;

@end
