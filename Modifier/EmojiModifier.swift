//
//  EmojiModifier.swift
//  PursCreate
//
//  Created by Joshua Brunhuber on 21.07.18.
//  Copyright © 2018 Joshua Brunhuber. All rights reserved.
//

import Willow

struct EmojiModifier: LogModifier {
    
    let name: String
    
    /**
     Brings little fun with emojis in debugging.
     Takes message and puts a emoji depending on the logLevel at the start of the line.
     
     - parameter message: The message to log.
     - parameter logLevel: The severity of the message.
     - returns: The modified log message.
     */
    func modifyMessage(_ message: String, with logLevel: LogLevel) -> String {
        
        switch logLevel {
        case .debug:
            return "🔬🔬🔬 [\(name)] => \(message)"
        case .info:
            return "💡💡💡 [\(name)] => \(message)"
        case .event:
            return "🔵🔵🔵 [\(name)] => \(message)"
        case .warn:
            return "⚠️⚠️⚠️ [\(name)] => \(message)"
        case .error:
            return "🚨💣💥 [\(name)] => \(message)"
        default:
            return "[\(name)] => \(message)"
        }
    }
}
