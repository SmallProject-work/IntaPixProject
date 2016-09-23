//
//  DescriptionViewController.m
//  inta_pix
//
//  Created by test on 24/08/16.
//  Copyright © 2016 gauganTechnologies. All rights reserved.
//

#import "DescriptionViewController.h"

@interface DescriptionViewController ()
{
     AppDelegate *appdelegateDescription;
    NSString *userIdSTring;
}

@end

@implementation DescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    submit_btn_outlet.clipsToBounds = true;
    submit_btn_outlet.layer.cornerRadius = 10;
    
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"chkContDescription"])
    {
        [self.viewDeckController closeOpenView];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"chkContDescription"];
        
    }
    else
    {
        [appdelegateDescription descriptionRootVCMethod];
        [self drawer_btn_action:nil];
    }

    
    self.navigationItem.title = @"Description";
    
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"left" style:UIBarButtonItemStyleBordered target:self.viewDeckController action:@selector(toggleLeftView)];
    
    
    if ([self.navigationItem respondsToSelector:@selector(leftBarButtonItems)]) {
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:
                                                  [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"drawerBtn"] style:UIBarButtonItemStyleBordered target:self.viewDeckController action:@selector(toggleLeftView)],nil];
        
        
        
        
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        [self.navigationController.navigationBar
         setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
        
        [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:235.0/255 green:87.0/255 blue:13.0/255 alpha:1]];
        
    }
    
    
    description_txtVw.text = @"Any Description?";
    description_txtVw.textColor = [UIColor lightGrayColor];
    description_txtVw.delegate = self;
    [description_txtVw setScrollEnabled:YES];
    
    [self addViewTapGesture];

}
-(void)viewWillAppear:(BOOL)animated
{
    NSString *stored_userID = [[NSUserDefaults standardUserDefaults] valueForKey:@"User_id"];
    userIdSTring = [NSString stringWithFormat:@"%@",stored_userID];
    NSLog(@"userIdSTring %@",userIdSTring);

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
- (IBAction)drawer_btn_action:(id)sender
{
    [appdelegateDescription descriptionRootVCMethod];
    
    [self.viewDeckController toggleLeftView];
}

- (IBAction)submit_btn_action:(id)sender
{
    if ((description_txtVw.text.length == 0) || [description_txtVw.text isEqualToString:@"Any Description?"])
    {
        NSLog(@"time");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please fill the description." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
    else
    {
        [self postMethod];
    }

    
    
}

- (IBAction)next_btn_action:(id)sender
{
    
    [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"chkContPayment"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    PaymentViewController *paymentVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PaymentViewController"];
    
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"chkNxtDescriptionController"])
    {
    [self.navigationController pushViewController:paymentVC animated:YES];
     [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"chkNxtDescriptionController"];
    }
    else
    {
        self.viewDeckController.centerController = paymentVC;
        [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"chkNxtDescriptionController"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"chkNxtPaymentController"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    
    
   
}
#pragma mark - TextView delegate method
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    description_txtVw.text = @"";
    description_txtVw.textColor = [UIColor lightGrayColor];
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    
    if(description_txtVw.text.length == 0){
        description_txtVw.textColor = [UIColor lightGrayColor];
        description_txtVw.text = @"Any other requirements?";
        [description_txtVw resignFirstResponder];
    }
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
        
        NSString* escapedDescription = [description_txtVw.text stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        NSString* escapedUserID = [userIdSTring stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        
       
        
        NSLog(@"coorporate");
        NSString *fullAuthUrlString = [[NSString alloc]
                             initWithFormat:@"http://gaugantech.com/intapix/do_description.php?id=%@&description=%@+&submit=send",escapedUserID,escapedDescription];
        
       
        
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
                          
                          if ([requestReply isEqualToString:@"Email already exist"])
                          {
                              UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:requestReply delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                              [alert show];
                          }
                          else
                          {
                              
                              
                              UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:requestReply delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                              [alert show];
                              
                          }
                          
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
