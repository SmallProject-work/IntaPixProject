//
//  AppDelegate.m
//  inta_pix
//
//  Created by test on 22/08/16.
//  Copyright © 2016 gauganTechnologies. All rights reserved.
//

#import "AppDelegate.h"
#import "galleryViewController.h"
#import "ProfileViewController.h"
#import "VideoViewController.h"
#import "FeedbackViewController.h"
#import "leftDrawerVC.h"
#import "ViewController.h"

#import "MusicViewController.h"
#import "FiltersViewController.h"
#import "DescriptionViewController.h"
#import "PaymentViewController.h"

//#import "PGDrawerTransition.h"
#import <QuartzCore/QuartzCore.h>
NSString *const kstrStripePublishableKey = @"sk_test_0i1VHc2i2nMxMIJRWD6aReIT";

@interface AppDelegate ()
{
   
    UINavigationController *navigation;
   
}

@property (nonatomic,strong) UINavigationController * navigationController;

@end

@implementation AppDelegate
@synthesize window = _window;

@synthesize centerController = _viewController;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [PayPalMobile initializeWithClientIdsForEnvironments:@{PayPalEnvironmentProduction : @"YOUR_CLIENT_ID_FOR_PRODUCTION",
                                                           PayPalEnvironmentSandbox : @"YOUR_CLIENT_ID_FOR_PRODUCTION"}];
    //AW5m0Gz_odqekNnnFRoUpGZdKZrx9fD8_vyU5yX8LM0k3GgtLuQi3exqL92gHj56PUtIzYKnmC0A11MH
    
    
    if (kstrStripePublishableKey != nil) {
        [Stripe setDefaultPublishableKey:kstrStripePublishableKey];
    }

    
    
    [navigation setNavigationBarHidden:YES];

    if([[NSUserDefaults standardUserDefaults]boolForKey:@"LogIn"])
    {
        
       // self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
       // UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        [self galleryRootVCMethod];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"chkLftController"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        /////////// if user already log in .
    }
       else
    {
        
        self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        // determine the initial view controller here and instantiate it with
        UIViewController *firstVC =  [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
        navigation=[[UINavigationController alloc]initWithRootViewController:firstVC];
        self.window.rootViewController = navigation;
        // self.window.rootViewController = firstVC;
        //[(UINavigationController*)self.window.rootViewController pushViewController:firstVC animated:YES];
        
        [self.window makeKeyAndVisible];
        
        
    }

   
    return YES;
}

-(void) galleryRootVCMethod{
    

//    
     self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
   
   //[self.navigationController setNavigationBarHidden:YES animated:YES];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController* centerController = [[galleryViewController alloc] init];
    centerController = [storyboard instantiateViewControllerWithIdentifier:@"galleryViewController"];
    
     centerController = [[UINavigationController alloc] initWithRootViewController:centerController];
    
    
       
    UIViewController* leftController = [[leftDrawerVC alloc] init];
    leftController = [storyboard instantiateViewControllerWithIdentifier:@"leftDrawerVC"];
     leftController = [[UINavigationController alloc] initWithRootViewController:leftController];
    // self.centerController = [[UINavigationController alloc] initWithRootViewController:centerController];
  
   
    IIViewDeckController* deckController =[[IIViewDeckController alloc] initWithCenterViewController:centerController
                                                                                  leftViewController:leftController
                                                                                 rightViewController:nil];
    
    

    
    deckController.leftSize = 100;
    
   
    [self.window setRootViewController:deckController];
    
    [self.window makeKeyAndVisible];
    
    
    
   };
-(void)profileRootVCMethod
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //[self.navigationController setNavigationBarHidden:YES animated:YES];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController* centerController = [[ProfileViewController alloc] init];
    centerController = [storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
    centerController = [[UINavigationController alloc] initWithRootViewController:centerController];
    
    
    
    UIViewController* leftController = [[leftDrawerVC alloc] init];
    leftController = [storyboard instantiateViewControllerWithIdentifier:@"leftDrawerVC"];
    leftController = [[UINavigationController alloc] initWithRootViewController:leftController];
    // self.centerController = [[UINavigationController alloc] initWithRootViewController:centerController];
    
    
    IIViewDeckController* deckController =[[IIViewDeckController alloc] initWithCenterViewController:centerController
                                                                                  leftViewController:leftController
                                                                                 rightViewController:nil];
    
    deckController.leftSize = 100;
    
    
    [self.window setRootViewController:deckController];
    
    [self.window makeKeyAndVisible];
    

}

