//
//  BadgeEarnStatus.h
//  MoonRunner
//
//  Created by Wesley Matlock on 8/18/14.
//  Copyright (c) 2014 Insoc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Badge;
@class Run;



@interface BadgeEarnStatus : NSObject

@property (strong, nonatomic) Badge *badge;
@property (strong, nonatomic) Run *earnRun;
@property (strong, nonatomic) Run *silverRun;
@property (strong, nonatomic) Run *goldRun;
@property (strong, nonatomic) Run *bestRun;



@end
