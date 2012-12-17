//
//  QuickHttpRequest.m
//  album
//
//  Created by Isken Huang on 10/24/12.
//  Copyright (c) 2012 Isken Huang. All rights reserved.
//

#import "QuickHttpRequest.h"

@interface QuickHttpRequest()
@property (strong, nonatomic) NSMutableData *receivedData;
@end

@implementation QuickHttpRequest

#pragma mark - Quick
+(NSData *) httpRequestGETWithURL:(NSString *)_url{
    if ([QuickNetwork checkNetworkStatus]) {
        @try{
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            NSURL *_connection = [[NSURL alloc] initWithString:_url];
            [request setURL:_connection];
            [request setHTTPMethod:@"GET"];
            return [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        }
        @catch (NSException *e){
            NSLog (@"[%d | %s] NSException %@:%@", __LINE__, __FUNCTION__, [e name], [e reason]);
        }
    }else{
//        [QuickAlertView alertViewWithCancelButton:@"ok" title:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"] message:@"目前無法連線網路"];
    }
}

//data format XXX=AAAAAA
+(NSData *) httpRequestGETWithURL:(NSString *)_url data:(NSMutableArray *)_data{
    return [QuickHttpRequest httpRequestGETWithURL:[NSString stringWithFormat:@"%@%@", _url, [[_data componentsJoinedByString:@"&"] dataUsingEncoding:NSUTF8StringEncoding]]];
}

+(NSData *) httpRequestPOSTWithURL:(NSString *)_url data:(NSMutableArray *)_data{
    if ([QuickNetwork checkNetworkStatus]) {
        @try{
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            NSURL *_connection = [[NSURL alloc] initWithString:_url];
            [request setURL:_connection];
            [request setHTTPMethod:@"POST"];
            [request setHTTPBody:[[_data componentsJoinedByString:@"&"] dataUsingEncoding:NSUTF8StringEncoding]];
            return [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        }
        @catch (NSException *e){
            NSLog (@"[%d | %s] NSException %@:%@", __LINE__, __FUNCTION__, [e name], [e reason]);
        }
    }else{
        [QuickAlertView alertViewWithCancelButton:@"ok" title:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"] message:@"目前無法連線網路"];
    }
}

#pragma mark - init
-(void) initWithGETURL:(NSString *)_url{
    if ([QuickNetwork checkNetworkStatus]) {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        NSURL *_connection = [[NSURL alloc] initWithString:_url];
        [request setURL:_connection];
        [request setHTTPMethod:@"GET"];
        [NSURLConnection connectionWithRequest:request delegate:self];
    }else{
        [QuickAlertView alertViewWithCancelButton:@"ok" title:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"] message:@"目前無法連線網路"];
    }
}

-(void) initWithGETURL:(NSString *)_url data:(NSMutableArray *)_data{
    return [self initWithGETURL:[NSString stringWithFormat:@"%@%@", _url, [[_data componentsJoinedByString:@"&"] dataUsingEncoding:NSUTF8StringEncoding]]];
}

-(void) initWithPOSTWithURL:(NSString *)_url data:(NSMutableArray *)_data{
    if ([QuickNetwork checkNetworkStatus]) {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        NSURL *_connection = [[NSURL alloc] initWithString:_url];
        [request setURL:_connection];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:[[_data componentsJoinedByString:@"&"] dataUsingEncoding:NSUTF8StringEncoding]];
        [NSURLConnection connectionWithRequest:request delegate:self];
        
    }else{
        [QuickAlertView alertViewWithCancelButton:@"ok" title:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"] message:@"目前無法連線網路"];
    }
}


#pragma mark -
#pragma mark NSURLConnectionDelegate
- (void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse*)response {
    [self.receivedData setLength:0];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)connection:(NSURLConnection*)connection didReceiveData:(NSData*)data {
    [self.receivedData appendData:data];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error {
    NSLog(@"[%d, %s] didFailWithError = %@", __LINE__, __FUNCTION__, error);
    if ([self respondsToSelector:@selector(QuickHttpRequest:didReceiveData:error:)]) {
        [self.delegate QuickHttpRequest:self didReceiveData:nil error:error];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection*)connection {
    if ([self respondsToSelector:@selector(QuickHttpRequest:didReceiveData:error:)]) {
        [self.delegate QuickHttpRequest:self didReceiveData:self.receivedData error:nil];
    }
}

@end
