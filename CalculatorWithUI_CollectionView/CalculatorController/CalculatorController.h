//
//  CalculatorModel.h
//  CalculatorWithUI_RationalNumbers
//
//  Created by MacBook on 01.10.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RationalNumbers.h"

@interface CalculatorController : NSObject
@property(nonatomic, strong) NSString* stringToParse;

-(RationalNumbers*)getValueFromString:(NSString*)string;
@end
