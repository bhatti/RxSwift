//
//  SubscriptionObserver.swift
//  RxSwift
//
//  Created by Shahzad Bhatti on 7/6/15.
//  Copyright (c) 2015 PlexObject Solutions, Inc. All rights reserved.
//

// This is used internally to keep track of subscription and to notify subscriber
import Foundation

protocol SubscriptionObserver : Subscription, Observer {
}


struct SubscriptionObserverImpl<T> : SubscriptionObserver {
    let _onNext : T -> ()
    let _onError : NSException -> ()
    let _onCompletion : () -> ()?
    let _cancelable : Cancelable?
    var _subscribed : Bool = true
    //
    init(onNext: T->(), onError:NSException -> (), onCompletion: () -> ()?, cancelable : Cancelable?) {
        _onNext = onNext
        _onError = onError
        _onCompletion = onCompletion
        _cancelable = cancelable
    }
    
    mutating func dispose() {
        _subscribed = false
        if let cancelable = _cancelable {
            cancelable.cancel()
        }
    }
    func isSubscribed() -> Bool {
        return _subscribed
    }
    
    func onNext(arg: T) {
        if _subscribed {
            _onNext(arg)
        }
    }
    func onError(error: NSException) {
        if _subscribed {
            _onError(error)
        }
    }
    func onCompleted() {
        if _subscribed {
            _onCompletion()
        }
    }
}
