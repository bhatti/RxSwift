//
//  Cancelable.swift
//  RxSwift
//
//  Created by Shahzad Bhatti on 7/6/15.
//  Copyright (c) 2015 PlexObject Solutions, Inc. All rights reserved.
//

// This interface is used to add behavior for cancellation
public protocol Cancelable {
    // Cancel this operation
    func cancel()
    
    // Is operation canceled
    func isCanceled() -> Bool
}