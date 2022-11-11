//
//  MediaDataModel.swift
//  blinqpost
//
//  Created by Oko-osi Korede on 11/11/2022.
//

import Foundation
struct MediaDataModel: Codable, MediaDataProtocol {
    var description: String = ""
    
    var id: String = ""
    
    var link: String = ""
    
    var thumbnail: String = ""
    
    var timestamp: Double = 0
    
    var username: String = ""
    
    var video: Bool = false
    
    
}
