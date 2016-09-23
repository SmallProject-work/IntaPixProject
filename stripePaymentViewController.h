//
//  PaymentViewController.h
//  Stripe
//
//  Created by Alex MacCaw on 3/4/13.
//
//

#import <UIKit/UIKit.h>

@class stripePaymentViewController;

@protocol stripePaymentViewControllerDelegate<NSObject>

- (void)stripePaymentViewController:(stripePaymentViewController *)controller didFinish:(NSError *)error;

@end

@interface stripePaymentViewController : UIViewController

@property (nonatomic) NSDecimalNumber *amount;
@property (nonatomic, weak) id<stripePaymentViewControllerDelegate> delegate;

@end
