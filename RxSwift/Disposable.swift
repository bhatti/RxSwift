//
//  Disposable.swift
//  RxSwift
//
//  Created by Shahzad Bhatti on 7/6/15.
//  Copyright (c) 2015 PlexObject Solutions, Inc. All rights reserved.
//

// This is general purpose interface for cleaning up
public protocol Disposable {
    // This method is called to dispose the object for clean up
    mutating func dispose()
}