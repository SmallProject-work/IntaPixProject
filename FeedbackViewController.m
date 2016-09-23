//
//  FeedbackViewController.m
//  inta_pix
//
//  Created by test on 26/08/16.
//  Copyright © 2016 gauganTechnologies. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()
{
    AppDelegate *appdelegateFeedback;
    NSString *userIdStr;
    NSString *firstNameStr;
    NSString *lastnameStr;
    
    
}

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawerBtnAction:nil];
    
    //self.navigationItem.title = @"Upload Photos";
    
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"left" style:UIBarButtonItemStyleBordered target:self.viewDeckController action:@selector(toggleLeftView)];
    
    
    if ([self.navigationItem respondsToSelector:@selector(leftBarButtonItems)]) {
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:
                                                  [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"drawerBtn"] style:UIBarButtonItemStyleBordered target:self.viewDeckController action:@selector(toggleLeftView)],nil];
        
        
        
        
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        [self.navigationController.navigationBar
         setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
        
        [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:235.0/255 green:87.0/255 blue:13.0/255 alpha:1]];
        
    }
    
    _feedbackTxtView.text = @"Please give your feedback?";
    _feedbackTxtView.textColor = [UIColor lightGrayColor];
    _feedbackTxtView.delegate = self;
    [_feedbackTxtView setScrollEnabled:YES];
    
    _feedbackTxtView.clipsToBounds = true;
    _feedbackTxtView.layer.cornerRadius = 10;

    
    _feedbackBtnOutlet.clipsToBounds = true;
    _feedbackBtnOutlet.layer.cornerRadius = 10;
    
    [self addViewTapGesture];

    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    appdelegateFeedback = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSString *stored_userID = [[NSUserDefaults standardUserDefaults] valueForKey:@"User_id"];
    userIdStr = [NSString stringWithFormat:@"%@",stored_userID];
    NSLog(@"userIdSTring %@",userIdStr);
    
    NSString *stored_firstName = [[NSUserDefaults standardUserDefaults] valueForKey:@"firstName"];
    firstNameStr = [NSString stringWithFormat:@"%@",stored_firstName];
    NSLog(@"userIdSTring %@",firstNameStr);

    NSString *stored_Lastname = [[NSUserDefaults standardUserDefaults] valueForKey:@"lastName"];
    lastnameStr = [NSString stringWithFormat:@"%@",stored_Lastname];
    NSLog(@"userIdSTring %@",lastnameStr);

 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)feedbackBtnAction:(id)sender
{
    if (_feedbackTxtView.text.length == 0 && [_feedbackTxtView.text isEqualToString:@"Please give your feedback?"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please give us feedback." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        [self postFeedbackMethod];
    }
    
}

- (IBAction)drawerBtnAction:(id)sender
{
    [appdelegateFeedback feedbackRootVCMethod];
    
    [self.viewDeckController toggleLeftView];
}
-(void)postFeedbackMethod
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
        
        
        
        NSString* escapedFeedback = [_feedbackTxtView.text stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        
        NSString* escapeduserId = [userIdStr stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        

        NSString* escapedfirstName = [firstNameStr stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        

        NSString* escapedlastname = [lastnameStr stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        

        
        
        
        NSString *fullAuthUrlString;
        
        
        //corporate
        NSLog(@"coorporate");
        fullAuthUrlString = [[NSString alloc]
                             initWithFormat:@"http://gaugantech.com/intapix/api/do_feedback.php?user_id=%@&firstname=%@&lastname=%@&feedback=%@&submit=Send",escapeduserId,escapedfirstName,escapedlastname,escapedFeedback];
        
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

#pragma mark - TextView delegate method
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    
    if([textView isEqual:_feedbackTxtView])
    {
        if  (self.view.frame.origin.y >= 0)
        {
            [self keyboardDidShow:nil];
        }
        
    }

    _feedbackTxtView.text = @"";
    _feedbackTxtView.textColor = [UIColor lightGrayColor];
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    
    if(_feedbackTxtView.text.length == 0){
        _feedbackTxtView.textColor = [UIColor lightGrayColor];
        _feedbackTxtView.text = @"Any other requirements?";
        [_feedbackTxtView resignFirstResponder];
    }
}


#pragma mark - handle soft keyboard


//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [[self view] endEditing:YES];
//    return YES;
//}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView;
{
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
    [self.view setFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
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
