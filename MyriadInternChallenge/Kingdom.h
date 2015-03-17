//
//  Kingdom.h
//  MyriadInternChallenge
//
//  Created by Julio Salamanca on 3/14/15.
//  Copyright (c) 2015 Julio Salamanca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"
#import "Quest.h"
@class Quest;

@interface Kingdom : MTLModel<MTLJSONSerializing>

@property(nonatomic,assign) NSInteger kingdom_ID;
@property(strong,nonatomic,readwrite) NSString * name;
@property(strong, nonatomic,readwrite) NSString * imageString;
@property (strong,nonatomic) NSString * climate;
@property NSInteger  population;
@property (strong,nonatomic) NSArray * quest;


@end
