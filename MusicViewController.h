//
//  MusicViewController.h
//  inta_pix
//
//  Created by test on 24/08/16.
//  Copyright © 2016 gauganTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FiltersViewController.h"
#import "musicTableViewCell.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "IIViewDeckController.h"
#import "IISideController.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "AFNetworking.h"

@interface MusicViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NSURLSessionDelegate,NSURLSessionTaskDelegate, NSURLSessionDataDelegate>
{
    IBOutlet UITextField *songNameTxtFld;
    
    IBOutlet UIButton *selectSongBtnOutlet;
    IBOutlet UIButton *playBtnOutlet;
    IBOutlet UIImageView *songImageVw;
    IBOutlet UITableView *songListTableView;
}
-(void)importSongs;
- (IBAction)drawerBtnAction:(id)sender;
- (IBAction)playBtnAction:(id)sender;
- (IBAction)rewindBtnAction:(id)sender;
- (IBAction)forwardBtnAction:(id)sender;
- (IBAction)volumeBtnAction:(id)sender;
- (IBAction)nextBtnAction:(id)sender;
- (IBAction)selectBtnAction:(id)sender;

-(void)postAudioMethod;
-(void)postAudioNameMethod;
-(void)addViewTapGesture;
@end