-(void)videoRootVCMethod
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //[self.navigationController setNavigationBarHidden:YES animated:YES];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController* centerController = [[VideoViewController alloc] init];
    centerController = [storyboard instantiateViewControllerWithIdentifier:@"VideoViewController"];
    centerController = [[UINavigationController alloc] initWithRootViewController:centerController];
    
    
    
    UIViewController* leftController = [[leftDrawerVC alloc] init];
    leftController = [storyboard instantiateViewControllerWithIdentifier:@"leftDrawerVC"];
    leftController = [[UINavigationController alloc] initWithRootViewController:leftController];
    // self.centerController = [[UINavigationController alloc] initWithRootViewController:centerController];
    
    
    IIViewDeckController* deckController =[[IIViewDeckController alloc] initWithCenterViewController:centerController
                                                                                  leftViewController:leftController
                                                                                 rightViewController:nil];
    
    
    
    
    deckController.leftSize = 100;
    
    
    [self.window setRootViewController:deckController];
    
    [self.window makeKeyAndVisible];
    

}
-(void)feedbackRootVCMethod
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //[self.navigationController setNavigationBarHidden:YES animated:YES];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController* centerController = [[FeedbackViewController alloc] init];
    centerController = [storyboard instantiateViewControllerWithIdentifier:@"FeedbackViewController"];
    centerController = [[UINavigationController alloc] initWithRootViewController:centerController];
    
    
    
    UIViewController* leftController = [[leftDrawerVC alloc] init];
    leftController = [storyboard instantiateViewControllerWithIdentifier:@"leftDrawerVC"];
    leftController = [[UINavigationController alloc] initWithRootViewController:leftController];
    // self.centerController = [[UINavigationController alloc] initWithRootViewController:centerController];
    
    
    IIViewDeckController* deckController =[[IIViewDeckController alloc] initWithCenterViewController:centerController
                                                                                  leftViewController:leftController
                                                                                 rightViewController:nil];
    
    
    
    
    deckController.leftSize = 100;
    
    
    [self.window setRootViewController:deckController];
    
    [self.window makeKeyAndVisible];
    

}
-(void)logoutRootVCMethod
{
    {
        
        [MBProgressHUD showHUDAddedTo:self.window animated:YES];
        
        Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
        NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
        if (networkStatus == NotReachable)
        {
            [MBProgressHUD hideHUDForView:self.window animated:YES];
            NSLog(@"There IS NO internet connection");
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"There is no internet connection" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        else
        {
            NSLog(@"There IS internet connection");
            
            
            NSString *fullAuthUrlString = [[NSString alloc]
                                           initWithFormat:@"http://gaugantech.com/intapix/app_logout.php"];
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
                  dispatch_sync(dispatch_get_main_queue(), ^{
                      
                      if (error == nil)
                      {
                          if (responseStatusCode == 200)
                          {
                              
                              NSLog(@"response: %@", response);
                              NSLog(@"data: %@", data);
                              
                              NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                              NSLog(@"requestReply: %@", requestReply);
                              
                              //                      dispatch_sync(dispatch_get_main_queue(), ^{
                              NSLog(@"requestReply %@",requestReply);
                              /* Do UI work here */
                              [MBProgressHUD hideHUDForView:self.window animated:YES];
                              //[appDelegate logoutMethod];
                              
                              [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"LogIn"];
                                                           
                              [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"chkNxtController"];
                                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"chkNxtMusicController"];
                                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"chkNxtFiltersController"];
                                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"chkNxtDescriptionController"];
                                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"chkNxtPaymentController"];
                                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"chkNxtThankYouViewController"];
                               [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"firstName"];
                               [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"lastName"];
                              [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"User_id"];
                              [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"User_Name"];

                              
                              
                              self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
                              UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                              // determine the initial view controller here and instantiate it with
                              UIViewController *firstVC =  [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
                              
                            navigation=[[UINavigationController alloc]initWithRootViewController:firstVC];
                              self.window.rootViewController = navigation;
                              
                              [self.window makeKeyAndVisible];
                              
                              
                              
                          }
                          
                          
                      }
                      else
                      {
                          [MBProgressHUD hideHUDForView:self.window animated:YES];
                          
                          
                          NSLog(@"error1: %@", error.localizedDescription);
                      }
                  });
              }
              
              ] resume];
            
        }
        
        
        
        
    }
    
}


