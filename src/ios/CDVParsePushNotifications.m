/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

#import "CDVParsePushNotifications.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"

@implementation CDVParsePushNotifications

/**
 * Get number of notifications badge
 *
 * @param  {CDVInvokedUrlCommand*}  command
 */
- (void)getNumberOfNotifications:(CDVInvokedUrlCommand*)command{

	[self.commandDelegate runInBackground:^{

		PFInstallation *parseInstallation = [PFInstallation currentInstallation];

		//-----------------------------------------
		// Return badge number
		//-----------------------------------------
		CDVPluginResult* numberOfNotifs = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsInt:parseInstallation.badge];
		[self.commandDelegate sendPluginResult:numberOfNotifs callbackId:command.callbackId];
	}];
}

/**
 * Clear notification badge
 *
 * @param  {CDVInvokedUrlCommand*}  command
 */
- (void)clearNotifications:(CDVInvokedUrlCommand*)command{

	[self.commandDelegate runInBackground:^{

		//-----------------------------------------
		// Set badge to 0
		//-----------------------------------------
		PFInstallation *currentInstallation = [PFInstallation currentInstallation];
		if (currentInstallation.badge != 0) {
			currentInstallation.badge = 0;
			[currentInstallation saveEventually];
		}

		//-----------------------------------------
		// Return
		//-----------------------------------------
		CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Notification badge cleared"];
		[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
	}];
}

/**
 * When launching the app from a push notif
 * get the launch notification payload
 *
 * @param  {CDVInvokedUrlCommand*}  command
 */
- (void)getLaunchNotificationData:(CDVInvokedUrlCommand*)command{

	[self.commandDelegate runInBackground:^{
        
		AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];

		//-----------------------------------------
		// Return notification data from delegate
		//-----------------------------------------
		CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:myDelegate.launchNotifData];
		[self.commandDelegate sendPluginResult:result callbackId:command.callbackId];

	}];
}

/**
 * Subscribe to a push channel
 *
 * @param  {CDVInvokedUrlCommand*}  command
 */
- (void)subscribeToChannel:(CDVInvokedUrlCommand*)command{

	[self.commandDelegate runInBackground:^{

		NSArray* arguments = command.arguments;

		//-----------------------------------------
		// Add channel to the subsribtions
		//-----------------------------------------
		PFInstallation *currentInstallation = [PFInstallation currentInstallation];
		[currentInstallation addUniqueObject:[arguments objectAtIndex:0] forKey:@"channels"];
		[currentInstallation saveInBackground];

		//-----------------------------------------
		// Return success
		//-----------------------------------------
		CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:true];
		[self.commandDelegate sendPluginResult:result callbackId:command.callbackId];

	}];
}

/**
 * Unsubscribe from a push channel
 *
 * @param  {CDVInvokedUrlCommand*}  command
 */
- (void)unsubscribeFromChannel:(CDVInvokedUrlCommand*)command{

	[self.commandDelegate runInBackground:^{

		NSArray* arguments = command.arguments;

		//-----------------------------------------
		// Remove the channel from subscriptions
		//-----------------------------------------
		PFInstallation *currentInstallation = [PFInstallation currentInstallation];
		[currentInstallation removeObject:[arguments objectAtIndex:0] forKey:@"channels"];
		[currentInstallation saveInBackground];

		//-----------------------------------------
		// Return success
		//-----------------------------------------
		CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:true];
		[self.commandDelegate sendPluginResult:result callbackId:command.callbackId];

	}];
}

/**
 * Get subscribed channels
 *
 * @param  {CDVInvokedUrlCommand*}  command
 */
- (void)getSubscribedChannels:(CDVInvokedUrlCommand*)command{

	[self.commandDelegate runInBackground:^{

		//-----------------------------------------
		// Get subscribed channels
		//-----------------------------------------
		NSArray *subscribedChannels = [PFInstallation currentInstallation].channels;

		//-----------------------------------------
		// Return
		//-----------------------------------------
		CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray:subscribedChannels];
		[self.commandDelegate sendPluginResult:result callbackId:command.callbackId];

	}];
}

/**
 * Subtract from the current notifications
 * badge number
 *
 * @param  {CDVInvokedUrlCommand*}  command
 */
- (void)deductFromActiveNotificationsBadge:(CDVInvokedUrlCommand*)command{

	[self.commandDelegate runInBackground:^{

		NSArray* arguments = command.arguments;
		PFInstallation *currentInstallation = [PFInstallation currentInstallation];

		//-----------------------------------------
		// Calculate new badge value
		//-----------------------------------------
		NSInteger newBadge = currentInstallation.badge - [[arguments objectAtIndex:0] integerValue];

		//-----------------------------------------
		// Set as badge and return
		//-----------------------------------------
		currentInstallation.badge = newBadge;
		[currentInstallation saveEventually];

	}];
}

@end