//
//  ThankYouViewController.m
//  inta_pix
//
//  Created by test on 24/08/16.
//  Copyright © 2016 gauganTechnologies. All rights reserved.
//

#import "ThankYouViewController.h"

@interface ThankYouViewController ()

@end

@implementation ThankYouViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    email_txt_fld.clipsToBounds = true;
    email_txt_fld.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    email_txt_fld.layer.borderWidth = 2;
    email_txt_fld.layer.cornerRadius = 10;
    NSAttributedString *passwordStr = [[NSAttributedString alloc] initWithString:@"    Your Email ID" attributes:@{ NSForegroundColorAttributeName : [UIColor lightGrayColor] }];
    email_txt_fld.attributedPlaceholder = passwordStr;
    
    submit_btn_outlet.clipsToBounds = true;
    submit_btn_outlet.layer.cornerRadius = 10;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Button_Action
- (IBAction)submit_btn_action:(id)sender
{
    
    [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"chkLftController"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    galleryViewController *galleryVC = [self.storyboard instantiateViewControllerWithIdentifier:@"galleryViewController"];
    //self.viewDeckController.centerController = galleryVC;
    
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"chkNxtThankYouViewController"])
    {
        [self.navigationController pushViewController:galleryVC animated:YES];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"chkNxtThankYouViewController"];
    }
    else
    {
        self.viewDeckController.centerController = galleryVC;
        
        [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"chkNxtThankYouViewController"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        
        
    }

    
    
    
//        for (UIViewController *controller in self.navigationController.viewControllers) {
//    
//            //Do not forget to import AnOldViewController.h
//            if ([controller isKindOfClass:[galleryViewController class]]) {
//    
//                NSLog(@"logout");
//    
//               // [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"LogIn"];
//    
//    
//                [self.navigationController popToViewController:controller
//                                                      animated:YES];
//                break;
//            }
//        }

}
@end
