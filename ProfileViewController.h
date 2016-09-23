//
//  ProfileViewController.h
//  inta_pix
//
//  Created by test on 26/08/16.
//  Copyright © 2016 gauganTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "IIViewDeckController.h"
#import "IISideController.h"
#import "leftDrawerVC.h"
#import "MBProgressHUD.h"
#import "Reachability.h"

@interface ProfileViewController : UIViewController<IIViewDeckControllerDelegate,UIGestureRecognizerDelegate,NSURLSessionDelegate,NSURLSessionTaskDelegate, NSURLSessionDataDelegate>
- (IBAction)drawerBtnAction:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *firstNameTxtFld;
@property (strong, nonatomic) IBOutlet UITextField *lastnameTxtFld;
@property (strong, nonatomic) IBOutlet UIButton *saveBtnOutlet;

- (IBAction)saveBtnAction:(id)sender;



@property (strong, nonatomic) IBOutlet UITextField *currentPawrdTxtFld;
@property (strong, nonatomic) IBOutlet UITextField *setPasswrdTxtFld;
@property (strong, nonatomic) IBOutlet UITextField *confirmPasswrdTxtFld;
@property (strong, nonatomic) IBOutlet UIButton *saveChangesBtnOutlet;
- (IBAction)saveChangBtnAction:(id)sender;
-(void)postMethodChangePassword;
-(void)postMethodChangeName;
-(void)addViewTapGesture;

@end
