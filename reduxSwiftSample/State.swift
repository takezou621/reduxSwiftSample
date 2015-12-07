//
//  State.swift
//  reduxSwiftSample
//
//  Created by KawaiTakeshi on 2015/12/07.
//  Copyright © 2015年 Takeshi Kawai. All rights reserved.
//

import Foundation
import SwiftRedux

struct AppState: State {
    let counter: Int!
    let countries:[String]!
}