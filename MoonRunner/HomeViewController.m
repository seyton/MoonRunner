//
//  HomeViewController.m
//  MoonRunner
//
//  Created by Wesley Matlock on 8/14/14.
//  Copyright (c) 2014 Insoc. All rights reserved.
//

#import "HomeViewController.h"
#import "NewRunViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    UIViewController *nextViewController = [segue destinationViewController];
    if ([nextViewController isKindOfClass:[NewRunViewController class]]) {
        ((NewRunViewController *) nextViewController).managedObjectContext = self.managedObjectContext;
    }
    

}

@end
