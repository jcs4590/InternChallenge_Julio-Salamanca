//
//  Quest.h
//  MyriadInternChallenge
//
//  Created by Julio Salamanca on 3/15/15.
//  Copyright (c) 2015 Julio Salamanca. All rights reserved.
//

#import "Kingdom.h"
#import <Foundation/Foundation.h>
#import "Giver.h"

@interface Quest : MTLModel <MTLJSONSerializing>

@property (strong,nonatomic) NSString * name;
@property NSInteger  quest_ID;
@property (strong,nonatomic) NSString * questDescription;
@property (strong,nonatomic) NSString * questImageString;
@property (strong,nonatomic) Giver * giver;




@end
