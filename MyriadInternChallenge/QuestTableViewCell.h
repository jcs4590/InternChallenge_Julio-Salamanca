//
//  QuestTableViewCell.h
//  MyriadInternChallenge
//
//  Created by Julio Salamanca on 3/15/15.
//  Copyright (c) 2015 Julio Salamanca. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *giverImageView;

@property (weak, nonatomic) IBOutlet UILabel *giverLabelview;
@property (weak, nonatomic) IBOutlet UIImageView *questImageView;
@property (weak, nonatomic) IBOutlet UILabel *questNameLabelView;

@property (strong, nonatomic) IBOutlet UILabel *noQuestImagelabel;

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabelView;


@end
