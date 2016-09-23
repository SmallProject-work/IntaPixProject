//
//  FiltersViewController.m
//  inta_pix
//
//  Created by test on 24/08/16.
//  Copyright © 2016 gauganTechnologies. All rights reserved.
//

#import "FiltersViewController.h"

@interface FiltersViewController ()
{
    NSArray *filtersArry;
    NSArray *filterImagesArray;
    NSString *selectedSongStr ;
     AppDelegate *appdelegateFilter;
    NSString *userIdStr;
    NSString *userNameStr;
}

@end

@implementation FiltersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //chkContFilter
    
    
    
    
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"chkContFilter"])
    {
        [self.viewDeckController closeOpenView];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"chkContFilter"];
        
    }
    else
    {
        [appdelegateFilter filterRootVCMethod];
        [self drawerBtnAction:nil];
    }
    self.navigationItem.title = @"Filters Select Or Skip";
    
    
    
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

-(void)viewWillAppear:(BOOL)animated
{
    NSString *stored_userID = [[NSUserDefaults standardUserDefaults] valueForKey:@"User_id"];
    userIdStr = [NSString stringWithFormat:@"%@",stored_userID];
    NSLog(@"userIdStr %@",userIdStr);
    
    NSString *stored_userName = [[NSUserDefaults standardUserDefaults] valueForKey:@"User_Name"];
    userNameStr = [NSString stringWithFormat:@"%@",stored_userName];
    NSLog(@"userIdStr %@",userNameStr);

    
    appdelegateFilter = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    filterListTableVw.clipsToBounds = true;
    filterListTableVw.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    filterListTableVw.layer.borderWidth = 2;
    filterListTableVw.layer.cornerRadius = 10;
    
    
    filtersArry = [[NSArray alloc]init];
    filtersArry = @[@"Normal",@"Fasebook",@"Cool Pro",@"Action",@"After effects color",@"Bright Sun",@"Cinema",@"Pink story",@"Country",@"Cool weather",@"Dream pastel",@"Monochrome",@"Top Gear Cool",@"Vivid",@"Warmish Basic",@"Old western",@"Sin Sity",@"Mexicalli",@"Sport (Football Game)",@"Bad boyz"];
    
    filterImagesArray = [[NSArray alloc]init];
    filterImagesArray = @[@"1 DEFAULT.jpg",@"FaceBook.jpg",@"Cool Pro.jpg",@"Action.jpg",@"After FX Color.jpg",@"Bright Sun.jpg",@"Cinema.jpg",@"Pink Story.jpg",@"Country.jpg",@"Cool Weather.jpg",@"Dream.jpg",@"Monochrome.jpg",@"Top Gear.jpg",@"Vivid.jpg",@"Warm.jpg",@"Western.jpg",@"Sin City.jpg",@"Mexicali.jpg",@"Sport.jpg",@"Bad Boy.jpg"];
    NSLog(@"filtersArry %lu",(unsigned long)filtersArry.count);
       NSLog(@"filterImagesArray %lu",(unsigned long)filterImagesArray.count);
    
    filterView.hidden = true;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button_Action
- (IBAction)drawerBtnAction:(id)sender
{
    [appdelegateFilter filterRootVCMethod];
    
    [self.viewDeckController toggleLeftView];
}

- (IBAction)next_btn_action:(id)sender
{
    
    [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"chkContDescription"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    DescriptionViewController *descriptionVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DescriptionViewController"];
    
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"chkNxtFiltersController"])
    {
        [self.navigationController pushViewController:descriptionVC animated:YES];

   
         [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"chkNxtFiltersController"];
    }
    else
    {
         self.viewDeckController.centerController = descriptionVC;
        [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"chkNxtFiltersController"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"chkNxtDescriptionController"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    
    
   
}

- (IBAction)selectBtn_action:(id)sender
{
    NSLog(@"selectedSongStr at select button %@",selectedSongStr);
    [self postMethod];
    
}

- (IBAction)removeBtn_action:(id)sender
{
    filterView.hidden = true;
}

#pragma mark - Tableview delegate method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [filtersArry count];
    
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    filterTableViewCell *cell = (filterTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"filterTableViewCell"];
    // NSIndexPath *selectedIndexPath = [tableView indexPathForSelectedRow];
    if (cell == nil) {
        //        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TalentSearchTableViewCell"];
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"filterTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
       cell.filterName_lbl.text = [filtersArry objectAtIndex:indexPath.row];
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor colorWithRed:195/255.0 green:140/255.0 blue:26/255.0 alpha:0.2];
    [cell setSelectedBackgroundView:bgColorView];
    
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
     filterView.hidden = false;
    selectedSongStr = [filtersArry objectAtIndex:indexPath.row];
    NSLog(@"selectedSongStr %@",selectedSongStr);
    
    selected_filter_imgVw.image = [UIImage imageNamed:[filterImagesArray objectAtIndex:indexPath.row]];
  
}

#pragma mark - Post method
-(void)postMethod
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
        
        NSString* escapedUserName = [userNameStr stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        NSString* escapedUserID = [userIdStr stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        
        NSString* escapedfilterStr = [selectedSongStr stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        
        
        
        NSString *fullAuthUrlString;
        
        
        //corporate
        NSLog(@"coorporate");
        fullAuthUrlString = [[NSString alloc]
                             initWithFormat:@"http://gaugantech.com/intapix/do_filter.php?user_id=%@&user_name=%@&filter=%@&submit=Select",escapedUserID,escapedUserName,escapedfilterStr];
        
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
                      
                      dispatch_sync(dispatch_get_main_queue(), ^{

                      NSLog(@"response: %@", response);
                      NSLog(@"data: %@", data);
                      
                      NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                      NSLog(@"requestReply: %@", requestReply);
                      
                      NSMutableArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: nil];
                      NSLog(@"jsonArray: %@", jsonArray);
                      
                      
                                              [MBProgressHUD hideHUDForView:self.view animated:YES];
                          
                              UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:requestReply delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                              [alert show];
                
                          
                          
                      });
                      
                      
                      
                      
                  }
                  else if (responseStatusCode == 404){
                      dispatch_sync(dispatch_get_main_queue(), ^{
                          [MBProgressHUD hideHUDForView:self.view animated:YES];
                          NSLog(@"error: %@", error.localizedDescription);
                          
                          UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"File not Found"delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
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


@end
