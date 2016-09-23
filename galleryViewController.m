//
//  galleryViewController.m
//  inta_pix
//
//  Created by test on 22/08/16.
//  Copyright © 2016 gauganTechnologies. All rights reserved.
//




#import "galleryViewController.h"
//#import "MMDrawerController.h"
#import "AppDelegate.h"


@interface galleryViewController ()<UINavigationBarDelegate,UIImagePickerControllerDelegate>
{
    UIPopoverController *popoverController;
   
    NSArray *imageTo_test;
    AppDelegate *appdelegateInsta;
    UIImage* image;
    NSMutableArray *images;
    NSMutableArray *imagesAryToPassServer;
    NSIndexPath *selectedIndexPath;
   NSInteger selectedImage;
    NSData *imgData;
    UIImage *img;
    NSInputStream *stream;
    UIImage *imageToPAss;
    NSString *userId;
}
@property (nonatomic, strong) ALAssetsLibrary *specialLibrary;

@end

@implementation galleryViewController
bool isShown;
bool drawerClick;
@synthesize centerController = _viewController;
@synthesize leftController = _leftController;
@synthesize loginStr;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    lib_btn_outlet.clipsToBounds = true;
    lib_btn_outlet.layer.cornerRadius = 21.5;
    imageTo_test = [[NSArray alloc]init];
    imageTo_test = @[@"bg.png",@"logo.png"];
    imagesAryToPassServer = [[NSMutableArray alloc]init];
    
    // self.viewDeckController.panningGestureDelegate = self;
   // [self.viewDeckController toggleLeftView];

    if([[NSUserDefaults standardUserDefaults]boolForKey:@"chkLftController"])
    {
        [self.viewDeckController closeOpenView];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"chkLftController"];

    }
    else
    {
        [appdelegateInsta galleryRootVCMethod];
        [self drawerBtn_action:nil];
    }
    
   // [self SetupSideMenu];
     self.navigationItem.title = @"Upload Photos";
    
  
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"left" style:UIBarButtonItemStyleBordered target:self.viewDeckController action:@selector(toggleLeftView)];

    
    if ([self.navigationItem respondsToSelector:@selector(leftBarButtonItems)]) {
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:
                                                  [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"drawerBtn"] style:UIBarButtonItemStyleBordered target:self.viewDeckController action:@selector(toggleLeftView)],nil];
        
  
     
      
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        [self.navigationController.navigationBar
         setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
        
        [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:235.0/255 green:87.0/255 blue:13.0/255 alpha:1]];
        
    }
    imagesTableView.hidden = TRUE;

}
-(void)viewWillAppear:(BOOL)animated
{
     [super viewWillAppear:animated];
    appdelegateInsta = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSString *stored_userID = [[NSUserDefaults standardUserDefaults] valueForKey:@"User_id"];
    userId = [NSString stringWithFormat:@"%@",stored_userID];
    NSLog(@"userIdStr %@",userId);

    
}
- (void)previewBounceLeftView
    {
        [self.viewDeckController previewBounceView:IIViewDeckLeftSide];
    }


