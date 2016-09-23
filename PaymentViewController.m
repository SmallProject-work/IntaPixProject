//
//  PaymentViewController.m
//  inta_pix
//
//  Created by test on 24/08/16.
//  Copyright © 2016 gauganTechnologies. All rights reserved.
//

#import "PaymentViewController.h"
#import <QuartzCore/QuartzCore.h>

#define kPayPalEnvironment PayPalEnvironmentNoNetwork

@interface PaymentViewController ()

{
    AppDelegate *appdelegatePayment;
}
@property(nonatomic, strong, readwrite) PayPalConfiguration *payPalConfig;

@end

@implementation PaymentViewController
- (BOOL)acceptCreditCards {
    return self.payPalConfig.acceptCreditCards;
}

- (void)setAcceptCreditCards:(BOOL)acceptCreditCards {
    self.payPalConfig.acceptCreditCards = acceptCreditCards;
}





- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Set up payPalConfig
    _payPalConfig = [[PayPalConfiguration alloc] init];
#if HAS_CARDIO
    // You should use the PayPal-iOS-SDK+card-Sample-App target to enable this setting.
    // For your apps, you will need to link to the libCardIO and dependent libraries. Please read the README.md
    // for more details.
    _payPalConfig.acceptCreditCards = YES;
#else
    _payPalConfig.acceptCreditCards = YES;
#endif
    
    
        
    _payPalConfig.languageOrLocale = [NSLocale preferredLanguages][0];
    
    
    // Setting the payPalShippingAddressOption property is optional.
    //
    // See PayPalConfiguration.h for details.
    
    _payPalConfig.payPalShippingAddressOption = PayPalShippingAddressOptionPayPal;
    
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    // use default environment, should be Production in real life
    self.environment = kPayPalEnvironment;
    
    NSLog(@"PayPal iOS SDK version: %@", [PayPalMobile libraryVersion]);
    
    
    
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"chkContPayment"])
    {
        [self.viewDeckController closeOpenView];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"chkContPayment"];
        
    }
    else
    {
        [appdelegatePayment paymentRootVCMethod];
        [self drawer_btn_Action:nil];
    }
    
    
    self.navigationItem.title = @"Payment";
    
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"left" style:UIBarButtonItemStyleBordered target:self.viewDeckController action:@selector(toggleLeftView)];
    
    
    if ([self.navigationItem respondsToSelector:@selector(leftBarButtonItems)]) {
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:
                                                  [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"drawerBtn"] style:UIBarButtonItemStyleBordered target:self.viewDeckController action:@selector(toggleLeftView)],nil];
        
        
        
        
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        [self.navigationController.navigationBar
         setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
        
        [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:235.0/255 green:87.0/255 blue:13.0/255 alpha:1]];
        
    }
    
    


}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    // Preconnect to PayPal early
    [self setPayPalEnvironment:self.environment];
}

- (void)setPayPalEnvironment:(NSString *)environment {
    self.environment = environment;
    [PayPalMobile preconnectWithEnvironment:environment];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Button_Action
- (IBAction)drawer_btn_Action:(id)sender
{
   [appdelegatePayment paymentRootVCMethod];
    
    [self.viewDeckController toggleLeftView];

}

- (IBAction)next_btn_action:(id)sender
{
    ThankYouViewController *thankVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ThankYouViewController"];
    self.viewDeckController.centerController = thankVC;
    
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"chkNxtPaymentController"])
    {
        [self.navigationController pushViewController:thankVC animated:YES];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"chkNxtPaymentController"];
    }
    else
    {
        self.viewDeckController.centerController = thankVC;
        [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"chkNxtPaymentController"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"chkNxtThankYouViewController"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
   
    }


}

- (IBAction)payment_btn_action:(id)sender
{
    stripePaymentViewController *stripeVC = [[stripePaymentViewController alloc] initWithNibName:nil bundle:nil];

//        self.viewDeckController.centerController = stripeVC;
    
    //stripePaymentViewController *paymentViewController = [[PaymentViewController alloc] initWithNibName:nil bundle:nil];
    stripeVC.amount = [NSDecimalNumber decimalNumberWithString:@"1.50"];
    stripeVC.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:stripeVC];
    
    [self presentViewController:navController animated:YES completion:nil];

}

