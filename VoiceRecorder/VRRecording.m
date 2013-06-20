//
//  VRRecording.m
//  VoiceRecorder
//
//  Created by Nathan on 6/19/13.
//  Copyright (c) 2013 Nathan Wallace. All rights reserved.
//

#import "VRRecording.h"

@interface VRRecording ()

@property (strong, nonatomic, readwrite) NSURL *URL;
@property (strong, nonatomic, readwrite) NSString *location;
@property (strong, nonatomic, readwrite) NSArray *tags;

@end

@implementation VRRecording

static NSString *VRRecordingTitleKey            = @"VRRecordingTitleKey";
static NSString *VRRecordingURLKey              = @"VRRecordingURLKey";
static NSString *VRRecordingExactLocationKey    = @"VRRecordingExactLocationKey";
static NSString *VRRecordingLocationKey         = @"VRRecordingLocationKey";
static NSString *VRRecordingTagsKey             = @"VRRecordingTagsKey";

#pragma mark - Init

- (id)initWithURL:(NSURL *)URL
{
    self = [super init];
    if (self) {
        _title = @"No Title";
        _URL = URL;
    }
    return self;
}

- (id)initWithURL:(NSURL *)URL andLocation:(CLLocation *)location
{
    self = [self initWithURL:URL];
    if (self) {
        _exactLocation = location;
    }
    return self;
}

#pragma mark - Location

- (void)processLocationData {
    static CLGeocoder *geocoder;
    if (!geocoder) geocoder = [[CLGeocoder alloc] init];
    
    [geocoder reverseGeocodeLocation:self.exactLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if ([placemarks count] > 0)
        {
            // Find a string representation from the placemarks
            // Set the location property to this string
            // self.location
        }
        
        if (error) NSLog(@"An error occurred while reverse geocoding: \n%@",[error localizedDescription]);
    }];
}

- (void)setLocationUsingPlacemark:(CLPlacemark *)placemark
{
    if (!_exactLocation) _exactLocation = placemark.location;
    
    // Find a suitable placemark property for use as a location string
#warning Unimplemented!
}

#pragma mark - NSCoding
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _title          = [aDecoder decodeObjectForKey:VRRecordingTitleKey];
        _URL            = [aDecoder decodeObjectForKey:VRRecordingURLKey];
        _exactLocation  = [aDecoder decodeObjectForKey:VRRecordingExactLocationKey];
        _location       = [aDecoder decodeObjectForKey:VRRecordingLocationKey];
        _tags           = [aDecoder decodeObjectForKey:VRRecordingTagsKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder     encodeObject:self.title         forKey:VRRecordingTitleKey];
    [aCoder     encodeObject:self.URL           forKey:VRRecordingURLKey];
    [aCoder     encodeObject:self.exactLocation forKey:VRRecordingExactLocationKey];
    [aCoder     encodeObject:self.location      forKey:VRRecordingLocationKey];
    [aCoder     encodeObject:self.tags          forKey:VRRecordingTagsKey];
    
}

@end
