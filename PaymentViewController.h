//
//  PaymentViewController.h
//  inta_pix
//
//  Created by test on 24/08/16.
//  Copyright © 2016 gauganTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThankYouViewController.h"
#import "AppDelegate.h"
#import "IIViewDeckController.h"
#import "IISideController.h"
#import "PayPalMobile.h"
#import "stripePaymentViewController.h"




@interface PaymentViewController : UIViewController<PayPalPaymentDelegate, PayPalFuturePaymentDelegate, PayPalProfileSharingDelegate, UIPopoverControllerDelegate,stripePaymentViewControllerDelegate>
{
    IBOutlet UIButton *paymentBtnOutlet;
    
    IBOutlet UIButton *payPal_btn_outlet;
}
- (IBAction)drawer_btn_Action:(id)sender;
- (IBAction)next_btn_action:(id)sender;
- (IBAction)payment_btn_action:(id)sender;
- (IBAction)payPal_btn_Action:(id)sender;

@property(nonatomic, strong, readwrite) NSString *environment;
@property(nonatomic, assign, readwrite) BOOL acceptCreditCards;
@property(nonatomic, strong, readwrite) NSString *resultText;



@end
