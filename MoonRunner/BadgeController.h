//
//  BadgeController.h
//  MoonRunner
//
//  Created by Wesley Matlock on 8/18/14.
//  Copyright (c) 2014 Insoc. All rights reserved.
//

#import <Foundation/Foundation.h>

extern float const silverMultiplier;
extern float const goldMutiplier;


@interface BadgeController : NSObject

+ (BadgeController *)defaultController;


- (NSArray *)earnStatusesForRuns:(NSArray *)runArray;

@end
