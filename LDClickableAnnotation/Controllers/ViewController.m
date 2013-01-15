//
//  ViewController.m
//  LDClickableAnnotation
//
//  Created by Tomek Janik on 1/11/13.
//  Copyright (c) 2013 Tomek Janik. All rights reserved.
//

#import "ViewController.h"
#import "PinDetailViewController.h"
#import <CoreLocation/CoreLocation.h>


@interface ViewController ()

@end

@implementation ViewController
	
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	pins = [[NSMutableArray alloc] init];
	
	CLLocationCoordinate2D loc;
	loc.latitude = 52.234108;
	loc.longitude = 20.99968;
	
	float lat = 52.234108, lng =20.99968;
	
	NSString *titles[] = {@"short", @"very very very very very very long", @"mediun", @"short"};
	NSString *subtitles[] = {@"w", @"short", @"some", @"very very very very very long subtitle"};
	
	for(int i = 0; i < 4; i++){
		
		LDAnnotationView *pin = [[LDAnnotationView alloc] init];
		[pin setCoordinate:CLLocationCoordinate2DMake(lat, lng)];
		pin.title = titles[i];
		pin.subtitle = subtitles[i];
		pin.canShowCallout = YES;
		
		lat += 0.003;
		lng += 0.003;
		[pins addObject:pin];
		//[self.mapView addAnnotation:pin];
	}
	
	[self.mapView addAnnotations:pins];
	
	MKCoordinateRegion co = MKCoordinateRegionMake(loc, MKCoordinateSpanMake(0.02, 0.02)) ;
	
	[self.mapView setRegion:co];
	
	[[LDAnnotationClickable instance] setDebug:YES];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
	if([segue.identifier isEqualToString:@"ViewPinDetailSegue"]){
		PinDetailViewController *dest = segue.destinationViewController;
		[dest.pinTitle setText:((LDAnnotationView*)((MKAnnotationView*)sender).annotation).title];
		
		dest.title = ((LDAnnotationView*)((MKAnnotationView*)sender).annotation).title;
	}
}
@end
