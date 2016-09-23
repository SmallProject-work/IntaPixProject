//
//  leftDrawerVC.h
//  inta_pix
//
//  Created by test on 24/08/16.
//  Copyright © 2016 gauganTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
#import "ProfileViewController.h"
#import "VideoViewController.h"
#import "FeedbackViewController.h"
#import "leftDrawerTableViewCell.h"
#import "IIViewDeckController.h"
#import "IISideController.h"
#import "galleryViewController.h"
#import "AppDelegate.h"


//#import "galleryViewController.h"

@interface leftDrawerVC : UIViewController
{
    NSInteger _presentedRow;
}
//@property (strong, nonatomic) IBOutlet UITableView *drawerTableView;

@property (strong, nonatomic) IBOutlet AsyncImageView *profileImageVw;

- (IBAction)galleryBtnAction:(id)sender;

- (IBAction)profile_btn_action:(id)sender;

- (IBAction)video_btn_action:(id)sender;

- (IBAction)feedback_btn_Action:(id)sender;

- (IBAction)logout_btn_action:(id)sender;


@end
