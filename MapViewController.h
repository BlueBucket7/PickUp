//
//  MapViewController.h
//  PickUpAppObjC
//
//  Created by SJ on 2014-10-18.
//  Copyright (c) 2014 Wolfpack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapKit/MapKit.h"
#import <GoogleMaps/GoogleMaps.h>

@interface MapViewController : UIViewController <CLLocationManagerDelegate>
{
//@property (weak, nonatomic) IBOutlet UIView* mapView;
    IBOutlet UIView *subMapView;
}


@end
