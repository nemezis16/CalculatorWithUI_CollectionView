//
//  RationalNumber.h
//  RationalNumbers
//
//  Created by MacBook on 18.08.15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RationalNumbers : NSObject<NSCopying>

@property (nonatomic,assign) NSInteger numerator;
@property (nonatomic,assign) NSInteger denominator;
@property RationalNumbers* resultFraction;

-(instancetype)init;
-(instancetype)initWith:(NSInteger)oneParam;
-(instancetype)initWith:(NSInteger)oneParam and:(NSInteger)secondParam;

-(NSString *)description;
+(RationalNumbers* )reducingFraction:(RationalNumbers* )Fraction;


+(RationalNumbers* )add:(RationalNumbers*)Fraction1 and:(RationalNumbers*)Fraction2;
+(RationalNumbers* )subtract:(RationalNumbers*)Fraction1 and:(RationalNumbers*)Fraction2;
+(RationalNumbers* )multiply:(RationalNumbers*)Fraction1 and:(RationalNumbers*)Fraction2;
+(RationalNumbers* )divide:(RationalNumbers*)Fraction1 and:(RationalNumbers*)Fraction2;

-(id)copyWithZone:(NSZone *)zone;

@end

