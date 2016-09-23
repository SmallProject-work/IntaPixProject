//
//  LoginViewController.m
//  inta_pix
//
//  Created by test on 22/08/16.
//  Copyright © 2016 gauganTechnologies. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (BOOL) validateEmail1: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    //	return 0;
    return [emailTest evaluateWithObject:candidate];
}
bool isShowForgotView = false;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    
    // Do any additional setup after loading the view.
    email_txtFld.clipsToBounds = true;
    email_txtFld.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    email_txtFld.layer.borderWidth = 2;
    email_txtFld.layer.cornerRadius = 10;
    NSAttributedString *emailStr = [[NSAttributedString alloc] initWithString:@"  Your Email ID" attributes:@{ NSForegroundColorAttributeName : [UIColor lightGrayColor] }];
    email_txtFld.attributedPlaceholder = emailStr;

    password_txtFld.clipsToBounds = true;
    password_txtFld.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    password_txtFld.layer.borderWidth = 2;
    password_txtFld.layer.cornerRadius = 10;
    NSAttributedString *passwordStr = [[NSAttributedString alloc] initWithString:@"  Password" attributes:@{ NSForegroundColorAttributeName : [UIColor lightGrayColor] }];
    password_txtFld.attributedPlaceholder = passwordStr;

    loginBtn_outlet.clipsToBounds = true;
    loginBtn_outlet.layer.cornerRadius = 10;
    
    back_btn_outlet.clipsToBounds = true;
    back_btn_outlet.layer.cornerRadius = 10;
    
    
    
    
    forgotEmailTxtFld.clipsToBounds = true;
    forgotEmailTxtFld.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    forgotEmailTxtFld.layer.borderWidth = 2;
    forgotEmailTxtFld.layer.cornerRadius = 10;
    NSAttributedString *forgotStr = [[NSAttributedString alloc] initWithString:@"  Your Email ID" attributes:@{ NSForegroundColorAttributeName : [UIColor lightGrayColor] }];
    forgotEmailTxtFld.attributedPlaceholder = forgotStr;
    
    sendBtnOutlet.clipsToBounds = true;
    sendBtnOutlet.layer.cornerRadius = 10;
    
    forgotView.clipsToBounds = true;
    forgotView.layer.cornerRadius = 10;
    forgotView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    forgotView.layer.borderWidth = 2;
   

    forgotView.hidden = true;
    [self addViewTapGesture];


}
-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Button_Action
- (IBAction)loginBtn_Action:(id)sender
{
    
    
    
    
    if (email_txtFld.text.length == 0 && password_txtFld.text.length == 0)
    {
        NSLog(@"All fields are mandatory");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"All fields are mandatory." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if (email_txtFld.text.length == 0)
    {
        NSLog(@"enter email address");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Enter email address." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if(![self validateEmail1:[email_txtFld text]] ==1)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter Valid email ID." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
        
        
    }
    
    else if (password_txtFld.text.length ==0)
    {
        NSLog(@"enter Password");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Enter Password." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
    else
    {
        [self postMethod];
        NSLog(@"login");
        
        
    }
    
    //galleryViewController *galleryVC = [self.storyboard instantiateViewControllerWithIdentifier:@"galleryViewController"];
    //[self.navigationController pushViewController:galleryVC animated:YES];
    
}

- (IBAction)back_btn_Action:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)sendBtnAction:(id)sender
{
    if (forgotEmailTxtFld.text.length == 0)
    {
        NSLog(@"enter email address");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Enter email address." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        [self postForgotMethod];
        
    }
}

- (IBAction)forgotBtnAction:(id)sender
{
   
    if (!isShowForgotView) {
        //animate_view.hidden = false;
        [UIView animateWithDuration:0.25 animations:^{
            forgotView.hidden = false;
        }];
        isShowForgotView = true;
    } else {
        [UIView animateWithDuration:0.25 animations:^{
            forgotView.hidden = true;
        }];
        isShowForgotView = false;
    }
    

}

- (IBAction)removeForgotViwBtnAction:(id)sender
{
    forgotView.hidden = true;
    isShowForgotView = false;
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
        
        
        
        NSString* escapedUserName = [email_txtFld.text stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        
        
        
        NSString* escapedUserPaaword = [password_txtFld.text stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        
        
        
        NSString *fullAuthUrlString;
        
        
        //corporate
        NSLog(@"coorporate");
        fullAuthUrlString = [[NSString alloc]
                             initWithFormat:@"http://gaugantech.com/intapix/do_log.php?email=%@&password=%@&submit=Log+in",escapedUserName,escapedUserPaaword];
        
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
                          
                          if ([requestReply isEqualToString:@"Invalid login please try again"])
                          {
                              UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:requestReply delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                              [alert show];
                          }
                          
                          else
                          {
                              NSString *userID = [jsonArray valueForKey:@"id"];
                              NSLog(@"id %@",userID);
                              
                              NSString *firstName = [jsonArray valueForKey:@"firstname"];
                              NSLog(@"firstname %@",firstName);
                              
                              NSString *lastName = [jsonArray valueForKey:@"lastname"];
                              NSLog(@"lastname %@",lastName);
                              
                              NSString *userName = [NSString stringWithFormat:@"%@%@",firstName,lastName];
                              
                               NSLog(@"userName %@",userName);
                              
                              [[NSUserDefaults standardUserDefaults] setValue:userID forKey:@"User_id"];
                              [[NSUserDefaults standardUserDefaults] synchronize];
                              
                              
                              [[NSUserDefaults standardUserDefaults] setValue:firstName forKey:@"firstName"];
                              [[NSUserDefaults standardUserDefaults] synchronize];
                              
                              [[NSUserDefaults standardUserDefaults] setValue:lastName forKey:@"lastName"];
                              [[NSUserDefaults standardUserDefaults] synchronize];
                              
                              [[NSUserDefaults standardUserDefaults] setValue:userName forKey:@"User_Name"];
                              [[NSUserDefaults standardUserDefaults] synchronize];



                              
                              
                              
                              [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"LogIn"];
                              [[NSUserDefaults standardUserDefaults] synchronize];

                              
                              UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Login Successfully" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                              [alert show];
                              
                              galleryViewController *galleryVC = [self.storyboard instantiateViewControllerWithIdentifier:@"galleryViewController"];
                              [self.navigationController pushViewController:galleryVC animated:YES];
                              
                              
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
-(void)postForgotMethod
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
        
        
        
        NSString* escapedForgotEmail = [forgotEmailTxtFld.text stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
      
     
        
        
            NSString *fullAuthUrlString = [[NSString alloc]
                             initWithFormat:@"http://gaugantech.com/intapix/api/do_forgot_password.php?email=%@&submit=Resend+Password",escapedForgotEmail];
        
        
        
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
                          
                          if ([requestReply isEqualToString:@"Invalid login please try again"])
                          {
                              UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:requestReply delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                              [alert show];
                          }
                          
                          else
                          {
                              
                              UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:requestReply delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                              [alert show];
                              
                              forgotView.hidden = true;
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


#pragma mark - handle soft keyboard

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if([textField isEqual:email_txtFld])
    {
        if  (self.view.frame.origin.y >= 0)
        {
            [self keyboardDidShow:nil];
        }
        
    }
    
    else if([textField isEqual:password_txtFld])
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
