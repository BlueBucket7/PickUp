//
//  ViewController.h
//  PickUpAppObjC
//
//  Created by SJ on 2014-10-01.
//  Copyright (c) 2014 Wolfpack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblResult;

- (IBAction)loginClicked:(id)sender;
- (IBAction)backgroundTap:(id)sender;

@end

