//
//  ViewController.h
//  inta_pix
//
//  Created by test on 22/08/16.
//  Copyright © 2016 gauganTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "galleryViewController.h"
#import "LoginViewController.h"
//#import "TPKeyboardAvoidingScrollView.h"


@interface ViewController : UIViewController<UITextFieldDelegate,NSURLSessionDelegate,NSURLSessionTaskDelegate, NSURLSessionDataDelegate>
{
    IBOutlet UITextField *first_nameTxtFld;
    
    IBOutlet UITextField *last_nameTxtFld;
    
    IBOutlet UITextField *email_txtFld;
    
    IBOutlet UITextField *password_txtFld;
    
    IBOutlet UIButton *register_btn_outlet;
    
    IBOutlet UIButton *loginBtn_outlet;
}

//@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *backgroundScrollView;

- (IBAction)register_btn_action:(id)sender;

- (IBAction)login_btn_action:(id)sender;
-(void)postMethod;
- (void)addViewTapGesture;
@end

