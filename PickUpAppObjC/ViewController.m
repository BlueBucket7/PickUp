//
//  ViewController.m
//  PickUpAppObjC
//
//  Created by SJ on 2014-10-01.
//  Copyright (c) 2014 Wolfpack. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginClicked:(id)sender {
    NSInteger success = 0;
    @try {        
        
        //
        NSString *emailStr = self.txtEmail.text;
        NSString *passwordStr = self.txtPassword.text;
        
        NSMutableDictionary *user = [[NSMutableDictionary alloc] init];
        [user setObject:emailStr forKey:@"email"];
        [user setObject:passwordStr forKey:@"password"];
        NSMutableDictionary *userLogin = [[NSMutableDictionary alloc] init];
        [userLogin setObject:user forKey:@"userLogin"];
        
        // create a JSONObject from the NSDictionary and an error object
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:userLogin options:NSJSONWritingPrettyPrinted error:&error];
        
        //Create a request
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:@"http://pickupapp.herokuapp.com/users/login"]];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:jsonData];
        
        //TO BE REMOVED. DEBUGGING.
        //Print out the data contents
        NSString *jsonSummary = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"jsonSummary:%@", jsonSummary);

        //Send the request
        NSURLResponse *requestResponse;
        NSData *requestHandler = [NSURLConnection sendSynchronousRequest:request returningResponse:&requestResponse error:nil];
        NSString *requestReply = [[NSString alloc] initWithBytes:[requestHandler bytes] length:[requestHandler length] encoding:NSASCIIStringEncoding];
        NSLog(@"requestReply: %@", requestReply);
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
}

- (BOOL)returnTextField:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}
@end
