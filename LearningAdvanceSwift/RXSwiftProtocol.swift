//
//  RXSwiftProtocol.swift
//  LearningAdvanceSwift
//
//  Created by Erin Luu on 2017-04-24.
//  Copyright © 2017 Erin Luu. All rights reserved.
//

import UIKit

protocol RXSwiftProtocol {}

extension RXSwiftProtocol where Self: UIViewController {
    func exampleOf(description: String, action: (Void) -> Void) {
        print("\n ----- Example of: \(description)-----")
        action()
    }
}
