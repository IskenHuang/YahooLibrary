//
//  AppDelegate.m
//  YahooLibrary
//
//  Created by Isken Huang on 12/13/12.
//  Copyright (c) 2012 Isken Huang. All rights reserved.
//

#import "AppDelegate.h"

#import "MasterViewController.h"

#import "TouchXML.h"

#import "SBJson.h"

#import "YahooAPI.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSInteger t1 = [[NSDate date] timeIntervalSince1970];
    [self grabRSSFeed:@"http://weather.yahooapis.com/forecastrss?w=2502265&u=c"];
    NSInteger t2 = [[NSDate date] timeIntervalSince1970];
    NSLog(@"sec: %d", t2-t1);
    
    //sbjson
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSURL *_connection = [NSURL URLWithString:@"http://query.yahooapis.com/v1/public/yql?q=select%20item%20from%20weather.forecast%20where%20woeid%3D12703518%20AND%20u%3D%22c%22&format=json"];
    [request setURL:_connection]; 
    [request setHTTPMethod:@"GET"];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    SBJsonParser *jsonParser = [SBJsonParser new];
    NSLog(@"JSON => %@", [jsonParser objectWithString:string]);
    
    //yahoo
    NSLog(@"%@", [YahooAPI yahooAPIWeatherWithWOEID:@"12703518"]);
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.

//    MasterViewController *masterViewController = [[MasterViewController alloc] initWithNibName:@"MasterViewController" bundle:nil];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:[UIViewController new]];
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark touchxml
// grabRSSFeed function that takes a string (blogAddress) as a parameter and
// fills the global blogEntries with the entries
-(void) grabRSSFeed:(NSString *)blogAddress {
    
    // Initialize the blogEntries MutableArray that we declared in the header
    NSMutableArray *blogEntries = [[NSMutableArray alloc] init];
    
    // Convert the supplied URL string into a usable URL object
    NSURL *url = [NSURL URLWithString: blogAddress];
    
    // Create a new rssParser object based on the TouchXML "CXMLDocument" class, this is the
    // object that actually grabs and processes the RSS data
    CXMLDocument *rssParser = [[CXMLDocument alloc] initWithContentsOfURL:url options:0 error:nil];
    
    // Create a new Array object to be used with the looping of the results from the rssParser
    NSArray *resultNodes = NULL;
    
    // Set the resultNodes Array to contain an object for every instance of an  node in our RSS feed
    resultNodes = [rssParser nodesForXPath:@"//channel" error:nil];
    
    // Loop through the resultNodes to access each items actual data
    for (CXMLElement *resultElement in resultNodes) {
        
        // Create a temporary MutableDictionary to store the items fields in, which will eventually end up in blogEntries
        NSMutableDictionary *blogItem = [[NSMutableDictionary alloc] init];
        
        // Create a counter variable as type "int"
        int counter;
        
        // Loop through the children of the current  node
        for(counter = 0; counter < [resultElement childCount]; counter++) {
            
            // Add each field to the blogItem Dictionary with the node name as key and node value as the value
            [blogItem setObject:[[resultElement childAtIndex:counter] stringValue] forKey:[[resultElement childAtIndex:counter] name]];
        }
        
        // Add the blogItem to the global blogEntries Array so that the view can access it.
        [blogEntries addObject:[blogItem copy]];
    }
    
    NSLog(@">> %@", blogEntries);
}

@end