#pragma mark - stripePaymentViewControllerDelegate Methods
- (void)stripePaymentViewController:(stripePaymentViewController *)controller didFinish:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:^{
        if (error) {
            [self showDialougeWithTitle:@"Error" andMessage:[error localizedDescription]];
        } else {
            [self showDialougeWithTitle:@"Success" andMessage:@"Payment Successfully Created."];
        }
    }];
}

#pragma mark - Other Methods
- (void)showDialougeWithTitle:(NSString *)strTitle andMessage:(NSString *)strMessage
{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:strTitle message:strMessage preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [controller addAction:action];
    
    [self presentViewController:controller animated:YES completion:nil];
}


- (IBAction)payPal_btn_Action:(id)sender
{
    self.resultText = nil;
    
    // Note: For purposes of illustration, this example shows a payment that includes
    //       both payment details (subtotal, shipping, tax) and multiple items.
    //       You would only specify these if appropriate to your situation.
    //       Otherwise, you can leave payment.items and/or payment.paymentDetails nil,
    //       and simply set payment.amount to your total charge.
    
    // Optional: include multiple items
    PayPalItem *item1 = [PayPalItem itemWithName:@"Old jeans with holes"
                                    withQuantity:2
                                       withPrice:[NSDecimalNumber decimalNumberWithString:@"84.99"]
                                    withCurrency:@"USD"
                                         withSku:@"Hip-00037"];
    PayPalItem *item2 = [PayPalItem itemWithName:@"Free rainbow patch"
                                    withQuantity:1
                                       withPrice:[NSDecimalNumber decimalNumberWithString:@"0.00"]
                                    withCurrency:@"USD"
                                         withSku:@"Hip-00066"];
    PayPalItem *item3 = [PayPalItem itemWithName:@"Long-sleeve plaid shirt (mustache not included)"
                                    withQuantity:1
                                       withPrice:[NSDecimalNumber decimalNumberWithString:@"37.99"]
                                    withCurrency:@"USD"
                                         withSku:@"Hip-00291"];
    NSArray *items = @[item1, item2, item3];
    NSDecimalNumber *subtotal = [PayPalItem totalPriceForItems:items];
    
    // Optional: include payment details
    NSDecimalNumber *shipping = [[NSDecimalNumber alloc] initWithString:@"5.99"];
    NSDecimalNumber *tax = [[NSDecimalNumber alloc] initWithString:@"2.50"];
    PayPalPaymentDetails *paymentDetails = [PayPalPaymentDetails paymentDetailsWithSubtotal:subtotal
                                                                               withShipping:shipping
                                                                                    withTax:tax];
    
    NSDecimalNumber *total = [[subtotal decimalNumberByAdding:shipping] decimalNumberByAdding:tax];
    
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    payment.amount = total;
    payment.currencyCode = @"USD";
    payment.shortDescription = @"Hipster clothing";
    payment.items = items;  // if not including multiple items, then leave payment.items as nil
    payment.paymentDetails = paymentDetails; // if not including payment details, then leave payment.paymentDetails as nil
    
    if (!payment.processable) {
        // This particular payment will always be processable. If, for
        // example, the amount was negative or the shortDescription was
        // empty, this payment wouldn't be processable, and you'd want
        // to handle that here.
    }
    
    // Update payPalConfig re accepting credit cards.
    self.payPalConfig.acceptCreditCards = self.acceptCreditCards;
    
    PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment
                                                                                                configuration:self.payPalConfig
                                                                                                     delegate:self];
    [self presentViewController:paymentViewController animated:YES completion:nil];
    
   
}

#pragma mark PayPalPaymentDelegate methods

- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController didCompletePayment:(PayPalPayment *)completedPayment {
    NSLog(@"PayPal Payment Success!");
    self.resultText = [completedPayment description];
    //[self showSuccess];
    
    [self sendCompletedPaymentToServer:completedPayment]; // Payment was processed successfully; send to server for verification and fulfillment
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController {
    NSLog(@"PayPal Payment Canceled");
    self.resultText = nil;
   // self.successView.hidden = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Proof of payment validation

- (void)sendCompletedPaymentToServer:(PayPalPayment *)completedPayment {
    // TODO: Send completedPayment.confirmation to server
    NSLog(@"Here is your proof of payment:\n\n%@\n\nSend this to your server for confirmation and fulfillment.", completedPayment.confirmation);
}


@end
