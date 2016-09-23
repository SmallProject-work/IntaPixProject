//
//  videoWebViewController.h
//  inta_pix
//
//  Created by test on 16/09/16.
//  Copyright © 2016 gauganTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface videoWebViewController : UIViewController<UIWebViewDelegate>
@property (nonatomic, strong)NSString *urlStr;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

- (IBAction)backBtnAction:(id)sender;

@end
