//
//  galleryViewController.h
//  inta_pix
//
//  Created by test on 22/08/16.
//  Copyright © 2016 gauganTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "ELCImagePickerHeader.h"
#import "leftDrawerVC.h"
#import "galleryTableViewCell.h"
#import "MusicViewController.h"
#import "IIViewDeckController.h"
#import "IISideController.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "AFNetworking.h"


@interface galleryViewController : UIViewController<ELCImagePickerControllerDelegate, UINavigationControllerDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate, IIViewDeckControllerDelegate,NSURLSessionDelegate,NSURLSessionTaskDelegate, NSURLSessionDataDelegate,UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    
    IBOutlet UIButton *lib_btn_outlet;
    
    IBOutlet UICollectionView *selected_imgs_collectionVw;
    
    IBOutlet UIView *side_menu_drawerVw;
    
    IBOutlet UIScrollView *scrollView;
    
    IBOutlet UITableView *imagesTableView;
    IBOutlet UIButton *del_btn_outlet;
}

@property (strong, nonatomic) IBOutlet UIButton *drawerBtn_outlet;

@property (nonatomic, strong) NSString *loginStr;


@property (retain, nonatomic) UIViewController *centerController;
@property (retain, nonatomic) UIViewController *leftController;
@property (nonatomic, copy) NSArray *chosenImages;


- (IBAction)lib_btn_action:(id)sender;
- (IBAction)drawerBtn_action:(id)sender;
- (IBAction)next_btn_action:(id)sender;
- (IBAction)del_btn_action:(id)sender;
-(void)SetupSideMenu;
-(void)postImagesMethod;

@end
