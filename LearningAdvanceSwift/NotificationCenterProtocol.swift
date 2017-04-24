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
    var center: UNUserNotificationCenter { get { return UNUserNotificationCenter.current() } }
    
    //Requesting authorization to display notifications
    func requestNotificationAuthorization() {
        center.requestAuthorization(options: [.alert, .badge, .sound]){ success, error in
            if error == nil && success == true {
                //Do something
            }
        }
    }
    
    //User can change the authorized interaction types at any time. Check the settings on app startup.
    func checkNotificationSettings() {
        center.getNotificationSettings { settings in
            //do seomthing with settings
        }
    }
}
