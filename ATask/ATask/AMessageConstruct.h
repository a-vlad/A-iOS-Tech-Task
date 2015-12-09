//
//  AMessageConstruct.h
//  ATask
//
//  Created by Vlad on 9/12/2015.
//  Copyright © 2015 Vlad Paraschiv. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "APerson.h"
#import "AURL.h"
#import "AEmoticon.h"

@interface AMessageConstruct : ABaseModel

@property (nonatomic, readonly) NSArray<APerson*>   *persons;
@property (nonatomic, readonly) NSArray<AURL*>      *urls;
@property (nonatomic, readonly) NSArray<AEmoticon*> *emoticons;

@end
