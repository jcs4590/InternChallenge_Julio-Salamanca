//
//  Kingdom.m
//  MyriadInternChallenge
//
//  Created by Julio Salamanca on 3/14/15.
//  Copyright (c) 2015 Julio Salamanca. All rights reserved.
//

#import "Kingdom.h"

@implementation Kingdom

+(NSDictionary *)JSONKeyPathsByPropertyKey{
  
  return @{
           @"imageString":@"image",
           @"kingdom_ID":@"id",
           @"quest": @"quests"

           
           };
  
}



+ (NSValueTransformer *)questTransformer
{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[Quest class]];
}





@end
