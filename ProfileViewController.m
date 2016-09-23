//
//  ProfileViewController.m
//  inta_pix
//
//  Created by test on 26/08/16.
//  Copyright © 2016 gauganTechnologies. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()
{
    AppDelegate *appdelegateProf;
}

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _firstNameTxtFld.clipsToBounds = true;
    _firstNameTxtFld.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _firstNameTxtFld.layer.borderWidth = 2;
    _firstNameTxtFld.layer.cornerRadius = 10;
    NSAttributedString *firstNameStr = [[NSAttributedString alloc] initWithString:@"  First Name" attributes:@{ NSForegroundColorAttributeName : [UIColor lightGrayColor] }];
    _firstNameTxtFld.attributedPlaceholder = firstNameStr;

    
    _lastnameTxtFld.clipsToBounds = true;
    _lastnameTxtFld.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _lastnameTxtFld.layer.borderWidth = 2;
    _lastnameTxtFld.layer.cornerRadius = 10;
    NSAttributedString *LastNameStr = [[NSAttributedString alloc] initWithString:@"  Last Name" attributes:@{ NSForegroundColorAttributeName : [UIColor lightGrayColor] }];
    _lastnameTxtFld.attributedPlaceholder = LastNameStr;

    
    _currentPawrdTxtFld.clipsToBounds = true;
    _currentPawrdTxtFld.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _currentPawrdTxtFld.layer.borderWidth = 2;
    _currentPawrdTxtFld.layer.cornerRadius = 10;
    NSAttributedString *currentPassStr = [[NSAttributedString alloc] initWithString:@"  Current Password" attributes:@{ NSForegroundColorAttributeName : [UIColor lightGrayColor] }];
    _currentPawrdTxtFld.attributedPlaceholder = currentPassStr;

    
    _setPasswrdTxtFld.clipsToBounds = true;
    _setPasswrdTxtFld.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _setPasswrdTxtFld.layer.borderWidth = 2;
    _setPasswrdTxtFld.layer.cornerRadius = 10;
    NSAttributedString *newPassStr = [[NSAttributedString alloc] initWithString:@"  New Password" attributes:@{ NSForegroundColorAttributeName : [UIColor lightGrayColor] }];
    _setPasswrdTxtFld.attributedPlaceholder = newPassStr;

    
    _confirmPasswrdTxtFld.clipsToBounds = true;
    _confirmPasswrdTxtFld.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    _confirmPasswrdTxtFld.layer.borderWidth = 2;
    _confirmPasswrdTxtFld.layer.cornerRadius = 10;
    NSAttributedString *confirmPassStr = [[NSAttributedString alloc] initWithString:@"  Confirm Password" attributes:@{ NSForegroundColorAttributeName : [UIColor lightGrayColor] }];
    _confirmPasswrdTxtFld.attributedPlaceholder = confirmPassStr;

    
    _saveChangesBtnOutlet.clipsToBounds = true;
    _saveChangesBtnOutlet.layer.cornerRadius = 10;
    
    _saveBtnOutlet.clipsToBounds = true;
    _saveBtnOutlet.layer.cornerRadius = 10;
 
    
    
    
    
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
    [self addViewTapGesture];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    appdelegateProf = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self.navigationController setNavigationBarHidden:YES];
    // Dispose of any resources that can be recreated.
}



- (IBAction)drawerBtnAction:(id)sender
{
    [appdelegateProf profileRootVCMethod];
   
    [self.viewDeckController toggleLeftView];
    

}
- (IBAction)saveChangBtnAction:(id)sender
{
    if (_currentPawrdTxtFld.text.length == 0 && _setPasswrdTxtFld.text.length == 0 && _confirmPasswrdTxtFld.text.length == 0)
    {
       
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Set Password." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if (_currentPawrdTxtFld.text.length == 0)
    {
       
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Current Password." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
       else if (_setPasswrdTxtFld.text.length ==0)
    {
        NSLog(@"enter Password");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"New Password." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
       else if (_confirmPasswrdTxtFld.text.length ==0)
       {
           NSLog(@"enter Password");
           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Confirm Password." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
           [alert show];
           
       }

    else
    {
        [self postMethodChangePassword];
              
        
    }

}

-(void)postMethodChangePassword
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
        
        
        
        NSString* escapedCurrentPassword = [_currentPawrdTxtFld.text stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        
        NSString* escapedNewPassword = [_setPasswrdTxtFld.text stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        
        NSString* escapedconfirmPassword = [_confirmPasswrdTxtFld.text stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        
        
        
        NSString *fullAuthUrlString;
        
        
        //corporate
        NSLog(@"coorporate");
        fullAuthUrlString = [[NSString alloc]
                             initWithFormat:@"http://gaugantech.com/intapix/do_log.php?email=%@&password=%@&submit=Log+in"];
        
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
- (IBAction)saveBtnAction:(id)sender
{
    
    if (_firstNameTxtFld.text.length == 0 && _lastnameTxtFld.text.length == 0)
    {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"All fields are Mandatory." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if (_firstNameTxtFld.text.length == 0)
    {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"First Name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if (_lastnameTxtFld.text.length ==0)
    {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Last Name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
    else
    {
        [self postMethodChangeName];
        
        
    }

}
-(void)postMethodChangeName
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
        
        
        
        NSString* escapedFirstName = [_firstNameTxtFld.text stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        
        
        
        NSString* escapedLastName = [_lastnameTxtFld.text stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        
        
        
        NSString *fullAuthUrlString;
        
        
        //corporate
        NSLog(@"coorporate");
        fullAuthUrlString = [[NSString alloc]
                             initWithFormat:@"http://gaugantech.com/intapix/do_log.php?email=%@&password=%@&submit=Log+in"];
        
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

#pragma mark - handle soft keyboard

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if([textField isEqual:_firstNameTxtFld])
    {
        if  (self.view.frame.origin.y >= 0)
        {
            [self keyboardDidShow:nil];
        }
        
    }
    
    else if([textField isEqual:_lastnameTxtFld])
    {
        if  (self.view.frame.origin.y >= 0)
        {
            [self keyboardDidShow:nil];
        }
        
    }
    else if([textField isEqual:_currentPawrdTxtFld])
    {
        if  (self.view.frame.origin.y >= 0)
        {
            [self keyboardDidShow:nil];
        }
        
    }
    else if([textField isEqual:_setPasswrdTxtFld])
    {
        if  (self.view.frame.origin.y >= 0)
        {
            [self keyboardDidShow:nil];
        }
        
    }
    else if([textField isEqual:_confirmPasswrdTxtFld])
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
