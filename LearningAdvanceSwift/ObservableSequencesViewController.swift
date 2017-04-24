//
//  ObservableSequencesViewController.swift
//  LearningAdvanceSwift
//
//  Created by Erin Luu on 2017-04-24.
//  Copyright © 2017 Erin Luu. All rights reserved.
//

import UIKit
import RxSwift

class ObservableSequencesViewController: UIViewController {
    
    public func exampleOf(description: String, action: (Void) -> Void) {
        print("\n ----- Example of: \(description)-----")
        action()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exampleOf(description: "just") {
            let observable = Observable.just("Hello")
            _ = observable.subscribe{ (element: Event<String>) in
                print(element)
            }
        }
        
        exampleOf(description: "of"){
            let observable = Observable.of("Hello","How","Are","You?")
            _ = observable.subscribe{
                print($0)
            }
        }
        
        exampleOf(description: "toObservable"){
            let array = [1, 2, 3, 4, 5]
            let disposeBag = DisposeBag()
            
            Observable.from(array)
                .subscribe(onNext:{
                    print($0)
                })
                .disposed(by: disposeBag)
        }
        
        exampleOf(description: "onCompleted"){
            let array = [6, 7, 8, 9, 10]
            let disposeBag = DisposeBag()
            
            Observable.from(array)
                .subscribe(onCompleted:{
                    print($0)
                })
                .disposed(by: disposeBag)
        }
        
        exampleOf(description: "error"){
            enum RXSwiftError: Error {
                case test
            }
            
            Observable<Int>.error(RXSwiftError.test).subscribe{
                print($0)
            }.dispose()
        }
    }
}
