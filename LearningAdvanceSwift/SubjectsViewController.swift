//
//  SubjectsViewController.swift
//  LearningAdvanceSwift
//
//  Created by Erin Luu on 2017-04-24.
//  Copyright © 2017 Erin Luu. All rights reserved.
//

import UIKit
import RxSwift

class SubjectsViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    public func exampleOf(description: String, action: (Void) -> Void) {
        print("\n ----- Example of: \(description)-----")
        action()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enum RXSwiftError: Error {
            case test
        }
        
        //Publish only get everything after the subscription
        exampleOf(description: "PublishSubject"){
            let subject = PublishSubject<String>()
            subject.subscribe{
                print($0)
                }.disposed(by: disposeBag)
            
            subject.onNext("HELLO")
            //subject.onError(RXSwiftError.test)
            //subject.onCompleted()
            subject.onNext("WORLD")
            
            let newSubscription = subject.subscribe(onNext:{
                print("New Subscription:" + $0)
            })
            
            subject.onNext("ERIN")
            newSubscription.dispose()
            subject.onNext("Anybody still there?")
        }
        
        //Behaviour gets the latest element in the subscription
        exampleOf(description: "BehaviourSubject"){
            let subject = BehaviorSubject.init(value: "A")
            let firstSubscription = subject.subscribe{
                print($0)
            }
            
            subject.onNext("B")
            
            let secondSubscription = subject.subscribe {
                print($0)
            }
            
            firstSubscription.dispose()
            secondSubscription.dispose()
        }
        
        //Replay gets everything
        exampleOf(description: "Replay"){
            let subject = ReplaySubject<Int>.create(bufferSize: 3)
            subject.onNext(1)
            subject.onNext(2)
            subject.onNext(3)
            subject.onNext(4)
            
            subject.subscribe{
                print($0)
                }
                .addDisposableTo(disposeBag)
            
            subject.onNext(5)
        }
        
        //Variable is a wrapper around a BehaviourSubject. Replay the lastest element.
        exampleOf(description: "Variables"){
            let variable = Variable("A")
            
            variable.asObservable().subscribe{
                print($0)
            }.disposed(by: disposeBag)
        }
    }
}
