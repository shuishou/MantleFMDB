//
//  DMMasterViewController.h
//  MantleDemo
//
//  Created by Zhou Shaolin on 11/7/14.
//  Copyright (c) 2014 Zhou Shaolin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDatabaseQueue.h"
#import "DMRow.h"

@class DMDetailViewController;

@interface DMMasterViewController : UITableViewController

@property (strong, nonatomic) DMDetailViewController *detailViewController;
@property (strong, nonatomic) FMDatabaseQueue *dbQueue;

@property (strong, nonatomic) NSMutableArray *objects;


@end