-(void) musicRootVCMethod
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //[self.navigationController setNavigationBarHidden:YES animated:YES];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController* centerController = [[MusicViewController alloc] init];
    centerController = [storyboard instantiateViewControllerWithIdentifier:@"MusicViewController"];
    centerController = [[UINavigationController alloc] initWithRootViewController:centerController];
    
    
    
    UIViewController* leftController = [[leftDrawerVC alloc] init];
    leftController = [storyboard instantiateViewControllerWithIdentifier:@"leftDrawerVC"];
    leftController = [[UINavigationController alloc] initWithRootViewController:leftController];
    // self.centerController = [[UINavigationController alloc] initWithRootViewController:centerController];
    
    
    IIViewDeckController* deckController =[[IIViewDeckController alloc] initWithCenterViewController:centerController
                                                                                  leftViewController:leftController
                                                                                 rightViewController:nil];
    
    
    
    
    deckController.leftSize = 100;
    
    
    [self.window setRootViewController:deckController];
    
    [self.window makeKeyAndVisible];

}

-(void) filterRootVCMethod
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //[self.navigationController setNavigationBarHidden:YES animated:YES];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController* centerController = [[FiltersViewController alloc] init];
    centerController = [storyboard instantiateViewControllerWithIdentifier:@"FiltersViewController"];
    centerController = [[UINavigationController alloc] initWithRootViewController:centerController];
    
    
    
    UIViewController* leftController = [[leftDrawerVC alloc] init];
    leftController = [storyboard instantiateViewControllerWithIdentifier:@"leftDrawerVC"];
    leftController = [[UINavigationController alloc] initWithRootViewController:leftController];
    // self.centerController = [[UINavigationController alloc] initWithRootViewController:centerController];
    
    
    IIViewDeckController* deckController =[[IIViewDeckController alloc] initWithCenterViewController:centerController
                                                                                  leftViewController:leftController
                                                                                 rightViewController:nil];
    
    
    
    
    deckController.leftSize = 100;
    
    
    [self.window setRootViewController:deckController];
    
    [self.window makeKeyAndVisible];

}

-(void) descriptionRootVCMethod
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //[self.navigationController setNavigationBarHidden:YES animated:YES];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController* centerController = [[DescriptionViewController alloc] init];
    centerController = [storyboard instantiateViewControllerWithIdentifier:@"DescriptionViewController"];
    centerController = [[UINavigationController alloc] initWithRootViewController:centerController];
    
    
    
    UIViewController* leftController = [[leftDrawerVC alloc] init];
    leftController = [storyboard instantiateViewControllerWithIdentifier:@"leftDrawerVC"];
    leftController = [[UINavigationController alloc] initWithRootViewController:leftController];
    // self.centerController = [[UINavigationController alloc] initWithRootViewController:centerController];
    
    
    IIViewDeckController* deckController =[[IIViewDeckController alloc] initWithCenterViewController:centerController
                                                                                  leftViewController:leftController
                                                                                 rightViewController:nil];
    
    
    
    
    deckController.leftSize = 100;
    
    
    [self.window setRootViewController:deckController];
    
    [self.window makeKeyAndVisible];
 
}
-(void) paymentRootVCMethod
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //[self.navigationController setNavigationBarHidden:YES animated:YES];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController* centerController = [[PaymentViewController alloc] init];
    centerController = [storyboard instantiateViewControllerWithIdentifier:@"PaymentViewController"];
    centerController = [[UINavigationController alloc] initWithRootViewController:centerController];
    
    
    
    UIViewController* leftController = [[leftDrawerVC alloc] init];
    leftController = [storyboard instantiateViewControllerWithIdentifier:@"leftDrawerVC"];
    leftController = [[UINavigationController alloc] initWithRootViewController:leftController];
    // self.centerController = [[UINavigationController alloc] initWithRootViewController:centerController];
    
    
    IIViewDeckController* deckController =[[IIViewDeckController alloc] initWithCenterViewController:centerController
                                                                                  leftViewController:leftController
                                                                                 rightViewController:nil];
    
    
    
    
    deckController.leftSize = 100;
    
    
    [self.window setRootViewController:deckController];
    
    [self.window makeKeyAndVisible];

}
-(void)nextController
{
    
                   
                      UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                 MusicViewController *music = [storyboard instantiateViewControllerWithIdentifier:@"MusicViewController"];
                    navigation=[[UINavigationController alloc]initWithRootViewController:music];
                    self.window.rootViewController = navigation;
                    [self.window makeKeyAndVisible];
                    
    
    

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
