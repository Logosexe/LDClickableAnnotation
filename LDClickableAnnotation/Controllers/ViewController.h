//
//  ViewController.h
//  LDClickableAnnotation
//
//  Created by Tomek Janik on 1/11/13.
//  Copyright (c) 2013 Tomek Janik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "LDAnnotationClickable.h"
#import "LDAnnotationView.h"


@interface ViewController : UIViewController<MKMapViewDelegate, LDAnnotationClickableDelegate>{
	NSMutableArray *pins;
}
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end
