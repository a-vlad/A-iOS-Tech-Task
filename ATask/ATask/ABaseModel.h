//
//  ABaseModel.h
//  ATask
//
//  Created by Vlad on 9/12/2015.
//  Copyright © 2015 Vlad Paraschiv. All rights reserved.
//

//
//  Base model class for all our objects. Defines clear shared interface
//  for all our model objects that they should conform to.
//
//  This will allow us to recursivly construct our JSON string by calling
//  generateJSONString on all model properties all the way down and form
//  the whole JSON model.
//

#import <Foundation/Foundation.h>

@interface ABaseModel : NSObject

- (instancetype)initWithString:(NSString*)string;

/**
 *  Generates JSON string from
 */
- (NSString*)generateJSONString;

@end
