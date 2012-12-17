//
//  QuickAlertView.m
//
//
//  Created by Isken Huang on 10/19/12.
//  Copyright (c) 2012 Isken Huang. All rights reserved.
//

#import "QuickAlertView.h"

@implementation QuickAlertView

+ (void) alertViewWithCancelButton:(NSString *)cancelButtonName title:(NSString *)title message:(NSString *)message{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonName otherButtonTitles:nil];
    [alertView show];
}

+ (void) alertViewWithOneButton:(NSString *)buttonName cancelButton:(NSString *)cancelButton title:(NSString *)title message:(NSString *)message{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButton otherButtonTitles:buttonName,nil];
    [alertView show];
}

#pragma mark UIAlertViewDelegate
-(void) alertViewCancel:(UIAlertView *)alertView{
    NSLog(@"alertViewCancel");
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"clickedButtonAtIndex = %d", buttonIndex);
}

-(void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    NSLog(@"didDismissWithButtonIndex = %d", buttonIndex);
}

-(void) alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex{
    NSLog(@"willDismissWithButtonIndex = %d", buttonIndex);
}

@end
