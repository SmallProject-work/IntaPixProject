//
//  ThankYouViewController.h
//  inta_pix
//
//  Created by test on 24/08/16.
//  Copyright © 2016 gauganTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "galleryViewController.h"

@interface ThankYouViewController : UIViewController
{
    IBOutlet UIButton *submit_btn_outlet;
    
    IBOutlet UITextField *email_txt_fld;
}
- (IBAction)submit_btn_action:(id)sender;

@end
