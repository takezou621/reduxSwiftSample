//
//  TestReducer.swift
//  reduxSwiftSample
//
//  Created by Takeshi Kawai on 2015/12/06.
//  Copyright © 2015年 Takeshi Kawai. All rights reserved.
//

import Foundation
import SwiftRedux

func applicationReducer(state: State? = nil, action:Action)-> State{
    let appState = state as! AppState?
    
    return AppState(
        counter: counterReducer(appState?.counter, action: action),
        countries: countryReducer(appState?.countries, action: action)
    )
    
}

func counterReducer(previousState: Int?,action: Action) -> Int {
    let defaultValue = 0
    var state = previousState ?? defaultValue
    
    switch action {
    case let action as IncrementAction:
        state = state + action.rawPayload
        return state
    default:
        return state
    }
}

func countryReducer(previousState: [String]?, action:Action) -> [String] {
    let defaultValue = [String]()
    var state = previousState ?? defaultValue
    
    switch action {
    case let action as AddRowAction:
       state.append(action.rawPayload.name)
        return state
    default:
        return state
    }
}
