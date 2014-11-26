//
//  DMDetailViewController.m
//  FlyingMantle
//
//  Created by Zhou Shaolin on 11/7/14.
//  Copyright (c) 2014 Zhou Shaolin. All rights reserved.
//

#import "DMDetailViewController.h"

@interface DMDetailViewController ()
- (void)configureView;
@end

@implementation DMDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _detailDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 300, 250)];
    _detailDescriptionLabel.numberOfLines = 0;
    [self.view addSubview:_detailDescriptionLabel];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)init
{
    self = [super init];
    if (self) {
        self.title = NSLocalizedString(@"Detail", @"Detail");
    }
    return self;
}
							
@end
