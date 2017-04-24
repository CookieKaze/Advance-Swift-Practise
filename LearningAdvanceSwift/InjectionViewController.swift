//
//  AppDelegate.swift
//  LearningAdvanceSwift
//
//  Created by Erin Luu on 2017-04-24.
//  Copyright © 2017 Erin Luu. All rights reserved.
//

import UIKit

class InjectionViewController: UIViewController, DeviceInjected  {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let endpoint = EndPoint.Orders
        print(endpoint.url) // prints "https://myapi.com/orders"
    
        let manager = deviceManager
        print(manager.deviceName)
        

    }
}
