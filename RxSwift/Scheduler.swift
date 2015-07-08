//
//  Scheduler.swift
//  RxSwift
//
//  Created by Shahzad Bhatti on 7/6/15.
//  Copyright (c) 2015 PlexObject Solutions, Inc. All rights reserved.
//
//
// This interface defines method to schedule callback function that is invoked
// upon each tick. It also defines a number of factory methods for creating
// different types of Schedulers.
import Foundation

public protocol Scheduler : Disposable {
    // This method registers user-defined function that is invoked by scheduler
    func scheduleTask<T>(consumer: (T) -> Void , arg : T) throws
}

enum SchedulerError: ErrorType {
    case AlreadyDisposedError
}

class BaseScheduler : Scheduler {
    var disposed: Bool = false
    func dispose() {
        disposed = true
    }
    func scheduleTask<T>(consumer: T -> Void , arg : T) throws {
        if disposed {
            throw SchedulerError.AlreadyDisposedError
        }
        doScheduleTask(consumer, arg: arg)
    }
    //
    private func doScheduleTask<T>(consumer: (T) -> Void , arg : T) {
    }
}

class BackgroundScheduler : BaseScheduler {
    override func doScheduleTask<T>(consumer: (T) -> Void , arg : T) {
        dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0)) {
            consumer(arg)
        }
    }
}

class TimerScheduler : BaseScheduler {
    var queue: dispatch_queue_t
    let interval: dispatch_time_t
    let repeated: Bool
    
    init(secs:Double, repeated: Bool) {
        self.queue = dispatch_queue_create("com.plexobject.TimerScheduler", nil)
        self.interval = dispatch_time(DISPATCH_TIME_NOW, Int64(secs * Double(NSEC_PER_SEC)))
        self.repeated = repeated
    }
    
    override func doScheduleTask<T>(consumer: (T) -> Void , arg : T) {
        dispatch_after(interval, queue, {[unowned self] in
            if !self.disposed {
                consumer(arg)
                if self.repeated {
                    self.doScheduleTask(consumer, arg: arg)
                }
            }
        });
    }
}


class ImmediateScheduler : BaseScheduler {
    override func doScheduleTask<T>(consumer: (T) -> Void , arg : T) {
        consumer(arg)
    }
}


extension Scheduler {
    static func newBackgroundScheduler() -> Scheduler {
        return BackgroundScheduler()
    }
    static func newTimerScheduler(secs:Double, repeated: Bool) -> Scheduler {
        return TimerScheduler(secs: secs, repeated: repeated)
    }
    static func newImmediateScheduler() -> Scheduler {
        return ImmediateScheduler()
    }
}

