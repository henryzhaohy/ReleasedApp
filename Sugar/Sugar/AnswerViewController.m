//
//  AnswerViewController.m
//  Sugar
//
//  Created by HANYU ZHAO on 2015-01-12.
//  Copyright (c) 2015 HANYU ZHAO. All rights reserved.
//

#import "AnswerViewController.h"
#import "constants.h"

@interface AnswerViewController ()

@end

@implementation AnswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString* file = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:NSLocalizedString(@"answer%d", @"comment"),(int)self.questionIndex] ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:htmlString baseURL:nil];
    
//    self.answerLabel.lineBreakMode = UILineBreakModeWordWrap;
/*
    switch (self.questionIndex) {
        case 1:
        {
            NSString* file = [[NSBundle mainBundle] pathForResource:@"answer1" ofType:@"html"];
            NSString* htmlString = [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
            [self.webView loadHTMLString:htmlString baseURL:nil];
            break;
        }
        default:
            break;
    }
*/
    
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

@end
