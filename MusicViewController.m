//
//  MusicViewController.m
//  inta_pix
//
//  Created by test on 24/08/16.
//  Copyright © 2016 gauganTechnologies. All rights reserved.
//

#import "MusicViewController.h"
#import "GVMusicPlayerController.h"

@interface MusicViewController ()<AVAudioPlayerDelegate,MPMediaPickerControllerDelegate,GVMusicPlayerControllerDelegate,IIViewDeckControllerDelegate>
{
    NSArray *songsListArray;
    NSString *selectedSongStr;
    NSArray *songListImgAry;
    AVAudioPlayer *audioPlayer;
    NSInteger index;
    NSIndexPath *selectedIndexPath ;
    AppDelegate *appdelegate;
    NSURL *url;
    NSString *selectedSong;
    NSString *userId;
    NSString *userNAme;
}

@end

@implementation MusicViewController
bool playing;
bool showgreenObj;
bool PlayBtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
    
   
    //[self drawerBtnAction:nil];
    // Do any additional setup after loading the view.
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"chkContMusic"])
    {
        [self.viewDeckController closeOpenView];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"chkContMusic"];
        
    }
    else
    {
        [appdelegate musicRootVCMethod];
        [self drawerBtnAction:nil];
    }

    
    
    songsListArray = [[NSArray alloc]init];
    songsListArray = @[@"salamisound-1020015-cars-passing-over-manhole",@"salamisound-1020017-tram-driving-past-with-normal"];
    
    songListImgAry = [[NSArray alloc]init];
    songListImgAry = @[@"logo.png",@"logo.png"];
    
    UIImage * buttonImage = [UIImage imageNamed:@"playBtn"];
    
    [playBtnOutlet setBackgroundImage:buttonImage forState:UIControlStateNormal];
    
    
    //self.viewDeckController.panningGestureDelegate = self;
   // [self.viewDeckController toggleLeftView];
    
    
    
    self.navigationItem.title = @"Music";
    
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"left" style:UIBarButtonItemStyleBordered target:self.viewDeckController action:@selector(toggleLeftView)];
    
    
    if ([self.navigationItem respondsToSelector:@selector(leftBarButtonItems)]) {
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:
                                                  [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"drawerBtn"] style:UIBarButtonItemStyleBordered target:self.viewDeckController action:@selector(toggleLeftView)],nil];
        
        
        
        
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        [self.navigationController.navigationBar
         setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
        
        [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:235.0/255 green:87.0/255 blue:13.0/255 alpha:1]];
        

    }
    [self addViewTapGesture];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSString *stored_userID = [[NSUserDefaults standardUserDefaults] valueForKey:@"User_id"];
    userId = [NSString stringWithFormat:@"%@",stored_userID];
    NSLog(@"userIdStr %@",userId);
    
    NSString *stored_userName = [[NSUserDefaults standardUserDefaults] valueForKey:@"User_Name"];
    userNAme = [NSString stringWithFormat:@"%@",stored_userName];
    NSLog(@"userIdStr %@",userNAme);
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
}

//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Button_Action
- (IBAction)drawerBtnAction:(id)sender
{
    [appdelegate musicRootVCMethod];
    
    [self.viewDeckController toggleLeftView];
}

- (IBAction)playBtnAction:(id)sender

{
    if (PlayBtn == NO)
    {
        
        UIImage * buttonImage = [UIImage imageNamed:@"playBtn"];
        
        [playBtnOutlet setBackgroundImage:buttonImage forState:UIControlStateNormal];
        
        url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:[songsListArray objectAtIndex:0] ofType:@"mp3"]];
        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
        [[AVAudioSession sharedInstance] setActive: YES error: nil];
        [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
        [audioPlayer play];
        
        playing=YES;
        PlayBtn = YES;
    }
    
    else
    {
        if (playing==NO)
        {
            
            
            UIImage * buttonImage = [UIImage imageNamed:@"playBtn"];
            
            [playBtnOutlet setBackgroundImage:buttonImage forState:UIControlStateNormal];
            //index = 0;
          url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:selectedSongStr ofType:@"mp3"]];
            audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
            [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
            [[AVAudioSession sharedInstance] setActive: YES error: nil];
            [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
            [audioPlayer play];
            
            playing=YES;
        }
        else if(playing==YES)
        {
            UIImage * buttonImage = [UIImage imageNamed:@"pauseBtn"];

            [playBtnOutlet setBackgroundImage:buttonImage forState:UIControlStateNormal];

            [audioPlayer pause];
            
            playing=NO;
            
        }
    }
   
}


