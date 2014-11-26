//
//  FMTLModel.h
//  MantleDemo
//
//  Created by Zhou Shaolin on 11/7/14.
//  Copyright (c) 2014 Zhou Shaolin. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@class FMResultSet;
@class FMDatabaseQueue;

@interface FMTLModel : MTLModel<MTLJSONSerializing>

+(NSString *)databasePath;
+(NSString *)databaseFilename;
+(void)createTable:(FMDatabaseQueue *)dbQueue;
+(NSString *)tableName;
+(NSString *)primaryKey;

+(id)unpack:(FMResultSet *)resultSet; // private.

+(void)fetchAll:(FMDatabaseQueue *)dbQueue results:(void(^)(NSArray *))resultsHandler;
+(void)load:(NSString *)primaryKey queue:(FMDatabaseQueue *)dbQueue results:(void(^)(id result))resultHandler;
+(void)remove:(NSString *)primaryKey dbQueue:(FMDatabaseQueue *)dbQueue;

-(void)save:(FMDatabaseQueue *)dbQueue;
-(void)remove:(FMDatabaseQueue *)dbQueue;

@end
