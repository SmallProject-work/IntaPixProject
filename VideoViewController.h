//
//  VideoViewController.h
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
#import "AFNetworking.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "videoWebViewController.h"

@interface VideoViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *VideoListTableView;

- (IBAction)drawerBtnAction:(id)sender;
-(void)downloadVideoMethod;
-(void)downloadVideo;
-(void)listFileAtPath:(NSString *)path;
-(void)retriveVideoLocalDirectory;
@end