- (IBAction)rewindBtnAction:(id)sender
{
    if (index != 0)
    {
        index--;
        playing = NO;
        NSString *str = [songsListArray objectAtIndex:index];
        NSLog(@"str %@",str);
        selectedSongStr = [songsListArray objectAtIndex:index];
        [self playBtnAction:nil];
    }
    else if(index == 0)
    {
        index = 0;
        playing = NO;
        [audioPlayer pause];
    }
}

- (IBAction)forwardBtnAction:(id)sender
{
    
    if (index < songsListArray.count)
    {
        playing = NO;
        NSString *nextsongStr = [songsListArray objectAtIndex:index];
        
        
        NSLog(@"nextsongStr %@",nextsongStr);
        selectedSongStr = [songsListArray objectAtIndex:index];
        [self playBtnAction:nil];
        index++;
        
    }
    else if(index == songsListArray.count)
    {
        playing = NO;
        index=0;
        NSString *nextsongStr = [songsListArray objectAtIndex:index];
        
        NSLog(@"nextsongStr %@",nextsongStr);
        selectedSongStr = [songsListArray objectAtIndex:index];
        //index--;
        [self playBtnAction:nil];
        
    }
}

- (IBAction)volumeBtnAction:(id)sender
{
    
}

- (IBAction)nextBtnAction:(id)sender
{
   // [self postAudioMethod];
    [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"chkContFilter"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    FiltersViewController *filterVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FiltersViewController"];
    
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"chkNxtMusicController"])
    {
        [self.navigationController pushViewController:filterVC animated:YES];
         [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"chkNxtMusicController"];

//   self.viewDeckController.centerController = filterVC;
    }
    else
    {
         self.viewDeckController.centerController = filterVC;
       // [self.navigationController pushViewController:filterVC animated:YES];
        [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"chkNxtMusicController"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"chkNxtFiltersController"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (IBAction)selectBtnAction:(id)sender
{
    if (songNameTxtFld.text.length == 0)
    {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Enter song name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        [self postAudioNameMethod];
    }
    
}
#pragma mark - Post method

-(void)postAudioNameMethod
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            NSLog(@"There is no internet connection");
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"There is no internet connection" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
        });
    }
    else
    {
        NSLog(@"There IS internet connection");
        
        NSString* escapedID = [userId stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        
        
        NSString* escapedNmae = [userNAme stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        
        
        NSString* escapedSong = [songNameTxtFld.text stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        
        
        NSString *fullAuthUrlString;
        
        
        //corporate
        NSLog(@"coorporate");
        fullAuthUrlString = [[NSString alloc]
                             initWithFormat:@"http://gaugantech.com/intapix/api/do_music_name.php?user_id=%@&user_name=%@&track_name=%@&submit=Select",escapedID,escapedNmae,escapedSong];
        // login API URL:- http://gaugantech.com/intapix/do_log.php?email=vinod%40gmail.com&password=123&submit=Log+in
        
        NSURL *authUrl = [NSURL URLWithString:fullAuthUrlString];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:authUrl];
        
        NSLog(@"authUrl %@",authUrl);
        NSLog(@"request %@",request);
        
        
        
        
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        
        [request setHTTPMethod:@"POST"];
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
          {
              
              NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
              NSUInteger responseStatusCode = [httpResponse statusCode];
              if (error == nil)
              {
                  if (responseStatusCode == 200)
                  {
                      
                      
                      NSLog(@"response: %@", response);
                      NSLog(@"data: %@", data);
                      
                      NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                      NSLog(@"requestReply: %@", requestReply);
                      
                      NSMutableArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: nil];
                      NSLog(@"jsonArray: %@", jsonArray);
                      
                      
                      dispatch_sync(dispatch_get_main_queue(), ^{
                          [MBProgressHUD hideHUDForView:self.view animated:YES];
                          
                          UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:requestReply delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                          [alert show];
                      });
                      
                      
                      
                      
                  }
                  
              }
              else
              {
                  dispatch_sync(dispatch_get_main_queue(), ^{
                      [MBProgressHUD hideHUDForView:self.view animated:YES];
                      NSLog(@"error: %@", error.localizedDescription);
                      
                      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                      [alert show];
                      
                  });
              }
          }] resume];
        
    }
    
}



