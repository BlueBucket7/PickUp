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

/*
 TO DO:
 - Add tap out check
 - Move generic functions to separate class
 */

- (IBAction)signUpClicked:(id)sender {
    NSInteger success = 0;
    @try {
        
        NSString *emailStr = self.txtEmail.text;
        NSString *passwordStr = self.txtPassword.text;
        NSString *userNameStr = self.txtUsername.text;
        
        NSMutableDictionary *user = [[NSMutableDictionary alloc] init];
        [user setObject:emailStr forKey:@"email"];
        [user setObject:passwordStr forKey:@"password"];
        [user setObject:userNameStr forKey:@"displayName"];
        NSMutableDictionary *newUser = [[NSMutableDictionary alloc] init];
        [newUser setObject:user forKey:@"newUser"];
        
        // create a JSONObject from the NSDictionary and an error object
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:newUser options:NSJSONWritingPrettyPrinted error:&error];
        
        //Create a request
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:@"http://pickupapp.herokuapp.com/users/signup"]];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:jsonData];
        
        //TO BE REMOVED. DEBUGGING.
        //Print out the data contents
        NSString *jsonSummary = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"jsonSummary:%@", jsonSummary);
        
        //Send the request
        NSURLResponse *requestResponse;
        NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)requestResponse;
        NSData *requestHandler = [NSURLConnection sendSynchronousRequest:request returningResponse:&requestResponse error:nil];
        NSInteger statusCode = [HTTPResponse statusCode];
        NSLog(@"Status:%zd",statusCode);
        //self.lblResult.text = (statusCode == 0) ? (@"Login successful") : (@"Login failed");
        NSString *requestReply = [[NSString alloc] initWithBytes:[requestHandler bytes] length:[requestHandler length] encoding:NSASCIIStringEncoding];
        NSLog(@"Server reply: %@", requestReply);
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        [self alertStatus:@"Sign in failed." :@"Error!" :0];
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
    
    Boolean result = [self doesExist:self.txtEmail.text];
    
}

-(Boolean)doesExist:(NSString*) userName {
    
    NSInteger success = 0;
    @try {
        
        NSString *emailStr = self.txtEmail.text;
        
        NSMutableDictionary *email = [[NSMutableDictionary alloc] init];
        [email setObject:emailStr forKey:@"email"];
        NSMutableDictionary *doesExist = [[NSMutableDictionary alloc] init];
        [doesExist setObject:email forKey:@"doesExist"];
        
        // create a JSONObject from the NSDictionary and an error object
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:doesExist options:NSJSONWritingPrettyPrinted error:&error];
        
        //Create a request
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:@"http://pickupapp.herokuapp.com/users/exist"]];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:jsonData];
        
        //TO BE REMOVED. DEBUGGING.
        //Print out the data contents
        NSString *jsonSummary = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"jsonSummary:%@", jsonSummary);
        
        //Send the request
        NSURLResponse *requestResponse;
        NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)requestResponse;
        NSData *requestHandler = [NSURLConnection sendSynchronousRequest:request returningResponse:&requestResponse error:nil];
        NSInteger statusCode = [HTTPResponse statusCode];
        NSLog(@"Status:%zd",statusCode);
        //self.lblResult.text = (statusCode == 0) ? (@"Login successful") : (@"Login failed");
        NSString *requestReply = [[NSString alloc] initWithBytes:[requestHandler bytes] length:[requestHandler length] encoding:NSASCIIStringEncoding];
        NSLog(@"Server reply: %@", requestReply);
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        [self alertStatus:@"Sign in failed." :@"Error!" :0];
    }
    if (success) {
        [self performSegueWithIdentifier:@"login_success" sender:self];
    }
    
}

- (BOOL)returnTextField:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}


@end
