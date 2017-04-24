//
//  AppDelegate.swift
//  LearningAdvanceSwift
//
//  Created by Erin Luu on 2017-04-24.
//  Copyright © 2017 Erin Luu. All rights reserved.
//

import UIKit

protocol URLInjected { }

enum EndPoint : URLInjected {
    case Orders
    case Users
}

struct URLInjector {
    static var urlForEndpoint:(EndPoint)->NSURL = {
        endpoint in
        switch endpoint {
        case .Orders :
            return NSURL(string:"https://myapi.com/orders")!
        case .Users :
            return NSURL(string:"https://myapi.com/users")!
        }
    }
}

//where Self : EndPoint
extension URLInjected {
    var url:NSURL { get { return URLInjector.urlForEndpoint(self as! EndPoint) }}
    var property: String {get{return ""} set{property = newValue}}
}
