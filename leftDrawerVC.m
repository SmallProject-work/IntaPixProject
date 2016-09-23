//
//  leftDrawerVC.m
//  inta_pix
//
//  Created by test on 24/08/16.
//  Copyright © 2016 gauganTechnologies. All rights reserved.
//

#import "leftDrawerVC.h"

@interface leftDrawerVC ()
{
    NSArray *controllerNameAry;
    AppDelegate *appdelegateleftDrawer;
}

@end

@implementation leftDrawerVC

- (void)viewDidLoad {
    [super viewDidLoad];
     [self.navigationController setNavigationBarHidden:YES];
    
   // controllerNameAry = [[NSArray alloc]init];
    //controllerNameAry = @[@"Gallery",@"Profile",@"Videos",@"FeedBack"];
    }

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    appdelegateleftDrawer = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button_Action
- (IBAction)galleryBtnAction:(id)sender

{
    if(![self.navigationController.topViewController isKindOfClass:[ProfileViewController class]])
    {
        galleryViewController *galleryVC = [self.storyboard instantiateViewControllerWithIdentifier:@"galleryViewController"];
        //[self.navigationController pushViewController:galleryVC animated:YES];
        
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:galleryVC];
        
        navController.navigationBarHidden = YES;
        
        IIViewDeckController *deckView = [[IIViewDeckController alloc] initWithCenterViewController:navController leftViewController:galleryVC rightViewController:nil];
        
        // [self.navigationController pushViewController:deckView animated:YES];
        // UIViewController* newController = [[UIViewController alloc] init];
        self.viewDeckController.centerController = deckView;
        
    }
    else
    {
        NSLog(@"same controller ");
        // [navController setViewControllers: @[deckController] animated: YES];
        // self.navigationController.navigationBarHidden = YES;
    }
    
    [self.viewDeckController closeOpenView];
    
}

- (IBAction)profile_btn_action:(id)sender
{
    if(![self.navigationController.topViewController isKindOfClass:[ProfileViewController class]])
    {
        ProfileViewController *profileVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
        //[self.navigationController pushViewController:galleryVC animated:YES];
        
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:profileVC];
        
        navController.navigationBarHidden = YES;
        
        IIViewDeckController *deckView = [[IIViewDeckController alloc] initWithCenterViewController:navController leftViewController:profileVC rightViewController:nil];
        
        // [self.navigationController pushViewController:deckView animated:YES];
        // UIViewController* newController = [[UIViewController alloc] init];
        self.viewDeckController.centerController = deckView;
        
    }
    else
    {
        NSLog(@"same controller ");
        // [navController setViewControllers: @[deckController] animated: YES];
        self.navigationController.navigationBarHidden = YES;
    }
    
    [self.viewDeckController closeOpenView];
   
   
}

- (IBAction)video_btn_action:(id)sender
{
    if(![self.navigationController.topViewController isKindOfClass:[ProfileViewController class]])
    {
        VideoViewController *videoVC = [self.storyboard instantiateViewControllerWithIdentifier:@"VideoViewController"];
        //[self.navigationController pushViewController:galleryVC animated:YES];
        
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:videoVC];
        
        navController.navigationBarHidden = YES;
        
        IIViewDeckController *deckView = [[IIViewDeckController alloc] initWithCenterViewController:navController leftViewController:videoVC rightViewController:nil];
        
        // [self.navigationController pushViewController:deckView animated:YES];
        // UIViewController* newController = [[UIViewController alloc] init];
        self.viewDeckController.centerController = deckView;
        
    }
    else
    {
        NSLog(@"same controller ");
        // [navController setViewControllers: @[deckController] animated: YES];
        self.navigationController.navigationBarHidden = YES;
    }
    
    [self.viewDeckController closeOpenView];
   
    }

- (IBAction)feedback_btn_Action:(id)sender
{
    if(![self.navigationController.topViewController isKindOfClass:[ProfileViewController class]])
    {
        FeedbackViewController *feedbackVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FeedbackViewController"];
        //[self.navigationController pushViewController:galleryVC animated:YES];
        
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:feedbackVC];
        
        navController.navigationBarHidden = YES;
        
        IIViewDeckController *deckView = [[IIViewDeckController alloc] initWithCenterViewController:navController leftViewController:feedbackVC rightViewController:nil];
        
        // [self.navigationController pushViewController:deckView animated:YES];
        // UIViewController* newController = [[UIViewController alloc] init];
        self.viewDeckController.centerController = deckView;
        
    }
    else
    {
        NSLog(@"same controller ");
        // [navController setViewControllers: @[deckController] animated: YES];
        self.navigationController.navigationBarHidden = YES;
    }
    
    [self.viewDeckController closeOpenView];

}

- (IBAction)logout_btn_action:(id)sender
{
    [appdelegateleftDrawer logoutRootVCMethod];

     [self.viewDeckController closeOpenView];
}



@end
