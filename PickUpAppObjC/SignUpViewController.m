//
//  SignUpViewController.m
//  PickUpAppObjC
//
//  Created by SJ on 2014-10-11.
//  Copyright (c) 2014 Wolfpack. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)signUpClicked:(id)sender {
    
    NSInteger success = 0;
    @try {
        
        if([[self.txtUsername text] isEqualToString:@""]
        || [[self.txtPassword text] isEqualToString:@""]
        || [[self.txtFirstname text] isEqualToString:@""]
        || [[self.txtLastname text] isEqualToString:@""]
        || [[self.txtEmail text] isEqualToString:@""]
        || [[self.txtPassword text] isEqualToString:@""]
        || [[self.txtConfirmPassword text] isEqualToString:@""]) {
            
            [self alertStatus:@"Missing fields. All fields are required." :@"Sign in failed!" :0];
            
        } else if([self.txtEmail.text rangeOfString:@"@"].location == NSNotFound){
            
            [self alertStatus:@"Invalid Email." :@"Sign in failed!" :0];
        
        } else if(![self.txtPassword.text isEqualToString:self.txtConfirmPassword.text]){
            
            [self alertStatus:@"Passwords do not match." :@"Sign in failed!" :0];
            
        } else {
            NSString *post =[[NSString alloc] initWithFormat:@"username=%@&password=%@&firstname=%@&lastname=%@&email=%@&password=%@&confirmpassword=%@",[self.txtUsername text]
                                                                                                                                                        ,[self.txtPassword text]
                                                                                                                                                        ,[self.txtFirstname text]
                                                                                                                                                        ,[self.txtLastname text]
                                                                                                                                                        ,[self.txtEmail text]
                                                                                                                                                        ,[self.txtPassword text]
                                                                                                                                                        ,[self.txtConfirmPassword text]];
            NSLog(@"PostData: %@",post);
            
            NSURL *url=[NSURL URLWithString:@"http://boyuanisgay.com"];
            
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            
            NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:url];
            [request setHTTPMethod:@"POST"];
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody:postData];
            
            //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
            
            NSError *error = [[NSError alloc] init];
            NSHTTPURLResponse *response = nil;
            NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            
            NSLog(@"Response code: %ld", (long)[response statusCode]);
            
            if ([response statusCode] >= 200 && [response statusCode] < 300)
            {
                NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
                NSLog(@"Response ==> %@", responseData);
                
                NSError *error = nil;
                NSDictionary *jsonData = [NSJSONSerialization
                                          JSONObjectWithData:urlData
                                          options:NSJSONReadingMutableContainers
                                          error:&error];
                
                success = [jsonData[@"success"] integerValue];
                NSLog(@"Success: %ld",(long)success);
                
                if(success == 1)
                {
                    NSLog(@"Login SUCCESS");
                } else {
                    
                    NSString *error_msg = (NSString *) jsonData[@"error_message"];
                    [self alertStatus:error_msg :@"Sign in Failed!" :0];
                }
                
            } else {
                //if (error) NSLog(@"Error: %@", error);
                [self alertStatus:@"Connection Failed" :@"Sign in Failed!" :0];
            }
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        [self alertStatus:@"Sign in Failed." :@"Error!" :0];
    }
    if (success) {
        [self performSegueWithIdentifier:@"login_success" sender:self];
    }

}

- (void) alertStatus:(NSString *)msg :(NSString *)title :(int) tag
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    alertView.tag = tag;
    [alertView show];
}

- (IBAction)backgroundTap:(id)sender {
    
    [self.view endEditing:YES];
    
}

- (BOOL)returnTextField:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}


@end