-(void)postAudioMethod
{
    
    if ([url isEqual:@""])
    {
        NSLog(@"select song");
    }
    else
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
        NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
        if (networkStatus == NotReachable)
        {
            dispatch_sync(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                NSLog(@"There is no internet connection");
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"There is no internet connection" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                
            });
        }
        else
        {
           
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
            //NSURL *filePath = [NSURL fileURLWithPath:fileName];
            
            NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://gaugantech.com/intapix/api/audio_upload.php"
                                                                                                     parameters:nil
                                                                                      constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                                                                          [formData appendPartWithFileURL:url name:@"userfile" fileName:[NSString stringWithFormat:@"%@-%@.mp3",userId,selectedSongStr] mimeType:@"audio/mp3" error:nil];
                                                                                      } error:nil];
            
            AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
           

           
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            
           // NSProgress *progress = nil;
            NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
                if (error) {
                    NSLog(@"Error: %@", error);
                    NSString* ErrorResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
                    NSLog(@"Error Error%@",ErrorResponse);
                      [MBProgressHUD hideHUDForView:self.view animated:YES];
                } else {
                    NSLog(@"%@ %@", response, responseObject);
                    NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                                          NSLog(@"string %@",string);
                                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                }
            } ];
            [uploadTask resume];
        }

    }
}


#pragma mark - Tableview delegate method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [songsListArray count];
    
    
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[self importSongs];
    
    
    musicTableViewCell *cell = (musicTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"musicTableViewCell"];
    // NSIndexPath *selectedIndexPath = [tableView indexPathForSelectedRow];
    if (cell == nil) {
        //        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TalentSearchTableViewCell"];
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"musicTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    

    cell.imageVw.image = [UIImage imageNamed:[songListImgAry objectAtIndex:indexPath.row]];
    cell.song_title_lbl.text = [songsListArray objectAtIndex:indexPath.row];
   // cell.userImgView.layer.borderColor = [[UIColor colorWithRed:78/255.0 green:181/255.0 blue:255/255.0 alpha:1]CGColor];
     //cell.greenLbl.hidden = true;
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor colorWithRed:195/255.0 green:140/255.0 blue:26/255.0 alpha:0.2];
    [cell setSelectedBackgroundView:bgColorView];
     selectedIndexPath = [tableView indexPathForSelectedRow];
    
    UITableView* table = (UITableView *)[cell superview];
    NSIndexPath* pathOfTheCell = [table indexPathForCell:cell];
    NSInteger rowOfTheCell = [pathOfTheCell row];
    NSLog(@"rowofthecell %ld", (long)rowOfTheCell);
    
    [[cell selectionBtnOutlet] addTarget:self action:@selector(onActionSelectSong:event:) forControlEvents:UIControlEventTouchUpInside];
   
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    showgreenObj = true;
    selectedIndexPath = [tableView indexPathForSelectedRow];
    NSLog(@"selectedIndexPath %@",selectedIndexPath);
    selectedSongStr = [songsListArray objectAtIndex:indexPath.row];
    NSLog(@"selectedSongStr %@",selectedSongStr);
       songImageVw.image = [UIImage imageNamed:[songListImgAry objectAtIndex:indexPath.row]];
    //[songListTableView reloadData];
    [self playBtnAction:nil];
    index++;
    
    
   

}

