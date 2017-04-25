//
//  NotificationCenterProtocol.swift
//  LearningAdvanceSwift
//
//  Created by Erin Luu on 2017-04-24.
//  Copyright © 2017 Erin Luu. All rights reserved.
//

import UIKit
import UserNotifications

protocol NotificationCenterProtocol {}

extension NotificationCenterProtocol where Self: AppDelegate {
    var center: UNUserNotificationCenter { return UNUserNotificationCenter.current() }
    
    //Requesting authorization to display notifications
    func requestNotificationAuthorization() {
        center.requestAuthorization(options: [.alert, .badge, .sound]){ success, error in
            if error == nil && success == true {
                print("Request Authorization Success")
                self.configueLocalNotifications()
            }else{
                print("Request Authorization Denied")
            }
        }
    }
    
    //User can change the authorized interaction types at any time. Check the settings on app startup.
    func checkNotificationSettings() {
        center.getNotificationSettings { settings in
            //do something with settings
        }
    }
    
    //Notification category and custom action
    func notificationCategory() {
        //Create category
        let generalCategory = UNNotificationCategory(identifier: "GENERAL",
                                                     actions: [],
                                                     intentIdentifiers: [],
                                                     options: .customDismissAction)
        //Create custom actions
        let snoozeAction = UNNotificationAction(identifier: "SNOOZE_ACTION",
                                                title: "Snooze",
                                                options: UNNotificationActionOptions(rawValue: 0))
        let stopAction = UNNotificationAction(identifier: "STOP_ACTION",
                                              title: "Stop",
                                              options: .foreground)
        
        //Add action to category
        let expiredCategory = UNNotificationCategory(identifier: "TIMER_EXPIRED",
                                                     actions: [snoozeAction, stopAction],
                                                     intentIdentifiers: [],
                                                     options: UNNotificationCategoryOptions(rawValue: 0))
        
        //Add category to notificationCenter
        center.setNotificationCategories([generalCategory, expiredCategory])
        
    }
    
    func configueLocalNotifications() {
        //Setup content
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = String.localizedUserNotificationString(forKey: "Wake up!", arguments: nil)
        notificationContent.body = String.localizedUserNotificationString(forKey: "Rise and shine! It's morning time!", arguments: nil)
        
        let timeIntervalTrigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(10), repeats: false)
        
        //Create custom actions
        let snoozeAction = UNNotificationAction(identifier: "SNOOZE_ACTION",
                                                title: "Snooze",
                                                options: UNNotificationActionOptions(rawValue: 0))
        let stopAction = UNNotificationAction(identifier: "STOP_ACTION",
                                              title: "Stop",
                                              options: .foreground)
        
        //Add action to category
        let expiredCategory = UNNotificationCategory(identifier: "TIMER_EXPIRED",
                                                     actions: [snoozeAction, stopAction],
                                                     intentIdentifiers: [],
                                                     options: UNNotificationCategoryOptions(rawValue: 0))
        center.setNotificationCategories([expiredCategory])
        notificationContent.categoryIdentifier = "TIMER_EXPIRED"

        let request = UNNotificationRequest(identifier: "MorningAlarm", content: notificationContent, trigger: timeIntervalTrigger)
        
        center.add(request) { error in
            if let theError = error {
                print(theError.localizedDescription)
            }
        }
    }
}
