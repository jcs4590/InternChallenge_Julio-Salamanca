//
//  RootViewController.m
//  MyriadInternChallenge
//
//  Created by Julio Salamanca on 3/16/15.
//  Copyright (c) 2015 Julio Salamanca. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()
@property NSUserDefaults * userData;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  self.userData = [NSUserDefaults standardUserDefaults];
  
}
-(void)viewDidAppear:(BOOL)animated{

  
  if ([self.userData objectForKey:@"name"] == nil) {
    [self performSegueWithIdentifier:@"toLogIn" sender:self];
    
  }
  else{

    [self performSegueWithIdentifier:@"toMainTable" sender:self];
    
  }


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
