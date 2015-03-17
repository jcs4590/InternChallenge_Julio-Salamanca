//
//  Giver.h
//  MyriadInternChallenge
//
//  Created by Julio Salamanca on 3/15/15.
//  Copyright (c) 2015 Julio Salamanca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"
@interface Giver : MTLModel <MTLJSONSerializing>
@property (strong,nonatomic) NSString * name;
@property NSInteger  giverID;
@property (strong,nonatomic) NSString * image;




@end
