//
//  YahooAPI.m
//  YahooLibrary
//
//  Created by Isken Huang on 12/17/12.
//  Copyright (c) 2012 Isken Huang. All rights reserved.
//

#import "YahooAPI.h"
#import "SBJson.h"

#define YAHOO_WEATHER_SERVER @"http://query.yahooapis.com/v1/public/yql?q=select item from weather.forecast where woeid=%@ AND u='%@'&format=json"
#define YAHOO_WOEID_SERVER_LOCATION @"http://where.yahooapis.com/geocode?location=%f,%f&flags=J&gflags=R"
#define YAHOO_WOEID_SERVER_ADDRESS @"http://where.yahooapis.com/geocode?q=%@&flags=J&gflags=R"

@implementation YahooAPI

#pragma mark Weather
+ (NSMutableDictionary *) yahooAPIWeatherWithWOEID:(NSString *)woeid{
    return [YahooAPI yahooAPIWeatherWithWOEID:woeid unit:YAHOO_WEATHER_UNIT_CELSIUS];
}

+ (NSMutableDictionary *) yahooAPIWeatherWithWOEID:(NSString *)woeid unit:(YAHOO_WEATHER_UNIT)unit{
    NSString *unitString = @"c";
    if (unit && unit == YAHOO_WEATHER_UNIT_FAHRENHEIT) {
        unitString = @"f";
    }
    
    SBJsonParser *parser = [SBJsonParser new];
    NSString *urlString = [NSString stringWithFormat:YAHOO_WEATHER_SERVER, woeid, unitString];
    NSData *data = [QuickHttpRequest httpRequestGETWithURL:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    return [parser objectWithData:data];
}

#pragma mark WOEID
+ (NSMutableDictionary *) yahooAPIWOEIDWithLatitude:(double)latitude Longitude:(double)longitude{
    SBJsonParser *parser = [SBJsonParser new];
    NSString *urlString = [NSString stringWithFormat:YAHOO_WOEID_SERVER_LOCATION, latitude, longitude];
    NSData *data = [QuickHttpRequest httpRequestGETWithURL:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    return [parser objectWithData:data];
}

+ (NSMutableDictionary *) yahooAPIWOEIDWithAddress:(NSString *)address{
    SBJsonParser *parser = [SBJsonParser new];
    NSString *urlString = [NSString stringWithFormat:YAHOO_WOEID_SERVER_ADDRESS, address];
    NSData *data = [QuickHttpRequest httpRequestGETWithURL:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    return [parser objectWithData:data];
}

@end
