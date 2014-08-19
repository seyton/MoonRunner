//
//  BadgeController.m
//  MoonRunner
//
//  Created by Wesley Matlock on 8/18/14.
//  Copyright (c) 2014 Insoc. All rights reserved.
//

#import "BadgeController.h"
#import "Badge.h"
#import "BadgeEarnStatus.h"
#import "Run.h"

float const silverMultiplier = 1.05;    //5%  speed increase
float const goldMultiplier = 1.1;       //10% speed increase

@interface BadgeController ()

@property (strong, nonatomic) NSArray *badges;

@end

@implementation BadgeController


+ (BadgeController *)defaultController {
    
    static BadgeController *controller = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        controller = [[BadgeController alloc] init];
        controller.badges = [self badgeArray];
        
    });
    
    return controller;
}



+ (NSArray *)badgeArray {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"badges" ofType:@"txt"];
    NSString *jsonContent = [NSString stringWithContentsOfFile:filePath usedEncoding:nil error:nil];
    NSData *data = [jsonContent dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *badgeDicts = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    
    NSMutableArray *badgesObjects = [NSMutableArray array];
    
    for (NSDictionary *badgeDict in badgeDicts) {
        [badgesObjects addObject:[self badgeForDictionary:badgeDict]];
        
    }
    
    
    return badgesObjects;
}


+ (Badge *)badgeForDictionary:(NSDictionary *)dictionary {
    
    Badge *badge = [Badge new];

    badge.name = [dictionary objectForKey:@"name"];
    badge.information = [dictionary objectForKey:@"information"];
    badge.imageName = [dictionary objectForKey:@"imageName"];
    badge.distance = [[dictionary objectForKey:@"distance"] floatValue];
    
    return badge;
    
}


- (NSArray *)earnStatusesForRuns:(NSArray *)runs {
    
    NSMutableArray *earnedStatuses = [NSMutableArray array];
    
    
    for ( Badge *badge in self.badges) {
        
        BadgeEarnStatus *earnStatus = [BadgeEarnStatus new];
        earnStatus.badge = badge;
        
        for (Run *run in runs) {
            
            
            if (run.distance.floatValue > badge.distance) {
                
                // 1st time earned
                if (!earnStatus.earnRun) {
                    earnStatus.earnRun = run;
                }
                
                
                double earnRunSpeed = earnStatus.earnRun.distance.doubleValue / earnStatus.earnRun.duration.doubleValue;
                double runSpeed = run.distance.doubleValue / run.duration.doubleValue;
                
                
                //Silver?
                if (!earnStatus.silverRun && runSpeed > earnRunSpeed * silverMultiplier) {
                    earnStatus.silverRun = run;
                }
                
                //Gold?
                if (!earnStatus.goldRun && runSpeed > earnRunSpeed * goldMultiplier) {
                    earnStatus.goldRun = run;
                }
                
                
                //Best?
                if (!earnStatus.bestRun) {
                    earnStatus.bestRun = run;
                }
                else {
                    double bestRunSpeed = earnStatus.bestRun.distance.doubleValue / earnStatus.bestRun.duration.doubleValue;
                    
                    if (runSpeed > bestRunSpeed) {
                        earnStatus.bestRun = run;
                    }
                }
            }
        }
        
        [earnedStatuses addObject:earnStatus];
    }
    
    
    return earnedStatuses;
}



@end
