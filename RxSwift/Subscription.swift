//
//  Subscription.swift
//  RxSwift
//
//  Created by Shahzad Bhatti on 7/6/15.
//  Copyright (c) 2015 PlexObject Solutions, Inc. All rights reserved.
//

// This interface is used to unsubscribe from Observable and to check if subscription is still valid
public protocol Subscription : Disposable {
    // This method returns true if user is still subscribed and false otherwise
    func isSubscribed() -> Bool
}
