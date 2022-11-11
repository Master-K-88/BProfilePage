//
//  UserProfileModel.swift
//  blinqpost
//
//  Created by Oko-osi Korede on 11/11/2022.
//

import Foundation
struct UserProfile: Identifiable, Codable {
    
    var id: String? = UUID().uuidString
    var name: String = ""
    var username: String = ""
    var photo: String = ""
    var bio: String = ""
    var userId: String = ""
}
