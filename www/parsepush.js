cordova.define("ca.valler.phonegap.ParsePushNotifications", function(require, exports, module) {/*
	 *
	 * Licensed to the Apache Software Foundation (ASF) under one
	 * or more contributor license agreements.  See the NOTICE file
	 * distributed with this work for additional information
	 * regarding copyright ownership.  The ASF licenses this file
	 * to you under the Apache License, Version 2.0 (the
	 * "License"); you may not use this file except in compliance
	 * with the License.  You may obtain a copy of the License at
	 *
	 *   http://www.apache.org/licenses/LICENSE-2.0
	 *
	 * Unless required by applicable law or agreed to in writing,
	 * software distributed under the License is distributed on an
	 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
	 * KIND, either express or implied.  See the License for the
	 * specific language governing permissions and limitations
	 * under the License.
	 *
	*/

	var exec = require('cordova/exec');

	module.exports = {

		//-----------------------------------------
		// Methods for badge interactions
		//-----------------------------------------
		"badge": {

			/**
			 * Get the current number on the badge
			 *
			 * @param  {Callback}  successCallback
			 */
			count: function(successCallback){

				exec(successCallback, null, "ParsePushNotifications", "getNumberOfNotifications", []);
			},

			/**
			 * Clear notification badge
			 *
			 * @param  {Callback}  successCallback
			 */
			clear: function(successCallback){

				exec(successCallback, null, "ParsePushNotifications", "clearNotifications", []);
			},

			/**
			 * Deduct an amount from the badge
			 *
			 * @param  {Callback}  successCallback
			 * @param  {Number}    amount           Number of notifications to subtract
			 */
			deduct: function(successCallback, deductAmount){

				exec(successCallback, null, "ParsePushNotifications", "deductFromActiveNotificationsBadge", [deductAmount]);
			}
		},

		//-----------------------------------------
		// Methods for notification channels
		//-----------------------------------------
		"channels": {

			/**
			 * Subscribe to a push channel
			 *
			 * @param  {String}    channelName 	Channel to subscribe to
			 * @param  {Callback}  successCallback
			 */
			subscribe: function(successCallback, channelName){

				exec(successCallback, null, "ParsePushNotifications", "subscribeToChannel", [channelName]);
			},

			/**
			 * Unsubscribe from a push channel
			 *
			 * @param  {String}    channelName 	Channel to unsubscribe from
			 * @param  {Callback}  successCallback
			 */
			unsubscribe: function(successCallback, channelName){

				exec(successCallback, null, "ParsePushNotifications", "unsubscribeFromChannel", [channelName]);
			},

			/**
			 * Get subscribed channels
			 *
			 * @param  {Callback}  successCallback
			 */
			list: function(successCallback){

				exec(successCallback, null, "ParsePushNotifications", "getSubscribedChannels", []);
			}
		},

		/**
		 * Get launch data if app is launched from a notification
		 *
		 * @param  {Callback}  successCallback
		 */
		launchData: function(successCallback){

			exec(successCallback, null, "ParsePushNotifications", "getLaunchNotificationData", []);
		}
	};
});