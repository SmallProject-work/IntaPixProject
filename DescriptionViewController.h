//
//  DescriptionViewController.h
//  inta_pix
//
//  Created by test on 24/08/16.
//  Copyright © 2016 gauganTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaymentViewController.h"
#import "AppDelegate.h"
#import "IIViewDeckController.h"
#import "IISideController.h"
#import "MBProgressHUD.h"
#import "Reachability.h"

@interface DescriptionViewController : UIViewController<NSURLSessionDelegate,NSURLSessionTaskDelegate, NSURLSessionDataDelegate,UITextViewDelegate>
{
    
    IBOutlet UITextView *description_txtVw;
    IBOutlet UIButton *submit_btn_outlet;
}
- (IBAction)drawer_btn_action:(id)sender;
- (IBAction)submit_btn_action:(id)sender;
- (IBAction)next_btn_action:(id)sender;
-(void)postMethod;
- (void)addViewTapGesture;
@end
