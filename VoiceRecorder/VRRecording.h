//
//  VRRecording.h
//  VoiceRecorder
//
//  Created by Nathan on 6/19/13.
//  Copyright (c) 2013 Nathan Wallace. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface VRRecording : NSObject <NSCoding>

/*
 * The displayed title of the recording.
 */
@property (strong, nonatomic, readwrite) NSString *title;

/*
 * The location of the recording sound file.
 */
@property (strong, nonatomic, readonly) NSURL *URL;

/*
 * The raw location coordinates of the place where the recording was created, if any.
 */
@property (strong, nonatomic, readwrite) CLLocation *exactLocation;

/*
 * A string containing the name of the associated real-world location, if any.
 * This value is generated with reverse geocoding, using the CLGeocoder class.
 */
@property (strong, nonatomic, readonly) NSString *location;

/*
 * An array of tags, or groups, stored as strings.
 */
@property (strong, nonatomic, readonly) NSArray *tags;

/*
 * Standard init methods for creating a VRRecording object.
 */
- (id)initWithURL:(NSURL *)URL;
- (id)initWithURL:(NSURL *)URL andLocation:(CLLocation *)location;

/*
 * Prompt the recording object to convert its location data to human readable form.
 * @return YES on success, NO for error or failure
 */
- (void)processLocationData;

/*
 * Sets the location and exactLocation properties by using a CLPlacemark object.
 * Will not set the exactLocation property if it has already been set.
 */
- (void)setLocationUsingPlacemark:(CLPlacemark *)placemark;

@end
