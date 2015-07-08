//
//  ObservableDelegate.swift
//  RxSwift
//
//  Created by Shahzad Bhatti on 7/7/15.
//  Copyright © 2015 PlexObject Solutions, Inc. All rights reserved.
//

import Foundation

struct ObservableDelegate<O : Observable, V : Observer where V.T == O.T> {
    var delegate: V -> Void
    
    init(delegate: V -> Void) {
        self.delegate = delegate
        let observer : V = ObserverImpl(onNext: {(t:V.T) -> () in }, onError: {(e:NSException) in }, onCompletion: {})
        delegate(observer)
    }
    
    // This method counts number of elements in stream and creates another
    // stream with that value that is consumed by the subscriber
    func count() -> O? {
        return nil
    }
    
    // This method removes duplicates from internal stream
    func distinct() -> O? {
        return nil
    }
    
    // This method filters items in internal stream based on given predicate
    func filter(predicate : () -> Bool) -> O? {
        return nil
    }
    
    // This method merges internal stream with stream of another Observable
    func zip<P : Observable, R: Observable where R.T == (O, P.T)>(other : P) -> R? {
        return nil
        //return R(value: (self.value, other.value))
    }
    
    // This method transforms internal streams using given mapper function
    func map<Q : Observable>(function : O.T -> Q.T) -> Q? {
        return nil
    }
    
    // This method transforms internal streams using given mapper function and
    // creates a single collection from multiple collections
    func flatMap<Q : Observable>(function : O.T -> Q.T) -> Q? {
        return nil
    }
    
    // This method limits number of elments in internal stream that would be
    // limit to the subscriber
    func limit(maxSize: UInt) -> O? {
        return nil
    }
    
    // This method limits number of elments in internal stream that would be
    // limit to the subscriber
    func skip(maxSize: UInt) -> O? {
        return nil
    }
    
    // This method sorts internal straem
    func sorted() -> O? {
        return nil
    }
    
    // This method sorts internal stream using given comparator
    func sorted(comparator : (O, O) -> Bool) -> O? {
        return nil
    }
    
    // This method changes scheduler for this Observable
    func subscribeOn(scheduler : Scheduler) -> O? {
        return nil
    }
    
    // This method merges internal stream with stream of another Observable
    func merge(other : O) -> O? {
        return nil
    }
    
    // This method merges internal stream with stream of another Observable
    //func zip<O : Observable>(other : O) -> Observable<(T,O.U)>
    
    // Converts internal stream into parallel stream (underlying stream must
    // support parallel processing)
    func parallel() -> O? {
        return nil
    }
    
    // This method subscribes given consumer and starts pushing the data. By
    // default, data is pushed asynchronously using background scheduler. Note:
    // This method doesn't take onCompletion function so user will not be
    // notified when all data is processed, which is not a problems for most
    // cases.
    func subscribe(onNext: (O.T) -> Void, onError : (NSException) -> Void) -> Subscription {
        return subscribe(onNext, onError: onError, onCompletion:{})
    }
    
    // This method subscribes given consumer and starts pushing the data. By
    // default, data is pushed asynchronously using background scheduler.
    func subscribe(onNext: (O.T) -> Void, onError : (NSException) -> Void,
        onCompletion : () -> Void?) -> Subscription {
            let observer = ObserverImpl(onNext: onNext, onError: onError, onCompletion: onCompletion)
            //
            
            let subscription = SubscriptionObserverImpl<O.T>(onNext: onNext, onError: onError, onCompletion: onCompletion, cancelable: nil)
            //
            delegate(observer)
            return subscription
    }    
    
    // This returns internal stream as a list
    func toList() -> [O.T]? {
        return nil
    }
}