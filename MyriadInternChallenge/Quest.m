//
//  Quest.m
//  MyriadInternChallenge
//
//  Created by Julio Salamanca on 3/15/15.
//  Copyright (c) 2015 Julio Salamanca. All rights reserved.
//

#import "Quest.h"

@implementation Quest


+(NSDictionary *)JSONKeyPathsByPropertyKey{
    
    return @{
             @"quest_ID":@"id",
             @"questDescription":@"description",
             @"questImageString": @"image",
             
             
             };
    
}


+ (NSValueTransformer *)giverJSONTransformer{
    
    
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSDictionary *giverArray) {
        return [MTLJSONAdapter modelOfClass: Giver.class
                         fromJSONDictionary: giverArray
                                      error: nil];
    }reverseBlock:^(Quest * quest) {
        return [MTLJSONAdapter JSONDictionaryFromModel: quest];
    }];
}



@end
