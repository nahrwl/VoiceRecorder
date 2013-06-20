//
//  VRViewController.m
//  VoiceRecorder
//
//  Created by Nathan on 6/19/13.
//  Copyright (c) 2013 Nathan Wallace. All rights reserved.
//

#import "VRViewController.h"

@interface VRViewController ()

@property (nonatomic, strong) AVAudioRecorder *audioRecorder;
@property (nonatomic, strong) NSURL *soundFileURL;

- (void)stopRecording;
- (void)pauseRecording;
- (void)startRecording;
- (void)prepareToRecord;

- (void)displayList;

@end

@implementation VRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive: YES error: nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if (!self.audioRecorder.isRecording) self.audioRecorder = nil;
}

#pragma mark - Actions

- (IBAction)listButtonTapped:(id)sender {
    // Push the view upward, and let it fall and bounce to signal a drag
}

- (IBAction)mainButtonPressed:(id)sender {
    if (self.audioRecorder.isRecording) {
        [self stopRecording];
    } else {
        [self startRecording];
    }
}

#pragma mark - Methods
#pragma mark Recording

- (void)stopRecording
{
    [self.audioRecorder stop];
    
    // [UIApplication sharedApplication].idleTimerDisabled = NO; // ENABLE DEVICE SLEEPING!
    
    // Update UI
    [self.mainButton setTitle:@"Record" forState:UIControlStateNormal];

}

- (void)pauseRecording
{
    
}

- (void)startRecording
{
    [self prepareToRecord];
    
    // [UIApplication sharedApplication].idleTimerDisabled = YES; // DISABLE DEVICE SLEEP
    
    [self.audioRecorder record];
    
    // Update UI
    [self.mainButton setTitle:@"Stop" forState:UIControlStateNormal];
    
}

- (void)prepareToRecord
{
    //Set up the audio recorder to be able to record right away
    NSArray *sysPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *fileDirectory = [sysPaths objectAtIndex:0];
    
    NSDate *currentDate = [NSDate date];
    NSTimeInterval sinceReferenceDate = [currentDate timeIntervalSinceReferenceDate];
    NSString *fileName = [[NSString stringWithFormat:@"%f",sinceReferenceDate] stringByAppendingString:@".caf"];
    
    NSString *soundFilePath = [fileDirectory stringByAppendingString:[@"/" stringByAppendingString:fileName]];
    
    NSURL *recorderURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
    self.soundFileURL = recorderURL;
    
    NSError *outError = nil;
    
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryRecord
                                           error: &outError];
    
    if (outError) NSLog(@"An error occurred while setting the audio session to record: \n%@",[outError localizedDescription]);
    
    if (self.audioRecorder)
        self.audioRecorder = nil;
    
    NSDictionary *recordSettings = [[NSDictionary alloc] initWithObjectsAndKeys:
                                    [NSNumber numberWithFloat: 44100.0], AVSampleRateKey,
                                    [NSNumber numberWithInt: kAudioFormatAppleLossless], AVFormatIDKey,
                                    [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,
                                    [NSNumber numberWithInt: AVAudioQualityMax],
                                    AVEncoderAudioQualityKey,
                                    nil];
    
    NSError *error = nil;
    
    self.audioRecorder = [[AVAudioRecorder alloc] initWithURL:self.soundFileURL settings:recordSettings error:&error];
    recordSettings = nil;
    
    self.audioRecorder.delegate = self;
    
    if (error) {
        NSLog(@"AVAudioRecorder init failed: %@",[error localizedDescription]);
    } else {
        [self.audioRecorder prepareToRecord];
        
        // Set up post-preparation audio recorder properties
        // self.audioRecorder.meteringEnabled = YES;
        
        NSLog(@"AVAudioRecorder init success! Prepared to record");
    }
}

#pragma mark View Transitions

- (void)displayList
{
    
}

@end
