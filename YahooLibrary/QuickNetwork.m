//
//  QuickNetwork.m
//  album
//
//  Created by Isken Huang on 11/9/12.
//  Copyright (c) 2012 Isken Huang. All rights reserved.
//

#import "QuickNetwork.h"
#import <netinet/in.h>
#import <SystemConfiguration/SCNetworkReachability.h>

@implementation QuickNetwork

+(BOOL) checkNetworkStatus{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags){
        NSLog(@"Error. Could not recover network reachability flags");
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
	//NSLog(@"%d || %d", isReachable, needsConnection);
    return (isReachable && !needsConnection) ? YES : NO;
}

@end
