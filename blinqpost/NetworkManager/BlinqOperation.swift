//
//  BlinqOperation.swift
//  blinqpost
//
//  Created by Oko-osi Korede on 11/11/2022.
//

import Foundation
enum Operations {
    case create(data: Parameter)
    case read
    case update(data: Parameter)
    case delete
    case query
}