- (IBAction)onActionSelectSong:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches];
    
    UITouch *touch = [touches anyObject];
    
    CGPoint currentTouchPosition = [touch locationInView:songListTableView];
    
    
    NSIndexPath *indexPath = [songListTableView indexPathForRowAtPoint: currentTouchPosition];
    NSLog(@"index %@",indexPath);
    
   // NSInteger rowOfTheCell = [indexPath row];
    //selectedSongStr
    selectedSongStr = [songsListArray objectAtIndex:indexPath.row];
    NSLog(@"planIDStrvalue %@",selectedSong);
    
    UIButton *button = (UIButton *)sender; // this is the button that was clicked
    
    if ([button.imageView.image isEqual:[UIImage imageNamed:@"checkImage"]])
    {
         [button setImage:[UIImage imageNamed:@"unCheckImage"] forState:UIControlStateNormal];
        
    }
    else
    {
          [button setImage:[UIImage imageNamed:@"checkImage"] forState:UIControlStateNormal];
        [self playBtnAction:nil];
   
    }
    
   }

- (void)musicPlayer:(GVMusicPlayerController *)musicPlayer trackDidChange:(MPMediaItem *)nowPlayingItem previousTrack:(MPMediaItem *)previousTrack {
    if (!nowPlayingItem) {
      //self.chooseView.hidden = NO;
        return;
    }
    
//    self.chooseView.hidden = YES;
//    
//    // Time labels
//    NSTimeInterval trackLength = [[nowPlayingItem valueForProperty:MPMediaItemPropertyPlaybackDuration] doubleValue];
//    self.trackLengthLabel.text = [NSString stringFromTime:trackLength];
//    self.progressSlider.value = 0;
//    self.progressSlider.maximumValue = trackLength;
//    
//    // Labels
//    self.songLabel.text = [nowPlayingItem valueForProperty:MPMediaItemPropertyTitle];
//    self.artistLabel.text = [nowPlayingItem valueForProperty:MPMediaItemPropertyArtist];
    
    // Artwork
    MPMediaItemArtwork *artwork = [nowPlayingItem valueForProperty:MPMediaItemPropertyArtwork];
    if (artwork != nil) {
        songImageVw.image = [artwork imageWithSize:songImageVw.frame.size];
    }
    
    NSLog(@"Proof that this code is being called, even in the background!");
}

- (void)musicPlayer:(GVMusicPlayerController *)musicPlayer endOfQueueReached:(MPMediaItem *)lastTrack {
    NSLog(@"End of queue, but last track was %@", [lastTrack valueForProperty:MPMediaItemPropertyTitle]);
}

- (void)musicPlayer:(GVMusicPlayerController *)musicPlayer volumeChanged:(float)volume {
//    if (!self.panningVolume) {
//        self.volumeSlider.value = volume;
//    }
}

-(void)importSongs
{
    MPMediaPickerController *picker = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeMusic];
    picker.delegate = self;
    picker.allowsPickingMultipleItems = YES;
    [self presentViewController:picker animated:YES completion:nil];

}

- (void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker {
    [mediaPicker dismissViewControllerAnimated:YES completion:nil];
}

- (void)mediaPicker:(MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection {

}


#pragma mark - handle soft keyboard

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if([textField isEqual:songNameTxtFld])
    {
        if  (self.view.frame.origin.y >= 0)
        {
            [self keyboardDidShow:nil];
        }
    }
    NSLog(@"textFieldShouldBeginEditing");
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [[self view] endEditing:YES];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    NSLog(@"textFieldShouldEndEditing");
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    [self.view endEditing:YES];
    return YES;
}


- (void)keyboardDidShow:(NSNotification *)notification
{
    // Assign new frame to your view
    [self.view setFrame:CGRectMake(0,-130,self.view.frame.size.width,self.view.frame.size.height)]; //here taken -110 for example i.e. your view will be scrolled to -110. change its value according to your requirement.
    
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    [self.view setFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height+20)];
}



#pragma mark - helpers

- (void)addViewTapGesture
{
    UITapGestureRecognizer *singleTap;
    singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewWasTapped:)];
    
    [singleTap setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:singleTap];
}

- (void)viewWasTapped:(UITapGestureRecognizer *) singleTap
{
    [[self view] endEditing:YES];
}




@end
