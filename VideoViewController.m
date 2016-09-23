//
//  VideoViewController.m
//  inta_pix
//
//  Created by test on 26/08/16.
//  Copyright © 2016 gauganTechnologies. All rights reserved.
//

#import "VideoViewController.h"

@interface VideoViewController ()
{
    AppDelegate *appdelegateVideo;
    NSString *userIdStr;
    NSMutableArray *videodetailAry;
    NSString *videoUrlStr;
 
}

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawerBtnAction:nil];
    
    //self.navigationItem.title = @"Upload Photos";
    videodetailAry = [[NSMutableArray alloc]init];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"left" style:UIBarButtonItemStyleBordered target:self.viewDeckController action:@selector(toggleLeftView)];
    
    
    if ([self.navigationItem respondsToSelector:@selector(leftBarButtonItems)]) {
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:
                                                  [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"drawerBtn"] style:UIBarButtonItemStyleBordered target:self.viewDeckController action:@selector(toggleLeftView)],nil];
        
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        [self.navigationController.navigationBar
         setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
        
        [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:235.0/255 green:87.0/255 blue:13.0/255 alpha:1]];
        
    }
    [self downloadVideoMethod];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    appdelegateVideo = (AppDelegate *)[[UIApplication sharedApplication] delegate];
   
    NSString *stored_userID = [[NSUserDefaults standardUserDefaults] valueForKey:@"User_id"];
    userIdStr = [NSString stringWithFormat:@"%@",stored_userID];
    NSLog(@"userIdStr %@",userIdStr);

    
}
-(void)viewDidAppear:(BOOL)animated
{
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)drawerBtnAction:(id)sender
{
    [appdelegateVideo videoRootVCMethod];
    
    [self.viewDeckController toggleLeftView];
}

-(void)downloadVideoMethod
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = nil;
    
    [manager GET:@"http://gaugantech.com/intapix/api/user_video_get.php" parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         
        NSLog(@"JSON: %@", responseObject);
       NSMutableArray *jsonArray = [NSJSONSerialization JSONObjectWithData: responseObject options: NSJSONReadingMutableContainers error:nil];
         NSLog(@"jsonArray %@",jsonArray);
         NSArray *array = [[NSArray alloc]init];
         for (int i = 0; i< jsonArray.count; i++)
         {
             NSString *userIdstr = [[jsonArray objectAtIndex:i]valueForKey:@"user_id"];
             NSLog(@"userIdstr %@",userIdstr);
             
             if ([userIdstr isEqualToString:userIdStr])
             {
                 
                 NSPredicate *resultPredicate = [NSPredicate
                                                 predicateWithFormat:@"SELF contains[c] %@",
                                                 userIdstr];
                 
                 array = [jsonArray filteredArrayUsingPredicate:resultPredicate];

                 
                 [videodetailAry addObjectsFromArray:array];
                 NSLog(@"videodetailAry %@",videodetailAry);
             }
             else
                 
             {
                 NSLog(@"not match");

             }
         }
         [_VideoListTableView reloadData];

    } failure:^(NSURLSessionTask *operation, NSError *error)
    {
        NSLog(@"Error: %@", error);
    }];
    
}

-(void)downloadVideo
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"Downloading Started");
        NSString *urlToDownload = videoUrlStr ;
        NSURL  *url = [NSURL URLWithString:urlToDownload];
        NSData *urlData = [NSData dataWithContentsOfURL:url];
        if ( urlData )
        {
            NSArray       *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString  *documentsDirectory = [paths objectAtIndex:0];
            
            NSString  *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,@"thefile.mp4"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [urlData writeToFile:filePath atomically:YES];
                NSLog(@"File Saved !");
                [self retriveVideoLocalDirectory];
            });
        }
    });
    
}

-(void)retriveVideoLocalDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *getImagePath = [documentsDirectory stringByAppendingPathComponent:@"thefile.mp4"];
 
    NSLog(@"getImagePath %@",getImagePath);
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:getImagePath delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

#pragma mark - Tableview delegate method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [videodetailAry count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"videoCell"];
    
      if (cell == nil)
      {
      cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"videoCell"];
    }
    cell.textLabel.text = [[videodetailAry objectAtIndex:indexPath.row]valueForKey:@"user_video"];
  
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
   videoUrlStr = [[videodetailAry objectAtIndex:indexPath.row]valueForKey:@"user_video"];
    NSLog(@"videoUrlStr %@",videoUrlStr);
    
    NSURL *vedioURL = [NSURL URLWithString:videoUrlStr];
    
    MPMoviePlayerViewController *videoPlayerView = [[MPMoviePlayerViewController alloc] initWithContentURL:vedioURL];
        UIWindow* keyWindow= [[UIApplication sharedApplication] keyWindow];
        [keyWindow addSubview: videoPlayerView.view];
    
        [self presentMoviePlayerViewControllerAnimated:videoPlayerView];
        [videoPlayerView.moviePlayer play];
       [self downloadVideo];

    

}

@end
