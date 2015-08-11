//
//  Spawner.m
//  Mar
//
//  Created by Benjamin Humphries on 8/10/15.
//  Copyright (c) 2015 Marz Software. All rights reserved.
//

#import "Spawner.h"

@implementation Spawner
@synthesize delegate, timeInterval;
- (id)init {
    if (self = [super init]){
        timeInterval = 1.0f;
        mainTimer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(timerFinished:) userInfo:[NSString stringWithFormat:@"%i",[self randomType]] repeats:YES];
    }
    return self;
}

- (void)start {
     [mainTimer fire];
}

- (void)stop {
    [mainTimer invalidate];
}

- (void)timerFinished:(NSTimer *)responce{
    [delegate spawnType:[responce.userInfo integerValue]];
}

- (NSUInteger)randomType{
    return arc4random() % shipTypeCount;
}
@end
