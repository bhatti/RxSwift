//
//  Observer.swift
//  RxSwift
//
//  Created by Shahzad Bhatti on 7/6/15.
//  Copyright (c) 2015 PlexObject Solutions, Inc. All rights reserved.
//

import Foundation

// This struct is internally used for notifying subscriber
protocol Observer {
    typealias T
    func onNext(arg: T)
    func onError(error: NSException)
    func onCompleted()
}

struct ObserverImpl<T> : Observer {
    let _onNext : T -> ()
    let _onError : NSException -> ()
    let _onCompletion : () -> Void?
    //
    init(onNext: T->(), onError:NSException -> Void, onCompletion: () -> Void?) {
        _onNext = onNext
        _onError = onError
        _onCompletion = onCompletion
    }
    
    func onNext(arg: T) {
        _onNext(arg)
    }
    
    func onError(error: NSException) {
        _onError(error)
    }
    
    func onCompleted() {
        _onCompletion()
    }
}