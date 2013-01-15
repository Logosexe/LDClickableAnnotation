//
//  AnnotationView.h
//  LDClickableAnnotation
//
//  Created by Tomek Janik(Logos Dev) on 1/11/13.
//  Copyright (c) 2013 Tomek Janik. All rights reserved.
//

#import <MapKit/MapKit.h>



@interface LDAnnotationView : MKAnnotationView<MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;
- (LDAnnotationView*)viewForMap:(MKMapView*)mapView;
@end
