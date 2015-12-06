//
//  AppStore.swift
//  reduxSwiftSample
//
//  Created by Takeshi Kawai on 2015/12/06.
//  Copyright © 2015年 Takeshi Kawai. All rights reserved.
//

import Foundation
import SwiftRedux

class AppStore {
    static let sharedInstance : TypedStore<AppState> = generateStore()
}

private func generateStore() -> TypedStore<AppState> {
    return createTypedStore()(createStore)(applicationReducer,nil)
}
