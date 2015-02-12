//
//  SugarDetailViewController.h
//  Sugar
//
//  Created by HANYU ZHAO on 2015-01-06.
//  Copyright (c) 2015 HANYU ZHAO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface SugarDetailViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>

@property (strong) NSManagedObject *sugarInfo;

@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
@property (weak, nonatomic) IBOutlet UITextField *whenTextField;
@property (weak, nonatomic) IBOutlet UITextField *valueTextField;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@end
