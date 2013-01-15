////
//  AnnotationView.m
//  LDClickableAnnotation
//
//  Created by Tomek Janik on 1/11/13.
//  Copyright (c) 2013 Tomek Janik. All rights reserved.
//

#import "LDAnnotationView.h"




@implementation LDAnnotationView

@synthesize coordinate = _coordinate;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate{
	_coordinate = newCoordinate;
}

- (LDAnnotationView*)viewForMap:(MKMapView*)mapView{
	LDAnnotationView *annotationView;
	id <MKAnnotation> annotation = self;
	
	annotationView = (LDAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"LDPin"];
	if(!annotationView) {
		annotationView = (LDAnnotationView *)[[LDAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"LDPin"];
	}
	
	annotationView.image = [UIImage imageNamed:@"LDPin"];
	
	/* 
	 if leftCalloutAccessoryView is not created here, it will be created in LDAnnotationClickable, as a dummy 0x0
	 view.
	 */
	
//	UIView *l = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
//	l.backgroundColor = [UIColor clearColor];
//	annotationView.leftCalloutAccessoryView = l;

	annotationView.canShowCallout = YES;
	
	return annotationView;
}

@end
