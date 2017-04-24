//
//  DeviceManager.swift
//  LearningAdvanceSwift
//
//  Created by Erin Luu on 2017-04-24.
//  Copyright © 2017 Erin Luu. All rights reserved.
//

import UIKit
protocol DeviceInjected { }

extension DeviceInjected {
    var deviceManager: DeviceManager { return DeviceInjector.deviceManager }
}

class DeviceManager: DeviceInjected {
    let deviceName = "HELLO"
}

struct DeviceInjector {
    private static let queue = DispatchQueue(label: String(describing: DeviceInjector.self))
    
    private static var _deviceManager: DeviceManager?
    static var deviceManager: DeviceManager {
        get {
            return _deviceManager ?? {
                queue.sync { if _deviceManager == nil { _deviceManager = DeviceManager() } }
                return _deviceManager!
                }()
        }
        set { queue.sync { _deviceManager = newValue } }
    }
}

