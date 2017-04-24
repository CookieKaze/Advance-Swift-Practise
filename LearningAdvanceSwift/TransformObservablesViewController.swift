//
//  TransformObservablesViewController.swift
//  LearningAdvanceSwift
//
//  Created by Erin Luu on 2017-04-24.
//  Copyright © 2017 Erin Luu. All rights reserved.
//

import UIKit
import RxSwift

class TransformObservablesViewController: UIViewController, RXSwiftProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exampleOf(description: "map"){
            Observable.of(1, 2, 3, 4, 5)
                .map{ return $0 + $0 }
                .subscribe(onNext: { print($0) })
                .dispose()
        }
        
        exampleOf(description: "flatMap and flatMapLatest "){
            let dispostBag = DisposeBag()
            
            struct Player {
                var score: Variable<Int>
            }
            
            let scott = Player.init(score: Variable(80))
            let lori = Player.init(score: Variable(20))
            var player = Variable(scott)
            
            player.asObservable()
                .flatMap{$0.score.asObservable()}
                .subscribe(onNext:{print($0)})
                .addDisposableTo(dispostBag)
            
            player.value.score.value = 100
            scott.score.value = 60
            player.value = lori
            scott.score.value = 100
        }
        
    }
}
