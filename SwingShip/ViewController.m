//
//  ViewController.m
//  SwingShip
//
//  Created by Ngô Sỹ Trường on 4/22/16.
//  Copyright © 2016 ngotruong. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@end

@implementation ViewController
{
    UIImageView *ship;
    UIImageView *sea1,*sea2,*sea3;
    AVAudioPlayer *audioPlayer;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawShipAndSea];
    [self animateShip];
    [self animateSea];
    [self playSong];
}

-(void) drawShipAndSea {
    sea1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1.png"]];
    sea1.frame = self.view.bounds;
    [self.view addSubview:sea1];
    
    sea2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2.png"]];
    sea2.frame = CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:sea2];
    
    sea3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"3.png"]];
    sea3.frame = CGRectMake(self.view.bounds.size.width*2, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:sea3];
    
    ship = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ship.png"]];
    ship.center = CGPointMake(200, 400);
    [self.view addSubview:ship];
}
-(void) animateShip {
    [UIView animateWithDuration:1 animations:^{
        ship.transform = CGAffineTransformMakeRotation(-0.09);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 animations:^ {
            ship.transform = CGAffineTransformMakeRotation(0.05);
        }completion:^(BOOL finished){
            [self animateShip];
        }];
    }];
}
//-(void) animateSea {
//    [UIView animateWithDuration:10 animations:^{
//        sea1.frame = CGRectMake(-self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
//        sea2.frame = self.view.bounds;
//    } completion:^(BOOL finished) {
//        sea1.frame = CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
//        [UIView animateWithDuration:10 animations:^{
//            sea1.frame = self.view.bounds;
//            sea2.frame = CGRectMake(-self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
//        }completion:^(BOOL finished) {
//            sea2.frame = CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
//            [self animateSea];
//        }];
//    }];
//}
-(void) animateSea {
    [UIView animateWithDuration:5 animations:^{
        sea1.frame = CGRectMake(-self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        sea2.frame = self.view.bounds;
        sea3.frame = CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    } completion:^(BOOL finished) {
        sea1.frame = CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        [UIView animateWithDuration:5 animations:^{
            sea2.frame = CGRectMake(-self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
            sea3.frame = self.view.bounds;
        }completion:^(BOOL finished) {
            sea2.frame = CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
            [UIView animateWithDuration:5 animations:^{
                sea1.frame = self.view.bounds;
                sea3.frame = CGRectMake(-self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
            }completion:^(BOOL finished){
                sea1.frame = self.view.bounds;
                sea2.frame = CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                sea3.frame = CGRectMake(self.view.bounds.size.width*2, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                [self animateSea];
            }];
        }];
    }];
}
-(void) playSong {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Sharazan" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSError *error;
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    [audioPlayer prepareToPlay];
    [audioPlayer play];
}
-(void) viewDidDisappear:(BOOL)animated {
    [audioPlayer stop];
}
@end
