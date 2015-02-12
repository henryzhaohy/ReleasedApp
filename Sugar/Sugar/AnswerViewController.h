//
//  AnswerViewController.h
//  Sugar
//
//  Created by HANYU ZHAO on 2015-01-12.
//  Copyright (c) 2015 HANYU ZHAO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnswerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property NSInteger questionIndex;

@end
