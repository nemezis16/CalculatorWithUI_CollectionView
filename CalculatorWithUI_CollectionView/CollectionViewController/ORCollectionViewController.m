//
//  ORViewController.m
//  trainingCollectionView
//
//  Created by MacBook on 11.10.15.
//  Copyright (c) 2015 Osadchuk. All rights reserved.
//

#import "ORCollectionViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "CalculatorController.h"

@interface ORCollectionViewController ()<UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) NSArray* arraySections;
@property (strong,nonatomic) CalculatorController* controller;
@end

@implementation ORCollectionViewController
@synthesize arraySections,controller;

- (void)viewDidLoad
{
    
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor colorWithRed:224 green:224 blue:224 alpha:1];
    
    arraySections=@[@[@""],
                   @[@"clean",@"<-",@"="],
                   @[@"1",@"2",@"3",@"+"],
                   @[@"4",@"5",@"6",@"-"],
                   @[@"7",@"8",@"9",@"x"],
                   @[@"0",@".",@"/"]];
    
    self.collectionView.frame=CGRectMake(27, 19, 600, 600);
    [self.collectionView reloadData];
    self.collectionView.delegate=self;
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [[self.arraySections objectAtIndex:section]count];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.arraySections.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    ORCollectionViewCell* newCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSArray* section=arraySections[indexPath.section];
    NSString* item=[section objectAtIndex:indexPath.item];
    newCell.textField.text = item;
    
    if (indexPath.section==0) {
        UILabel *customLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10,230, 40)];
        customLabel.textAlignment=NSTextAlignmentRight;
        customLabel.text = @"0";
        
        newCell.textField=customLabel;
        newCell.textField.backgroundColor=newCell.backgroundColor;
        [newCell addSubview:newCell.textField];
    }
    
    [self makeRoundedItems:newCell];
    
    return newCell;
}

-(void)makeRoundedItems:(UICollectionViewCell*)newCell{
    
    newCell.clipsToBounds = YES;
    CGPoint saveCenter = newCell.center;
    CGRect newFrame = CGRectMake(newCell.frame.origin.x, newCell.frame.origin.y, 40, 40);
    newCell.frame = newFrame;
    newCell.layer.cornerRadius = 25 / 2.0;
    newCell.center = saveCenter;
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGSize defaultSize = [(UICollectionViewFlowLayout*)collectionViewLayout itemSize];
    
    if (indexPath.section==0) {
        defaultSize.width =defaultSize.width * 5-15;
        return defaultSize;
    }
    if((indexPath.section==1)&&(indexPath.item==2)){
        defaultSize.width =defaultSize.width * 2+15;
        return defaultSize;
    }
    if((indexPath.section==5)&&(indexPath.item==0)){
        defaultSize.width =defaultSize.width * 2+15;
        return defaultSize;
    }
    return defaultSize;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //get text field cell
    NSIndexPath* indexPathForTextField=[NSIndexPath indexPathForItem:0 inSection:0];
    ORCollectionViewCell *textFieldCell =(ORCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPathForTextField];
    
    //get common cell (aka button)
    ORCollectionViewCell *cell =(ORCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    
    //get last typed character
    NSString* lastOperation=[textFieldCell.textField.text substringFromIndex:[textFieldCell.textField.text length]-1];
    NSString* operations=@"+-x/.";
    
    
    //type  characters to field
    if (indexPath.section>1) {
        if((indexPath.item==3 || (indexPath.item>0 && indexPath.section==5 ))
           && [operations rangeOfString:lastOperation].location != NSNotFound){
            
            //change last clicked operation
            textFieldCell.textField.text=[textFieldCell.textField.text substringToIndex:[textFieldCell.textField.text length] -1];
            textFieldCell.textField.text=[textFieldCell.textField.text stringByAppendingString:
                                          cell.textField.text];
        }else{
            if ([textFieldCell.textField.text isEqualToString: @"0"]) {
              textFieldCell.textField.text=[textFieldCell.textField.text substringToIndex:[textFieldCell.textField.text length] -1];  
            }
            textFieldCell.textField.text=[textFieldCell.textField.text stringByAppendingString:cell.textField.text];
        }
    }
    
    //on backspace clicked
    if (indexPath.section==1) {
        if (indexPath.item==0) {
            textFieldCell.textField.text=@"0";
        }
        if (indexPath.item==1) {
            if ([textFieldCell.textField.text length]==1) {
                textFieldCell.textField.text=@"0";
            }else
            textFieldCell.textField.text=[textFieldCell.textField.text substringToIndex:[textFieldCell.textField.text length] -1];
        }
    }
    
    // on equal clicked
    if (indexPath.item==2&&indexPath.section==1) {
        self.controller=[CalculatorController new];
        RationalNumbers* i=[self.controller getValueFromString:textFieldCell.textField.text];
        if([i denominator]==1){
            textFieldCell.textField.text=[NSString stringWithFormat:@"%i",[i numerator]];
        }else if([i denominator]==0){
            textFieldCell.textField.text=[NSString stringWithFormat:@"Error"];
        }else{
            textFieldCell.textField.text=[i description];
        }
    }
    
  
//                             
//    
//    if ([operations rangeOfString:lastOperation].location == NSNotFound ) {
//        self.label.text=[.text stringByAppendingString:sender.titleLabel.text];
//    }
//    
//    if ([textFieldCell.textField.text substringFromIndex:[label.text length]-1]) {
//        
//    }
//    textFieldCell.textField.text=[textFieldCell.textField.text stringByAppendingString:cell.textField.text];
//    
    
    //NSLog(@"touched cell %@ at indexPath %@", cell, indexPath);
}


#pragma mark Suport only portrait orientation

-(BOOL)shouldAutorotate
{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
