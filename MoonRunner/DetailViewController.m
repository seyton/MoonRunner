//
//  DetailViewController.m
//  MoonRunner
//
//  Created by Wesley Matlock on 8/14/14.
//  Copyright (c) 2014 Insoc. All rights reserved.
//

#import "DetailViewController.h"
#import "Run.h"
#import "Location.h"
#import "MathController.h"
#import "MulticolorPolylineSegment.h"
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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
    
}

- (void)configureView {
    
    self.distanceLabel.text = [MathController stringifyDistance:self.run.distance.floatValue];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    self.dateLabel.text = [formatter stringFromDate:self.run.timestamp];

    self.timeLabel.text = [NSString stringWithFormat:@"Time: %@", [MathController stringifySecondCount:self.run.duration.intValue
                                                                                       usingLongFormat:YES]];
    
    self.paceLabel.text = [NSString stringWithFormat:@"Pace: %@", [MathController stringifyAvgPaceFromDist:self.run.distance.floatValue
                                                                                                  overTime:self.run.duration.intValue]];
    
    [self loadMap];
}

#pragma mark - Maping methods
- (MKCoordinateRegion)mapRegion {
    
    MKCoordinateRegion region;
    Location *initLoc = self.run.locations.firstObject;
    
    float minLat    = initLoc.latitude.floatValue;
    float minLong   = initLoc.longitude.floatValue;
    float maxLat    = initLoc.latitude.floatValue;
    float maxLong   = initLoc.longitude.floatValue;
    
    for (Location *location in self.run.locations) {
        
        if (location.latitude.floatValue < minLat) {
            minLat = location.latitude.floatValue;
        }
        
        if (location.longitude.floatValue < minLong) {
            minLong = location.longitude.floatValue;
        }
        
        
        if (location.latitude.floatValue > maxLat) {
            maxLat = location.latitude.floatValue;
        }
        
        if (location.longitude.floatValue > maxLong) {
            maxLong = location.longitude.floatValue;
        }
    }
    

    region.center.latitude = (minLat + maxLat / 2.0f);
    region.center.longitude = (minLong + maxLong / 2.0f);
    
    region.span.latitudeDelta = (maxLat - minLat) * 1.1f;  //10% buffer...
    region.span.longitudeDelta = (maxLong - minLong) * 1.1f;
    
    
    
    
    return region;
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    
    if ([overlay isKindOfClass:[MulticolorPolylineSegment class]]) {
        MulticolorPolylineSegment *polyLine = (MulticolorPolylineSegment *)overlay;
        MKPolylineRenderer *aRenderer = [[MKPolylineRenderer alloc] initWithPolyline:polyLine];
        aRenderer.strokeColor = polyLine.color;
        aRenderer.lineWidth = 3;
        return aRenderer;
    }
    
    return nil;
}


- (MKPolyline *)polyLine {
    
    CLLocationCoordinate2D coords[self.run.locations.count];
    
    for (int i = 0; i < self.run.locations.count; i++) {
        Location *location = [self.run.locations objectAtIndex:i];
        coords[i] = CLLocationCoordinate2DMake(location.latitude.doubleValue, location.longitude.doubleValue);
        
    }
    
    return [MKPolyline polylineWithCoordinates:coords count:self.run.locations.count];
}


- (void)loadMap {
    
    if (self.run.locations.count > 0) {
        
        self.mapView.hidden = NO;
        
        //map bounds
        [self.mapView setRegion:[self mapRegion]];
        
        //show lines on map
        NSArray *colorSegmentArray = [MathController colorSegmentsForLocations:self.run.locations.array];
        [self.mapView addOverlays:colorSegmentArray];
        
    }
    else {
        
        //no locations :(
        self.mapView.hidden = YES;
        

        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"ERROR"
                                                            message:@"Sorry, this run has no locations saved."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        
        [alertView show];
        
    }
    
    
}


@end


