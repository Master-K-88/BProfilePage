//
//  MediaProtocol.swift
//  blinqpost
//
//  Created by Oko-osi Korede on 11/11/2022.
//

import Foundation
protocol MediaDataProtocol {
    var description: String { get set}
    var id: String {get set}
    var link: String { get set}
    var thumbnail: String { get set}
    var timestamp: Double { get set}
    var username: String { get set}
    var video: Bool { get set}
}
