//
//  DetailViewController.m
//  MoonRunner
//
//  Created by Wesley Matlock on 8/14/14.
//  Copyright (c) 2014 Insoc. All rights reserved.
//

#import "DetailViewController.h"
#import <MapKit/MapKit.h>


@interface DetailViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *paceLabel;


@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setRun:(Run *)run {

    if (_run != run) {
        _run = run;
        [self configureView];
        
    }
}


- (void)configureView {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
    
}

@end
