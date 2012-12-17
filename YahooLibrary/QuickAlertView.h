//
//  QuickAlertView.h
//  
//
//  Created by Isken Huang on 10/19/12.
//  Copyright (c) 2012 Isken Huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface QuickAlertView : NSObject<UIAlertViewDelegate>

+ (void) alertViewWithCancelButton:(NSString *)cancelButtonName title:(NSString *)title message:(NSString *)message;
+ (void) alertViewWithOneButton:(NSString *)buttonName cancelButton:(NSString *)cancelButton title:(NSString *)title message:(NSString *)message;

@end
