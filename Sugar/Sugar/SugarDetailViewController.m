//
//  SugarDetailViewController.m
//  Sugar
//
//  Created by HANYU ZHAO on 2015-01-06.
//  Copyright (c) 2015 HANYU ZHAO. All rights reserved.
//

#import "SugarDetailViewController.h"
#import "constants.h"

@interface SugarDetailViewController ()

@property (nonatomic, strong) UIDatePicker *datePicker;

@property (nonatomic, strong) UIPickerView *whenPicker;
@property NSArray* whenArray;

@end

@implementation SugarDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.datePicker = [[UIDatePicker alloc] init];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    self.datePicker.minimumDate = [NSDate dateWithTimeIntervalSince1970:1261440000];
    self.datePicker.maximumDate = [NSDate date];
    [self.datePicker setDate:[NSDate date]];
    [self.datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    self.dateTextField.text = [dateFormatter stringFromDate:[NSDate date]];
    [self.dateTextField setInputView:self.datePicker];
    
    self.whenArray = @[NSLocalizedString(@"Before Breakfast", @"comment"),
                       NSLocalizedString(@"After Breakfast", @"comment"),
                       NSLocalizedString(@"Before Lunch", @"comment"),
                       NSLocalizedString(@"After Lunch", @"comment"),
                       NSLocalizedString(@"Before Dinner", @"comment"),
                       NSLocalizedString(@"After Dinner", @"comment")];
    
    self.whenPicker =  [[UIPickerView alloc] initWithFrame:CGRectMake(0, 200, 320, 200)];
    self.whenPicker.showsSelectionIndicator = YES;
    self.whenTextField.text = NSLocalizedString(@"Before Breakfast", @"comment");
    [self.whenTextField setInputView:self.whenPicker];

    // Connect data
    self.whenPicker.dataSource = self;
    self.whenPicker.delegate = self;

}


 -(void)updateTextField:(id)sender
 {
     self.datePicker = (UIDatePicker*)self.dateTextField.inputView;
     self.dateTextField.text = [self formatDate:self.datePicker.date];
//     [self.dateTextField resignFirstResponder];
 }

// Formats the date chosen with the date picker.
- (NSString *)formatDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *formattedDate = [dateFormatter stringFromDate:date];
    return formattedDate;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}


- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    
    float value = [self.valueTextField.text floatValue ];
    if (self.dateTextField.text.length < 10 ||
        self.whenTextField.text.length < 1 ||
        self.valueTextField.text.length < 1 ||
        self.valueTextField.text.length > 4 ||
        value < 0.1 ||
        value > 99.9)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Input Error", @"comment")
                                                        message:NSLocalizedString(@"The information you input is wrong format, please check!", @"comment")
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"OK", @"comment")
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    self.dateTextField.delegate = self;
    self.whenTextField.delegate = self;
    self.valueTextField.delegate = self;
    
    BOOL flag = false;
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [[NSDate alloc] init];
    date = [dateFormatter dateFromString:self.dateTextField.text];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"SugarInfo" inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];
    
    NSPredicate *predicate =
    [NSPredicate predicateWithFormat:@"date == %@", date];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *array = [managedObjectContext executeFetchRequest:request error:&error];
    
    if (!error && array.count>0){
        flag = true;
    }
    
    
    if (self.sugarInfo || flag) {
        // Update existing sugarInfo
        NSManagedObject* existSugarInfo = [array objectAtIndex:0];
        
        float valuef = [self.valueTextField.text floatValue];
        NSString* formatValueStr = [NSString stringWithFormat:@"%.1f", valuef];
        
        NSDecimalNumber* value = [NSDecimalNumber decimalNumberWithString:formatValueStr];
        
        if ([self.whenTextField.text isEqualToString:NSLocalizedString(@"Before Breakfast", @"comment")]) {
            [existSugarInfo setValue:value forKey:kWhen_Category1];
        } else if ([self.whenTextField.text isEqualToString:NSLocalizedString(@"After Breakfast", @"comment")]) {
            [existSugarInfo setValue:value forKey:kWhen_Category2];
        } else if ([self.whenTextField.text isEqualToString:NSLocalizedString(@"Before Lunch", @"comment")]) {
            [existSugarInfo setValue:value forKey:kWhen_Category3];
        } else if ([self.whenTextField.text isEqualToString:NSLocalizedString(@"After Lunch", @"comment")]) {
            [existSugarInfo setValue:value forKey:kWhen_Category4];
        } else if ([self.whenTextField.text isEqualToString:NSLocalizedString(@"Before Dinner", @"comment")]) {
            [existSugarInfo setValue:value forKey:kWhen_Category5];
        } else if ([self.whenTextField.text isEqualToString:NSLocalizedString(@"After Dinner", @"comment")]) {
            [existSugarInfo setValue:value forKey:kWhen_Category6];
        }
        
        
    } else {
        // Create a new sugarInfo
        NSManagedObject *newSugarInfo = [NSEntityDescription insertNewObjectForEntityForName:@"SugarInfo" inManagedObjectContext:context];

        [newSugarInfo setValue:date forKey:@"date"];
        
        float valuef = [self.valueTextField.text floatValue];
        NSString* formatValueStr = [NSString stringWithFormat:@"%.1f", valuef];
        
        NSDecimalNumber* value = [NSDecimalNumber decimalNumberWithString:formatValueStr];
        
        if ([self.whenTextField.text isEqualToString:NSLocalizedString(@"Before Breakfast", @"comment")]) {
            [newSugarInfo setValue:value forKey:kWhen_Category1];
        } else if ([self.whenTextField.text isEqualToString:NSLocalizedString(@"After Breakfast", @"comment")]) {
            [newSugarInfo setValue:value forKey:kWhen_Category2];
        } else if ([self.whenTextField.text isEqualToString:NSLocalizedString(@"Before Lunch", @"comment")]) {
            [newSugarInfo setValue:value forKey:kWhen_Category3];
        } else if ([self.whenTextField.text isEqualToString:NSLocalizedString(@"After Lunch", @"comment")]) {
            [newSugarInfo setValue:value forKey:kWhen_Category4];
        } else if ([self.whenTextField.text isEqualToString:NSLocalizedString(@"Before Dinner", @"comment")]) {
            [newSugarInfo setValue:value forKey:kWhen_Category5];
        } else if ([self.whenTextField.text isEqualToString:NSLocalizedString(@"After Dinner", @"comment")]) {
            [newSugarInfo setValue:value forKey:kWhen_Category6];
        }
        
    }
    
    NSError *error2 = nil;
    // Save the object to persistent store
    if (![context save:&error2]) {
        NSLog(@"Can't Save! %@ %@", error2, [error2 localizedDescription]);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

#pragma delegate
#pragma mark - delegate
// The number of columns of data
- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.whenArray.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.whenArray[row];
}

// Catpure the picker view selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.whenTextField.text = self.whenArray[row];
//    [self.whenTextField resignFirstResponder];
}

@end
