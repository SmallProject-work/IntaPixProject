//
//  AppDelegate.h
//  inta_pix
//
//  Created by test on 22/08/16.
//  Copyright © 2016 gauganTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IIViewDeckController.h"
#import "IISideController.h"

#import "Reachability.h"
#import "MBProgressHUD.h"

#import "PayPalMobile.h"
#import <Stripe/Stripe.h>

//#import "MFSideMenuContainerViewController.h"
@class SWRevealViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate,NSURLSessionDelegate,NSURLSessionTaskDelegate, NSURLSessionDataDelegate>

@property (strong, nonatomic) UIWindow *window;
//@property (strong, nonatomic) SWRevealViewController *viewController;
@property (retain, nonatomic) UIViewController *centerController;

-(void) galleryRootVCMethod;
-(void) profileRootVCMethod;
-(void) videoRootVCMethod;
-(void) feedbackRootVCMethod;
-(void) logoutRootVCMethod;


-(void) musicRootVCMethod;
-(void) filterRootVCMethod;
-(void) descriptionRootVCMethod;
-(void) paymentRootVCMethod;

-(void)nextController;
//-(void)drawerBtnAction;
@end