- (void) viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    // code...
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIImagePicker delegate method
- (IBAction)lib_btn_action:(id)sender
{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Title"
                                 message:@"Message"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* galleryButton = [UIAlertAction
                                actionWithTitle:@"Photo gallery"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
{
    
     scrollView.hidden = false;
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
    
    elcPicker.maximumImagesCount = 40; //Set the maximum number of images to select to 100
    elcPicker.returnsOriginalImage = YES; //Only return the fullScreenImage, not the fullResolutionImage
    elcPicker.returnsImage = YES; //Return UIimage if YES. If NO, only return asset location information
    elcPicker.onOrder = YES; //For multiple image selection, display and return order of selected images
    elcPicker.mediaTypes = @[(NSString *)kUTTypeImage, (NSString *)kUTTypeMovie]; //Supports image and movie types
    
    elcPicker.imagePickerDelegate = self;
    
    [self presentViewController:elcPicker animated:YES completion:nil];
}];
    
    UIAlertAction* takePicButton = [UIAlertAction
                               actionWithTitle:@"Take picture"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
    {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            
             scrollView.hidden = false;
            UIImagePickerController *pickerView =[[UIImagePickerController alloc]init];
            pickerView.sourceType = UIImagePickerControllerSourceTypeCamera;
            pickerView.allowsEditing = YES;
            pickerView.delegate = self;
            pickerView.showsCameraControls = true;
            [self presentViewController:pickerView animated:YES completion:NULL];
        }
        else
        {
            // scrollView.hidden = true;
            UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Alert!"
                                                                  message:@"Device has no camera"
                                                                 delegate:nil
                                                        cancelButtonTitle:@"OK"
                                                        otherButtonTitles: nil];
            
            [myAlertView show];
        }

                               }];
    
    UIAlertAction* cancelButton = [UIAlertAction
                                    actionWithTitle:@"Cancel"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
    {
        
        [self dismissViewControllerAnimated:alert completion:nil];
                                    }];

    
    [alert addAction:galleryButton];
    [alert addAction:takePicButton];
    [alert addAction:cancelButton];

    
    [self presentViewController:alert animated:YES completion:nil];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return YES;
    } else {
        return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
    }
}

#pragma mark ELCImagePickerControllerDelegate Methods

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    for (UIView *v in [scrollView subviews]) {
        [v removeFromSuperview];
    }
    
    CGRect workingFrame = scrollView.frame;
    workingFrame.origin.x = 0;
    
    images = [NSMutableArray arrayWithCapacity:[info count]];
    for (NSDictionary *dict in info)
    {
        if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypePhoto)
        {
            if ([dict objectForKey:UIImagePickerControllerOriginalImage])
            {
                image=[dict objectForKey:UIImagePickerControllerOriginalImage];
                [images addObject:image];
                [imagesAryToPassServer addObject:[dict objectForKey:UIImagePickerControllerReferenceURL]];
            }
            else
            {
                NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
            }
//        } else if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypeVideo){
//            if ([dict objectForKey:UIImagePickerControllerOriginalImage]){
//                UIImage* image=[dict objectForKey:UIImagePickerControllerOriginalImage];
//                
//                [images addObject:image];
//                
//                UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
//                [imageview setContentMode:UIViewContentModeScaleAspectFit];
//                imageview.frame = workingFrame;
//                
//                [scrollView addSubview:imageview];
//                
//                workingFrame.origin.x = workingFrame.origin.x + workingFrame.size.width;
//            } else {
//                NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
//            }
        }
        else
        {
            NSLog(@"Uknown asset type");
        }
   // }
    
    self.chosenImages = images;
     [imagesTableView reloadData];
          imagesTableView.hidden = false;
    //[scrollView setPagingEnabled:YES];
        
   // [scrollView setContentSize:CGSizeMake( workingFrame.size.width,workingFrame.origin.y)];
        
    }

}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)handleLongPress:(UILongPressGestureRecognizer *)sender
{
    NSLog(@"detected");
    
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        
        for (int j= 0; j< images.count; j++)
        {
            NSString *count = [images objectAtIndex:j];
            NSLog(@"count %@",count);
          
        }
        
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Delete Picture."    delegate:self cancelButtonTitle:@"Delete" otherButtonTitles:@"Cancel", nil];
        [alert show];
    } 
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (images.count == 0)
    {
         imagesTableView.hidden = TRUE;
        return 0;
    }
    else
    {
        imagesTableView.hidden = false;
    return [images count];
    }
    
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    galleryTableViewCell *cell = (galleryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"galleryTableViewCell"];
   
    if (cell == nil) {
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"galleryTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
 
     cell.galleryImageVw.image = images[indexPath.row];
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    selectedIndexPath = [tableView indexPathForSelectedRow];
    NSLog(@"selectedIndexPath %@",selectedIndexPath);
    selectedImage = indexPath.row;
    NSLog(@"selectedSongStr %ld",(long)selectedImage);
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Delete Picture."    delegate:self cancelButtonTitle:@"Delete" otherButtonTitles:@"Cancel", nil];
    [alert show];
    

    
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
   
        
        if(buttonIndex == 0)
        {
            NSLog(@"delete");
            
            for (int i=0; i<images.count;i++)
            {
                if ((int)(selectedImage) == i)
                {
                    [images removeObjectAtIndex:i];
                     NSLog(@"i count %d",i);
                    break;
                }
            }
            [imagesTableView reloadData];
        }
        else
        {
            NSLog(@"cancel");
            
        }
    
}
#pragma mark - Button_action

