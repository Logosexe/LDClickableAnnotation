//
//  LDAnnotationClickable.m
//  LDClickableAnnotation
//
//  Created by Tomek Janik on 1/13/13.
//  Copyright (c) 2013 Tomek Janik. All rights reserved.
//

#import "LDAnnotationClickable.h"
#import "LDAnnotationView.h"

@implementation LDAnnotationClickable
@synthesize delegate = _delegate;
static LDAnnotationClickable*instance;

+(LDAnnotationClickable*)instance{
	if(instance == nil){
		instance = [[LDAnnotationClickable alloc] init];
	}
	return instance;
}

-(LDAnnotationClickable*)init{
	if(self = [super init]){
		clickableView = nil;
		debug = NO;
	}
	return self;
}

-(void)addPinButtonWithDelegate:(id<LDAnnotationClickableDelegate>)d{
	
	if(clickableView == nil){
		_delegate = d;
		
		UIWindow *frontWindow = [[UIApplication sharedApplication] keyWindow];
		
		clickableView = [UIButton buttonWithType:UIButtonTypeCustom];
		
		clickableView.alpha = 0.0;
		if(debug){
			clickableView.backgroundColor = [UIColor redColor];
			
		} else {
			clickableView.backgroundColor = [UIColor clearColor];
		}
		
		[clickableView setFrame:CGRectMake(0, 0, 0, 0)];
		[clickableView addTarget:self action:@selector(pinSelected:) forControlEvents:UIControlEventTouchUpInside];
		[frontWindow addSubview:clickableView];
		
	} else {
		[self recover];
	}
}

-(void)pinSelected:(id)sender{
	[_delegate pinSelected:annotation];
}

- (void)pinDidSelect:(MKAnnotationView*)view{

	pin = (LDAnnotationView*)view.annotation;
	annotation = view;
	UIWindow *frontWindow = [[UIApplication sharedApplication] keyWindow];
	
	CGPoint windowPoint = [view convertPoint:view.bounds.origin toView:frontWindow];

	if(view.leftCalloutAccessoryView == nil){
		UIView *l = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
		l.backgroundColor = [UIColor clearColor];
		view.leftCalloutAccessoryView = l;
	}
	
	CGPoint leftWindow = [view.leftCalloutAccessoryView convertPoint:view.leftCalloutAccessoryView.bounds.origin toView:frontWindow];
		
	originTouch = windowPoint;
	leftViewPoint = leftWindow;
	
	windowPoint.x = leftWindow.x;
	[self setClickableViewPosition:windowPoint];
	/*
	 time for the annotation shake to stop, otherwise we cant get properly the x of leftcallout view
	 */
	[NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(updatePos) userInfo:nil repeats:NO];
}

- (void)pinDidDeselect{
	clickableView.alpha = 0.0;
	[clickableView setFrame:CGRectMake(0, 0, 0, 0)];
	
}

- (void)regionDidChange:(MKCoordinateRegion)region{
	[self updateClickableViewPosition];
}


#pragma  mark -
#pragma mark private methods

-(void)updatePos{

	UIWindow *frontWindow = [[UIApplication sharedApplication] keyWindow];
	CGPoint leftWindow = [annotation.leftCalloutAccessoryView convertPoint:annotation.leftCalloutAccessoryView.bounds.origin toView:frontWindow];

	leftWindow.y = originTouch.y;
	leftWindow.x += annotation.leftCalloutAccessoryView.frame.size.width;
	
	[self setClickableViewPosition:leftWindow];
	clickableView.alpha = 0.5;
}

-(void)setClickableViewPosition:(CGPoint)windowPoint{

	
	
	
	CGSize textSize = [pin.title sizeWithFont:[UIFont systemFontOfSize:20]];
	int maintextWidth = textSize.width;
	
	CGSize subtextSize = [pin.subtitle sizeWithFont:[UIFont systemFontOfSize:12]];
	int subtextWidth = subtextSize.width;
	
	int width = MAX(subtextWidth, maintextWidth);
	
	width = MIN(280, width);
	int xpos = windowPoint.x;
	
	if(width + windowPoint.x > 320){
		width = 320 - windowPoint.x;
	}

	[clickableView setFrame:CGRectMake(xpos, windowPoint.y-55, width, 40)];
}

-(void)updateClickableViewPosition{
	UIWindow *frontWindow = [[UIApplication sharedApplication] keyWindow];
	
	CGPoint windowPoint = [annotation convertPoint:annotation.bounds.origin toView:frontWindow];
	

	int dif;
	dif = windowPoint.x - originTouch.x;
	dif = -dif;
	
	[clickableView setFrame:CGRectMake(clickableView.frame.origin.x - dif, windowPoint.y-55, clickableView.frame.size.width, clickableView.frame.size.height)];
	
	originTouch = windowPoint;

}

-(void)setDebug:(BOOL)d{
	debug = d;
}

-(void)dismiss{
	dismissRect = clickableView.frame;
	clickableView.frame = CGRectMake(0, 0, 0, 0);
}
-(void)recover{
	clickableView.frame = dismissRect;
}
@end
