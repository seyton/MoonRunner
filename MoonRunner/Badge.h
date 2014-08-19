//
//  Badge.h
//  MoonRunner
//
//  Created by Wesley Matlock on 8/18/14.
//  Copyright (c) 2014 Insoc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Badge : NSObject


@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *imageName;
@property (strong, nonatomic) NSString *information;

@property float distance;


@end
