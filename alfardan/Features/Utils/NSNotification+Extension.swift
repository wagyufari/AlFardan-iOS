//
//  NSNotification+Extension.swift
//  Performance
//
//

import Foundation

enum NotificationKeyCases: String {
    case AccessToken
}

extension Notification{
    
    static func send(_ key: NotificationKeyCases, object: Any? = nil){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: key.rawValue), object: object)
    }
    
    static func observe(_ key: NotificationKeyCases, handler: @escaping (Any?)->Void) -> NSObjectProtocol {
        return NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: key.rawValue), object: nil, queue: nil) { Notification in
            handler(Notification.object)
        }
    }
    
}

extension NSObjectProtocol {
    func disposed(by: inout [NSObjectProtocol]) {
        by.append(self)
    }
}

extension Array where Element: NSObjectProtocol {
    func dispose() {
        for element in self {
            if let observer = element as? NSObjectProtocol {
                NotificationCenter.default.removeObserver(observer)
            }
        }
    }
}
