//
//  QuickHttpRequest.h
//  album
//
//  Created by Isken Huang on 10/24/12.
//  Copyright (c) 2012 Isken Huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuickNetwork.h"
#import "QuickAlertView.h"

@protocol QuickHttpRequestDelegate;

@interface QuickHttpRequest : QuickNetwork

@property (assign) id<QuickHttpRequestDelegate>delegate;

+(NSData *) httpRequestGETWithURL:(NSString *)_url;
+(NSData *) httpRequestGETWithURL:(NSString *)_url data:(NSMutableArray *)_data;
+(NSData *) httpRequestPOSTWithURL:(NSString *)_url data:(NSMutableArray *)_data;

-(void) initWithGETURL:(NSString *)_url;
-(void) initWithGETURL:(NSString *)_url data:(NSMutableArray *)_data;
-(void) initWithPOSTWithURL:(NSString *)_url data:(NSMutableArray *)_data;

@end

@protocol QuickHttpRequestDelegate <NSObject>
-(NSMutableData *) QuickHttpRequest:(QuickHttpRequest *)QuickHttpRequest didReceiveData:(NSMutableData *)data error:(NSError *)error;
@end