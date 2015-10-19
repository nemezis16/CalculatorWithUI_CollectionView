//
//  RationalNumber.m
//  RationalNumbers
//
//  Created by MacBook on 18.08.15.
//  Copyright (c) 2015 MacBook. All rights reserved.
//

#import "RationalNumbers.h"


@implementation RationalNumbers

@synthesize numerator,denominator;

#pragma mark initializations

-(instancetype)init{
    self=[super init];
    if(self){
        self.numerator=11;
        self.denominator=2;
    }
    return self;
}

-(instancetype)initWith:(NSInteger)oneParam{
    self=[super init];
    if(self){
        self.numerator=3;
        if(oneParam>0){
            self.denominator=oneParam;
        }else{
            self.denominator=5;
        }
    }
    return self;
}

-(instancetype)initWith:(NSInteger)oneParam and:(NSInteger)secondParam{
    self=[super init];
    if(self){
        self.numerator=oneParam;
        self.denominator=secondParam;
    }
    return  self;
}

#pragma mark math operations

+(RationalNumbers*)reducingFraction:(RationalNumbers*)Fraction{ 
    for(NSInteger i=Fraction.denominator;i>0;i--){
        if((Fraction.numerator%i==0) && (Fraction.denominator%i==0)){
            NSInteger reducedNumerator=Fraction.numerator/i;
            NSInteger reducedDenumerator=Fraction.denominator/i;
            return [[RationalNumbers alloc]initWith:reducedNumerator and:reducedDenumerator];
            break;
        }
    }return [[RationalNumbers alloc]initWith:0 and:0];
}

+(RationalNumbers*)add:(RationalNumbers*)Fraction1 and:(RationalNumbers *)Fraction2{
    NSInteger resultNumerator= Fraction1.numerator*Fraction2.denominator+Fraction1.denominator*Fraction2.numerator;
    NSInteger resultDenominator=Fraction1.denominator*Fraction2.denominator;
    RationalNumbers *resultFraction=[[RationalNumbers alloc]initWith:resultNumerator and:resultDenominator];
    
    return [RationalNumbers reducingFraction:resultFraction];
}

+(RationalNumbers*)subtract:(RationalNumbers*)Fraction1 and:(RationalNumbers *)Fraction2{
    NSInteger resultNumerator= Fraction1.numerator*Fraction2.denominator-Fraction1.denominator*Fraction2.numerator;
    NSInteger resultDenominator=Fraction1.denominator*Fraction2.denominator;
    RationalNumbers* resultFraction=[[RationalNumbers alloc]initWith:resultNumerator and:resultDenominator];
    
    return [RationalNumbers reducingFraction:resultFraction];
}

+(RationalNumbers*)multiply:(RationalNumbers*)Fraction1 and:(RationalNumbers *)Fraction2{
    NSInteger resultNumerator= Fraction1.numerator*Fraction2.numerator;
    NSInteger resultDenominator=Fraction1.denominator*Fraction2.denominator;
    RationalNumbers* resultFraction=[[RationalNumbers alloc]initWith:resultNumerator and:resultDenominator];
    
    return [RationalNumbers reducingFraction:resultFraction];
}

+(RationalNumbers*)divide:(RationalNumbers*)Fraction1 and:(RationalNumbers *)Fraction2{
    NSInteger resultNumerator= Fraction1.numerator*Fraction2.denominator;
    NSInteger resultDenominator=Fraction1.denominator*Fraction2.numerator;
    RationalNumbers* resultFraction=[[RationalNumbers alloc]initWith:resultNumerator and:resultDenominator];
    
    return [RationalNumbers reducingFraction:resultFraction];
}


#pragma mark support operations

-(NSString *)description{
    return [NSString stringWithFormat:@"%i/%i",self.numerator,self.denominator];
}

-(id)copyWithZone:(NSZone *)zone{
    RationalNumbers* copiedRationalNumber=[[[self class] allocWithZone:zone]
                                     initWith:[self numerator]
                                     and:[self denominator]];
    return copiedRationalNumber;
}

-(BOOL)isEqual:(id)object{
    if(self==object){
        return YES;
    }
    
    RationalNumbers* rationalNumb=(RationalNumbers*)object;
    if(!(self.numerator==rationalNumb.numerator)&&(self.denominator==rationalNumb.denominator)){
        return NO;
    }
    
    return YES;
}


@end


