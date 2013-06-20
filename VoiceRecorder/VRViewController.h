//
//  VRViewController.h
//  VoiceRecorder
//
//  Created by Nathan on 6/19/13.
//  Copyright (c) 2013 Nathan Wallace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface VRViewController : UIViewController <AVAudioRecorderDelegate>

@property (weak, nonatomic) IBOutlet UIButton *mainButton;

- (IBAction)listButtonTapped:(id)sender;
- (IBAction)mainButtonPressed:(id)sender;

@end
