//
//  FMTLModel.m
//  MantleDemo
//
//  Created by Zhou Shaolin on 11/7/14.
//  Copyright (c) 2014 Zhou Shaolin. All rights reserved.
//

#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "FMTLModel.h"
#import "MTLJSONAdapter.h"

@implementation FMTLModel

#pragma mark - Metadata

+(NSString *)databasePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:[self databaseFilename]];
    //NSFileManager *fileManager = [NSFileManager defaultManager];
    //NSLog(@"%@", writableDBPath);
    return writableDBPath;
}

+(NSString *)databaseFilename {
    return @"FlyingMantle.sqlite";
}

+(void)createTable:(FMDatabaseQueue *)dbQueue {
    [dbQueue inDatabase:^(FMDatabase *db) {
        NSString *createStatement = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (%@ INTEGER PRIMARY KEY UNIQUE, value BLOB)", [self tableName], [self primaryKey]];
        [db executeUpdate:createStatement];
    }];
}

+(NSString *)tableName {
    return NSStringFromClass(self);
}

+(NSString *)primaryKey {
    return @"identifier";
}

#pragma mark - List, query

+(void)fetchAll:(FMDatabaseQueue *)dbQueue results:(void(^)(NSArray *))resultsHandler {
    [dbQueue inDatabase:^(FMDatabase *db){
        NSString *fetchStatement = [NSString stringWithFormat:@"SELECT * FROM %@", [self tableName]];
        FMResultSet *rs = [db executeQuery:fetchStatement];
        NSMutableArray *results = [NSMutableArray array];
        while ([rs next]) {
            id unpacked = [self unpack:rs];
            if (unpacked) [results addObject:unpacked];
            else NSLog(@"Skipping 1");
        }
        if (resultsHandler) resultsHandler(results);
    }];
}

#pragma mark - Creating, deleting.

+(id)unpack:(FMResultSet *)resultSet {
    NSData *data = [resultSet dataForColumn:@"value"];
    NSError *jsonError = nil;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
    if (!dict) {
        NSLog(@"Json reading error %@", jsonError);
        return nil;
    }
    id new = [MTLJSONAdapter modelOfClass:[self class] fromJSONDictionary:dict error:nil];
   // id new = [[self alloc] initWithExternalRepresentation:dict];
    [new setValue:[resultSet stringForColumn:[self primaryKey]] forKey:[self primaryKey]];
    return new;
}

+(void)load:(NSString *)primaryKey queue:(FMDatabaseQueue *)dbQueue results:(void(^)(id result))resultHandler {
    [dbQueue inDatabase:^(FMDatabase *db) {
        NSString *loadStatement = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = ? LIMIT 1", [[self class] tableName], [[self class] primaryKey]];
        FMResultSet *rs = [db executeQuery:loadStatement, primaryKey];
        if ([rs next]) {
            id unpacked = [self unpack:rs];
            resultHandler(unpacked);
        } else {
            NSLog(@"no record found matching this ID");
        }
    }];
}

+(void)remove:(NSString *)primaryKey dbQueue:(FMDatabaseQueue *)dbQueue {
    [dbQueue inDatabase:^(FMDatabase *db) {
        NSString *removeStatement = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = ?", [[self class] tableName], [[self class] primaryKey]];
        [db executeUpdate:removeStatement, primaryKey];
    }];
}

#pragma mark - save;

-(void)save:(FMDatabaseQueue *)dbQueue {
    // write to db.
    [dbQueue inDatabase:^(FMDatabase *db) {
        NSString *primaryKey = [[self class] primaryKey];
        BOOL isInsert = ([self valueForKey:primaryKey] == nil);
        NSError *jsonError = nil;
        NSDictionary *externalRepresentation = [MTLJSONAdapter JSONDictionaryFromModel: self];//[self externalRepresentation];
        NSData *data = [NSJSONSerialization dataWithJSONObject:externalRepresentation options:0 error:&jsonError];
        
        if (!data) {
            NSLog(@"Json error %@", jsonError);
            return;
        }
    
        NSString *saveStatement = [NSString stringWithFormat:@"INSERT OR REPLACE INTO %@ VALUES (?,?)", [[self class] tableName]];
        [db executeUpdate:saveStatement, [self valueForKey:primaryKey], data];
        if (isInsert) [self setValue:[NSString stringWithFormat:@"%lld",[db lastInsertRowId]] forKey:primaryKey];
        
    }];
}

-(void)remove:(FMDatabaseQueue *)dbQueue {
    [[self class] remove:[self valueForKey:[[self class] primaryKey]] dbQueue:dbQueue];
}
     
@end
