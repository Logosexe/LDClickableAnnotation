//
//  LDAnnotationClickable.h
//  LDClickableAnnotation
//
//  Created by Tomek Janik on 1/13/13.
//  Copyright (c) 2013 Tomek Janik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@class LDAnnotationClickable;
@class LDAnnotationView;

@protocol LDAnnotationClickableDelegate <NSObject>

-(void)pinSelected:(MKAnnotationView*)pin;

@end

@interface LDAnnotationClickable : NSObject {

	MKAnnotationView *annotation;
	UIButton *clickableView;
	BOOL debug;
	CGRect dismissRect;
	CGPoint leftViewPoint;
	CGPoint originTouch;
	LDAnnotationView *pin;
}


@property (nonatomic, readonly) id<LDAnnotationClickableDelegate> delegate;

+ (LDAnnotationClickable*)instance;
- (void)addPinButtonWithDelegate:(id<LDAnnotationClickableDelegate>)d;
- (void)pinDidSelect:(MKAnnotationView*)pin;
- (void)pinDidDeselect;
- (void)regionDidChange:(MKCoordinateRegion)region;

-(void)setDebug:(BOOL)d;

-(void)dismiss;
-(void)recover;

@end
