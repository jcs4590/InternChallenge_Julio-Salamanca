//
//  ViewController.m
//  MyriadInternChallenge
//
//  Created by Julio Salamanca on 3/13/15.
//  Copyright (c) 2015 Julio Salamanca. All rights reserved.
//

#import "ViewController.h"
#import "AFHTTPRequestOperationManager.h"

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property NSUserDefaults * userData;

@end

@implementation ViewController
@synthesize nameTextField, emailTextField, userData;

- (void)viewDidLoad {
    [super viewDidLoad];
  self.view.backgroundColor = [UIColor colorWithRed:0.102 green:0.737 blue:0.612 alpha:1];
    // Do any additional setup after loading the view, typically from a nib.
  userData = [NSUserDefaults standardUserDefaults];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


  //change email textfield image on key press verification
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
  
  emailTextField.rightViewMode = UITextFieldViewModeWhileEditing;
  if ([self validateEmailWithString:emailTextField.text]) {
    
      //change red X image to green check mark when done editing if correct format
    UIImageView * emailImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"greenArrowIcon"]];
    emailImageView.frame = CGRectMake(0, 0, 20, 20);
    emailTextField.rightView = emailImageView;
    
  }
  else{
    UIImageView * emailImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"redXIcon"]];
    emailImageView.frame = CGRectMake(0, 0, 20, 20);
    emailTextField.rightView = emailImageView;
  }
  
  return TRUE;
  
}

- (IBAction)submitSignUp:(id)sender {
    if([self validateEmailWithString:emailTextField.text] && ![nameTextField.text  isEqual: @""]){
      
        // save user information locally
      [userData setObject:emailTextField.text forKey:@"email"];
      [userData setObject:nameTextField.text forKey:@"name"];
      [userData synchronize];
			
      
      
      
        //HTTP Post Request
      AFHTTPRequestOperationManager * manger = [AFHTTPRequestOperationManager manager];
      NSDictionary * postParameters = @{@"email":emailTextField.text};
        
      [manger POST:@"https://challenge2015.myriadapps.com/api/v1/subscribe" parameters:postParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
         
          UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Thank You!" message:[NSString stringWithFormat:@"%@",[responseObject valueForKey:@"message"]
]  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
          [alertView show];
          [self performSegueWithIdentifier:@"toTableView" sender:self];

        
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"An Error Occured!." message:@"An error occured while trying to send your information. Please Try Again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
          [alertView show];

      }];
      
    
    
    }
    else{
    
        //alert user the email format is not valid or name text field is empty
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"ERROR WITH FORM!." message:@"The email you entered is not in proper format OR Name field was left empty" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField{

  [textField resignFirstResponder];
  return YES;
}


//validate Email with regex
- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString * emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate * emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailPredicate evaluateWithObject:email];
}



@end
