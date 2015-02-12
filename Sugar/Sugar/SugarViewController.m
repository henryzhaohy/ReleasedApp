//
//  SugarViewController.m
//  Sugar
//
//  Created by HANYU ZHAO on 2015-01-06.
//  Copyright (c) 2015 HANYU ZHAO. All rights reserved.
//

#import "SugarViewController.h"
#import "constants.h"
#import "SugarDetailViewController.h"

@interface SugarViewController ()

@end

@implementation SugarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
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

#pragma UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sugarInfos.count;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
        [context deleteObject:[self.sugarInfos objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        
        // Remove device from table view
        [self.sugarInfos removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    static NSString *CellIdentifier = @"SugarInfoCell";
   
    SugarInfoCell *cell = (SugarInfoCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SugarInfoCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSManagedObject *sugarInfo = [self.sugarInfos objectAtIndex:indexPath.row];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    cell.dateLabel.text = [dateFormatter stringFromDate:[sugarInfo valueForKey:@"date"]];
    
    cell.beforeBreakfast.text = [NSString stringWithFormat:@"%@", [sugarInfo valueForKey:kWhen_Category1]];
    cell.afterBreakfast.text = [NSString stringWithFormat:@"%@", [sugarInfo valueForKey:kWhen_Category2]];
    cell.beforeLunch.text = [NSString stringWithFormat:@"%@", [sugarInfo valueForKey:kWhen_Category3]];
    cell.afterLunch.text = [NSString stringWithFormat:@"%@", [sugarInfo valueForKey:kWhen_Category4]];
    cell.beforeDinner.text = [NSString stringWithFormat:@"%@", [sugarInfo valueForKey:kWhen_Category5]];
    cell.afterDinner.text = [NSString stringWithFormat:@"%@", [sugarInfo valueForKey:kWhen_Category6]];
    
    int eligibleCount = 0;
    int count = 0;
    double bbd = [[sugarInfo valueForKey:kWhen_Category1] doubleValue];
    double abd = [[sugarInfo valueForKey:kWhen_Category2] doubleValue];
    double bld = [[sugarInfo valueForKey:kWhen_Category3] doubleValue];
    double ald = [[sugarInfo valueForKey:kWhen_Category4] doubleValue];
    double bdd = [[sugarInfo valueForKey:kWhen_Category5] doubleValue];
    double add = [[sugarInfo valueForKey:kWhen_Category6] doubleValue];
    
    //no diabetes before meals(4.0 to 5.9 mmol/L) & two hours after meal(4.0~7.8)
    if (bbd > 0)
    {
        count++;
        if (bbd >= MINIMUM_VALUE_NORMAL && bbd <= MAXIMUM_VALUE_BEFOREMEAL_NORMAL) {
            eligibleCount++;
        } else {
            cell.beforeBreakfast.textColor = [UIColor redColor];
        }
    }
    if (abd > 0) {
        count++;
        if (abd >= MINIMUM_VALUE_NORMAL && abd <= MAXIMUM_VALUE_AFTERMEAL_NORMAL) {
            eligibleCount++;
        } else {
            cell.afterBreakfast.textColor = [UIColor redColor];
        }
    }
    if (bld > 0) {
        count++;
        if (bld >= MINIMUM_VALUE_NORMAL && bld <= MAXIMUM_VALUE_BEFOREMEAL_NORMAL) {
            eligibleCount++;
        } else {
            cell.beforeLunch.textColor = [UIColor redColor];
        }
    }
    if (ald > 0) {
        count++;
        if (ald >= MINIMUM_VALUE_NORMAL && ald <= MAXIMUM_VALUE_AFTERMEAL_NORMAL) {
            eligibleCount++;
        } else {
            cell.afterLunch.textColor = [UIColor redColor];
        }
    }
    if (bdd > 0) {
        count++;
        if (bdd >= MINIMUM_VALUE_NORMAL && bdd <= MAXIMUM_VALUE_BEFOREMEAL_NORMAL) {
            eligibleCount++;
        } else {
            cell.beforeDinner.textColor = [UIColor redColor];
        }
    }
    if (add > 0) {
        count++;
        if (add >= MINIMUM_VALUE_NORMAL && add <= MAXIMUM_VALUE_AFTERMEAL_NORMAL) {
            eligibleCount++;
        } else {
            cell.afterDinner.textColor = [UIColor redColor];
        }
    }
    
    float rate = (float)eligibleCount / (float)count;
//    NSLog(@"rate=%f, eligibleCount=%f,count=%f",rate,(float)eligibleCount,(float)count);
    if (rate>=0 && rate<0.2) {
        cell.faceImageView.image = [UIImage imageNamed:FACEIMAGE_LEVEL1];
    }
    else if (rate>=0.2 && rate<0.4) {
        cell.faceImageView.image = [UIImage imageNamed:FACEIMAGE_LEVEL2];
    }
    else if (rate>=0.4 && rate<0.6) {
        cell.faceImageView.image = [UIImage imageNamed:FACEIMAGE_LEVEL3];
    }
    else if (rate>=0.6 && rate<0.8) {
        cell.faceImageView.image = [UIImage imageNamed:FACEIMAGE_LEVEL4];
    }
    else if (rate>=0.8 && rate<1.0) {
        cell.faceImageView.image = [UIImage imageNamed:FACEIMAGE_LEVEL5];
    }
    else if (rate==1.0) {
        cell.faceImageView.image = [UIImage imageNamed:FACEIMAGE_LEVEL6];
    }
    
    return cell;
    
    
}

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Fetch the devices from persistent data store
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"SugarInfo"];
    self.sugarInfos = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"UpdateSugarDetail"]) {
        NSManagedObject *sugarInfo = [self.sugarInfos objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        SugarDetailViewController *sdViewController = segue.destinationViewController;
        sdViewController.sugarInfo = sugarInfo;
    }
}


@end
