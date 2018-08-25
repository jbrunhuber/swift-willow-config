//
//  LoggingConfiguration.swift
//  PursCreate
//
//  Created by Joshua Brunhuber on 21.07.18.
//  Copyright © 2018 Joshua Brunhuber. All rights reserved.
//

import Willow

var willow_logger: Logger?

struct LoggingConfiguration {
    
    static func configure() {
        
        let name = "Logger"
        
        #if DEBUG
            willow_logger = buildDebugLogger(name: name)
        #else
            willow_logger = buildReleaseLogger(name: name)
        #endif
        
        willow_logger?.enabled = true
    }
    
    /**
     Builds a logger for debug-builds. Prints all log messages to the console.
     Logging will block the main thread.
     
     - parameter name: The name of the logger.
     - returns: The configured logger.
     */
    private static func buildDebugLogger(name: String) -> Logger {
        
        let emojiModifier = EmojiModifier(name: name)
        
        let consoleWriter = ConsoleWriter(modifiers: [emojiModifier])
        
        return Logger(logLevels: [.all], writers: [consoleWriter], executionMethod: .synchronous(lock: NSRecursiveLock()))
    }
    
    /**
     Builds a logger for release-builds. Prints only serve messages.
     Logging will be performed asynchronously to prevent performance problems in production.
     
     - parameter name: The name of the logger.
     - returns: The configured logger.
     */
    private static func buildReleaseLogger(name: String) -> Logger {
        
        let osLogWriter = OSLogWriter(subsystem: "com.joshtastic.purscreate", category: name)
        
        let appLogLevels: LogLevel = [.event, .info, .warn, .error]
        let asynchronousExecution: Logger.ExecutionMethod = .asynchronous(
            queue: DispatchQueue(label: "com.joshtastic.logging", qos: .utility)
        )
        
        return Logger(logLevels: appLogLevels, writers: [osLogWriter], executionMethod: asynchronousExecution)
    }
}
