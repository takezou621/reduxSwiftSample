//
//  TestAction.swift
//  reduxSwiftSample
//
//  Created by Takeshi Kawai on 2015/12/06.
//  Copyright © 2015年 Takeshi Kawai. All rights reserved.
//

import Foundation
import SwiftRedux

struct IncrementAction:StandardAction {
    let meta: Any?
    let error: Bool
    let rawPayload: Int
    
    init(payload: Int? = nil, meta: Any? = nil, error: Bool = false) {
        self.rawPayload = payload ?? 1
        self.meta = meta
        self.error = error
    }
}

struct AddRowAction: StandardAction {
    let meta: Any?
    let error: Bool
    let rawPayload: Country
    
    init(payload: Country?, meta: Any? = nil, error:Bool = false) {
        self.rawPayload = payload != nil ? payload! : Country(name: "")
        self.meta = meta
        self.error = error
    }
    
    struct Country{
        var name: String
        
        init(name: String) {
            self.name = name
        }
    }
}