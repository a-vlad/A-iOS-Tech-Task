//
//  AURL.h
//  ATask
//
//  Created by Vlad on 9/12/2015.
//  Copyright © 2015 Vlad Paraschiv. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ABaseModel.h"

@interface AURL : ABaseModel

@property (nonatomic, readonly) NSURL       *urlPath;
@property (nonatomic, readonly) NSString    *urlTitle;

@end
