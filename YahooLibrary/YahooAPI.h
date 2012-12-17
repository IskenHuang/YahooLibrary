//
//  YahooAPI.h
//  YahooLibrary
//
//  Created by Isken Huang on 12/17/12.
//  Copyright (c) 2012 Isken Huang. All rights reserved.
//

#import "QuickHttpRequest.h"

typedef enum{
    YAHOO_WEATHER_UNIT_FAHRENHEIT,
    YAHOO_WEATHER_UNIT_CELSIUS
}YAHOO_WEATHER_UNIT;

@interface YahooAPI : QuickHttpRequest

/* 
 weather api
 */

//default unit is YAHOO_WEATHER_UNIT_CELSIUS
+ (NSMutableDictionary *) yahooAPIWeatherWithWOEID:(NSString *)woeid;
+ (NSMutableDictionary *) yahooAPIWeatherWithWOEID:(NSString *)woeid unit:(YAHOO_WEATHER_UNIT)unit;


/*
 woeid
 */
+ (NSMutableDictionary *) yahooAPIWOEIDWithLatitude:(double)latitude Longitude:(double)longitude;
+ (NSMutableDictionary *) yahooAPIWOEIDWithAddress:(NSString *)address;

@end
