//
//  FeedbackViewController.h
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

@interface FeedbackViewController : UIViewController<UITextViewDelegate,NSURLSessionDelegate,NSURLSessionTaskDelegate, NSURLSessionDataDelegate>

@property (strong, nonatomic) IBOutlet UITextView *feedbackTxtView;
@property (strong, nonatomic) IBOutlet UIButton *feedbackBtnOutlet;

- (IBAction)feedbackBtnAction:(id)sender;

- (IBAction)drawerBtnAction:(id)sender;
-(void)postFeedbackMethod;
- (void)addViewTapGesture;
@end
