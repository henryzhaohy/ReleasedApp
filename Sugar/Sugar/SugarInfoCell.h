//
//  SugarInfoCell.h
//  Sugar
//
//  Created by HANYU ZHAO on 2015-01-06.
//  Copyright (c) 2015 HANYU ZHAO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SugarInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *beforeBreakfast;
@property (weak, nonatomic) IBOutlet UILabel *afterBreakfast;
@property (weak, nonatomic) IBOutlet UILabel *beforeLunch;
@property (weak, nonatomic) IBOutlet UILabel *afterLunch;
@property (weak, nonatomic) IBOutlet UILabel *beforeDinner;
@property (weak, nonatomic) IBOutlet UILabel *afterDinner;

@property (weak, nonatomic) IBOutlet UIImageView *faceImageView;
@end
