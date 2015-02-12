//
//  SugarViewController.h
//  Sugar
//
//  Created by HANYU ZHAO on 2015-01-06.
//  Copyright (c) 2015 HANYU ZHAO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "SugarInfoCell.h"

@interface SugarViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong) NSMutableArray* sugarInfos;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
