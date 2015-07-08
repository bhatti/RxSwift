//
//  Observable.swift
//  RxSwift
//
//  Created by Shahzad Bhatti on 7/6/15.
//  Copyright (c) 2015 PlexObject Solutions, Inc. All rights reserved.
//

// The Observable interface defines common methods of reactive extensions, which
// are implemented in separate class. This is main interface that user interacts
// with when creating Observable objects.

import Foundation

public protocol Observable {
    typealias T
    
    // This method counts number of elements in stream and creates another
    // stream with that value that is consumed by the subscriber
    func count() -> Self?

    // This method removes duplicates from internal stream
    func distinct() -> Self?

    // This method filters items in internal stream based on given predicate
    func filter<O : Observable>(predicate : () -> Bool) -> O?

    // This method transforms internal streams using given mapper function
    func map<O : Observable>(function : T -> O.T) -> O?

    // This method transforms internal streams using given mapper function and
    // creates a single collection from multiple collections
    func flatMap<O : Observable>(function : T -> O.T) -> O?
    
    // This method limits number of elments in internal stream that would be
    // limit to the subscriber
    func limit(maxSize: UInt) -> Self?
    
    // This method limits number of elments in internal stream that would be
    // limit to the subscriber
    func skip(maxSize: UInt) -> Self?
    
    // This method sorts internal straem
    func sorted() -> Self?
    
    // This method sorts internal stream using given comparator
    func sorted(comparator : (T, T) -> Bool) -> Self?
    
    // This method changes scheduler for this Observable
    func subscribeOn(scheduler : Scheduler) -> Self?
    
    // This method merges internal stream with stream of another Observable
    func merge(other : Self) -> Self?
    
    // This method merges internal stream with stream of another Observable
    func zip<O : Observable, R: Observable where R.T == (T, O.T)>(other : O) -> R?
    
    // Converts internal stream into parallel 
    func parallel() -> Self?
    
    // This method subscribes given consumer and starts pushing the data. By
    // default, data is pushed asynchronously using background scheduler. Note:
    // This method doesn't take onCompletion function so user will not be
    // notified when all data is processed, which is not a problems for most
    // cases.
    func subscribe(onNext: (T) -> Void, onError : (NSException) -> Void) -> Subscription

    
    // This method subscribes given consumer and starts pushing the data. By
    // default, data is pushed asynchronously using background scheduler.
    func subscribe(onNext: (T) -> Void, onError : (NSException) -> Void,
        onCompletion : () -> Void?) -> Subscription
    

    // This returns internal stream as a list
    func toList() -> [T]?
}


extension Observable {
    // This method allows user to create Observable by passing a consumer
    // function for notifying subscribers.
    public static func create<O : Observable>(consumer : O.T -> Void) -> O? {
        return nil
        //return ObservableDelegate<T>(consumer)
    }

    // This method creates Observable from a array of objects
    public static func create<O : Observable>(values : T ...) -> O? {
        return nil
        //return ObservableDelegate<T>(consumer)
    }

    // This method creates Observable from sequence type
    public static func create<S: SequenceType> (iterator : S) -> Self? {
        return nil
        //return ObservableDelegate<T>(consumer)
    }

    
    // This method creates Obsevable from generator
    public static func create<G: GeneratorType>(generator : G) -> Self? {
        return nil
        //return ObservableDelegate<T>(consumer)
    }

    
    // This method creates Obsevable from a collection
    public static func empty() -> Self? {
        return nil
        //return ObservableDelegate<T>(consumer)
    }

    
    // This method creates an Observable with a single object. If that object is
    // a collection, then entire collection is treated as a single entity.
    public static func just(arg : T) -> Self? {
        return nil
        //return Observable.from(obj);
    }

    
    // This method creates an Observable that would call onError upon
    // subscription
    public static func throwing(error : NSException) -> Self? {
        return nil
        // return new ObservableImpl<T>(Stream.<T> of(), error);
    }

    
    // Creates range of numbers starting at from until it reaches to exclusively
    public static func range(from: Int, to: Int) -> Self? {
        return nil
        //return new ObservableImpl<Integer>(IntStream.range(from, to).boxed(),null);
    }

    // Creates infinite natural numbers starting from given number
    public static func integers(from: Int) -> Self? {
        return nil
        //return new ObservableImpl<Integer>( new NatsSpliterator(from).getStream(), null);
    }

    
    // This method ignores subscription and doesn't call any method
    public static func never() -> Self? {
        return nil
        //return new ObservableNever<T>();
    }
}