- (IBAction)drawerBtn_action:(id)sender
{
    drawerClick = true;
    [appdelegateInsta galleryRootVCMethod];
 
    [self.viewDeckController toggleLeftView];

 }


- (IBAction)next_btn_action:(id)sender
{

   //[self postImagesMethod];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"chkContMusic"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    MusicViewController *musicVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MusicViewController"];
    

    
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"chkNxtController"])
    {
       self.viewDeckController.centerController = musicVC;

        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"chkNxtController"];
        
    }
    else
    {
         [self.navigationController pushViewController:musicVC animated:YES];
       
        [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"chkNxtController"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"chkNxtMusicController"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        

        
    }


  
    
    
//    //self.viewDeckController.navigationController:musicVC;
//    
//        for (UIViewController *controller in self.navigationController.viewControllers) {
//    
//            //Do not forget to import AnOldViewController.h
//            if ([controller isKindOfClass:[MusicViewController class]]) {
//    
//                NSLog(@"logout");
//    
//               // [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"LogIn"];
//    
//    
//                [self.navigationController pushViewController:controller
//                                                      animated:YES];
//                break;
//            }
//        }

    
}

- (IBAction)del_btn_action:(id)sender
{
    [images removeAllObjects];
    imagesTableView.hidden = TRUE;
}

-(void)postImagesMethod
{
      NSData *imageData =  UIImagePNGRepresentation(image);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    if (imageData != nil)
        {
             for(int i=0; i<self.chosenImages.count; i++)
             {
            img = (UIImage*) [self.chosenImages objectAtIndex:i];
                 
              NSData * imageDateToPAss = UIImageJPEGRepresentation(img, 1.0);
    // convert your image into data
    
    NSString *urlString = [NSString stringWithFormat:@"http://gaugantech.com/intapix/img_upload.php"];  // enter your url to upload
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];  // allocate AFHTTPManager
   
    [manager POST:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {  // POST DATA USING MULTIPART CONTENT TYPE
       manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        manager.responseSerializer.acceptableContentTypes = nil;
        
        [formData appendPartWithFileData:imageDateToPAss
                                    name:@"userfile"
                                fileName:[NSString stringWithFormat:@"%@userfile%d.jpg",userId,i] mimeType:@"image/jpeg"];   // add image to formData
        
       
          }
         progress:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
        NSLog(@"Response: %@", responseObject);    // Get response from the server
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
              NSLog(@"string %@",string);
        [ MBProgressHUD hideHUDForView:self.view animated:YES];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error)
    {
        NSLog(@"Error: %@", error);   // Gives Error
        
    }];
}
}
else
{
      NSLog(@"error nil nsdata ");
}
}


//-(void)SetupSideMenu
//{
//    UIViewController* centerController = [[galleryViewController alloc] init];
//    centerController = [self.storyboard instantiateViewControllerWithIdentifier:@"galleryViewController"];
//    
//    UIViewController* leftController = [[leftDrawerVC alloc] init];
//    leftController = [self.storyboard instantiateViewControllerWithIdentifier:@"leftDrawerVC"];
//    
//      IIViewDeckController* deckController =  [[IIViewDeckController alloc] initWithCenterViewController:self.centerController leftViewController:centerController rightViewController:leftController];
//    
//    
//    
//    deckController.centerhiddenInteractivity = IIViewDeckCenterHiddenNotUserInteractiveWithTapToClose;
//    deckController.delegateMode = IIViewDeckDelegateAndSubControllers;
//       [self.view addSubview:deckController.view];
//    [deckController toggleLeftViewAnimated:YES];
//
//    
//}

@end
