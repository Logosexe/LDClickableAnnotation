LDClickableAnnotation
=====================

Clickable Annotation view for iOS MapKit

SETUP
=====

in your .h file with map

#import "LDAnnotationClickable.h"
#import "LDAnnotationView.h"
@interface ViewController : UIViewController<MKMapViewDelegate, LDAnnotationClickableDelegate>

in .m file 


-(MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
	return [((LDAnnotationView*)annotation) viewForMap:(MKMapView*)mapView];
}

-(void)viewDidAppear:(BOOL)animated{
	[[LDAnnotationClickable instance] addPinButtonWithDelegate:self];
	[[LDAnnotationClickable instance] recover];
}

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
	[[LDAnnotationClickable instance] pinDidSelect:view];
}

-(void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view{
	[[LDAnnotationClickable instance] pinDidDeselect];
}

-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
	[[LDAnnotationClickable instance] regionDidChange:mapView.region];
}

#pragma mark LDClickableDelegate

-(void)pinSelected:(MKAnnotationView *)pin{
	/* do segue or whatever you need to dismiss clickable view, and recover it on view will appear*/
	NSLog(@"CLICKED : %@", ((LDAnnotationView*)pin.annotation).title);
	
	[self performSegueWithIdentifier:@"ViewPinDetailSegue" sender:pin];
	[[LDAnnotationClickable instance] dismiss];
}
