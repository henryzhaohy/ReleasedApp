//
//  KnowledgeViewController.m
//  Sugar
//
//  Created by HANYU ZHAO on 2015-01-12.
//  Copyright (c) 2015 HANYU ZHAO. All rights reserved.
//

#import "KnowledgeViewController.h"
#import "constants.h"

@interface KnowledgeViewController ()

@property (nonatomic, strong) NSArray* questionArray;

@end

@implementation KnowledgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.questionArray = [[NSArray alloc] initWithObjects:
                          NSLocalizedString(@"Question1", @"comment"),
                          NSLocalizedString(@"Question2", @"comment"),
                          NSLocalizedString(@"Question3", @"comment"),
                          NSLocalizedString(@"Question4", @"comment"),
                          NSLocalizedString(@"Question5", @"comment"),
                          NSLocalizedString(@"Question6", @"comment"),
                          NSLocalizedString(@"Question7", @"comment"),
                          NSLocalizedString(@"Question8", @"comment"),
                          NSLocalizedString(@"Question9", @"comment"),
                          NSLocalizedString(@"Question10", @"comment"), nil];
    
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


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.questionArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // Dequeue the cell.
    
    static NSString *simpleTableIdentifier = @"QuestionTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [self.questionArray objectAtIndex:indexPath.row];
    return cell;
    
}

// Tap on table Row
//- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath
//{
//    [self performSegueWithIdentifier:@"segueAnswer" sender:self];
//}

//// Tap on row accessory
//- (void) tableView: (UITableView *) tableView accessoryButtonTappedForRowWithIndexPath: (NSIndexPath *) indexPath
//{
//    [self performSegueWithIdentifier:@"segueAnswer" sender:self];
//}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"segueAnswer"]) {       
        AnswerViewController *avc = segue.destinationViewController;
        avc.questionIndex = [[self.tableView indexPathForSelectedRow] row] + 1;
    }
}

@end
