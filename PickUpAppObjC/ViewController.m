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
        
        NSString *emailStr = self.txtEmail.text;
        NSString *passwordStr = self.txtPassword.text;
        
        NSMutableDictionary *user = [[NSMutableDictionary alloc] init];
        [user setObject:emailStr forKey:@"email"];
        [user setObject:passwordStr forKey:@"password"];
        NSMutableDictionary *userLogin = [[NSMutableDictionary alloc] init];
        [userLogin setObject:user forKey:@"userLogin"];
        
        
//        NSDictionary *emailDict = [[NSDictionary alloc] initWithObjectsAndKeys:emailStr, @"email", nil];
//        NSDictionary *passwordDict = [[NSDictionary alloc] initWithObjectsAndKeys:passwordStr, @"password", nil];
//        NSArray *userDict = [[NSArray alloc] initWithObjects:emailDict, passwordDict, nil];
//        NSDictionary *loginDict = [[NSDictionary alloc] initWithObjectsAndKeys:userDict, @"userLogin", nil];
        
        // create a JSON string from the NSDictionary
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:userLogin options:NSJSONWritingPrettyPrinted error:&error];
//        NSString *jsonString = [[NSString alloc] init];
//        if (!jsonData) {
//            NSLog(@"Got an error: %@", error);
//        } else {
//            jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//        }
        
        
        //Create a request
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:@"http://pickupapp.herokuapp.com/users/login"]];
        [request setHTTPMethod:@"POST"];
        //[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:jsonData];
        
        //print out the data contents
        NSString *jsonSummary = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"jsonSummary:%@", jsonSummary);

        //Send the request
        NSURLResponse *requestResponse;
        NSData *requestHandler = [NSURLConnection sendSynchronousRequest:request returningResponse:&requestResponse error:nil];
        NSString *requestReply = [[NSString alloc] initWithBytes:[requestHandler bytes] length:[requestHandler length] encoding:NSASCIIStringEncoding];
        NSLog(@"requestReply: %@", requestReply);
        
//        //Create a request
//        NSURL *url=[NSURL URLWithString:@"http://pickupapp.herokuapp.com/users/login"];
//        NSData *postData = [jsonString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
//        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//        [request setURL:url];
//        [request setHTTPMethod:@"POST"];
//        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
//        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//        //[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//        [request setHTTPBody:postData];
//        
//        //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
//        
//        //NSError *error = [[NSError alloc] init];
//        NSHTTPURLResponse *response = nil;
//        NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//        
//        NSLog(@"Response code: %ld", (long)[response statusCode]);

        
        
        
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
