//
//  LoginViewController.h
//  inta_pix
//
//  Created by test on 22/08/16.
//  Copyright © 2016 gauganTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "galleryViewController.h"
#import "MBProgressHUD.h"
#import "Reachability.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate,NSURLSessionDelegate,NSURLSessionTaskDelegate, NSURLSessionDataDelegate>
{
    
    IBOutlet UITextField *email_txtFld;
    
    IBOutlet UITextField *password_txtFld;
    
    IBOutlet UIButton *loginBtn_outlet;
    
    IBOutlet UIButton *back_btn_outlet;
    
    IBOutlet UIView *forgotView;
    
    IBOutlet UITextField *forgotEmailTxtFld;
    
    IBOutlet UIButton *sendBtnOutlet;
}
-(void)postMethod;
-(void)postForgotMethod;
- (IBAction)loginBtn_Action:(id)sender;
- (IBAction)back_btn_Action:(id)sender;
- (IBAction)sendBtnAction:(id)sender;
- (IBAction)forgotBtnAction:(id)sender;
- (IBAction)removeForgotViwBtnAction:(id)sender;
- (void)addViewTapGesture;
@end
