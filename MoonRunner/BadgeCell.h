//
//  BadgeCell.h
//  MoonRunner
//
//  Created by Wesley Matlock on 8/19/14.
//  Copyright (c) 2014 Insoc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BadgeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIImageView *badgeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *silverImageView;
@property (weak, nonatomic) IBOutlet UIImageView *goldImageView;


@end
