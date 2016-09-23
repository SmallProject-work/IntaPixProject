//
//  FiltersViewController.h
//  inta_pix
//
//  Created by test on 24/08/16.
//  Copyright © 2016 gauganTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DescriptionViewController.h"
#import "filterTableViewCell.h"
#import "IIViewDeckController.h"
#import "IISideController.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "Reachability.h"


@interface FiltersViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NSURLSessionDelegate,NSURLSessionTaskDelegate, NSURLSessionDataDelegate>
{
    
    IBOutlet UITableView *filterListTableVw;
    
    IBOutlet UIView *filterView;
    
    IBOutlet UIImageView *selected_filter_imgVw;
}
- (IBAction)drawerBtnAction:(id)sender;
- (IBAction)next_btn_action:(id)sender;
- (IBAction)selectBtn_action:(id)sender;
- (IBAction)removeBtn_action:(id)sender;
-(void)postMethod;
@end
