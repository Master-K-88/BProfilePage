//
//  BlinqPayFirestoreCollection.swift
//  blinqpost
//
//  Created by Oko-osi Korede on 11/11/2022.
//

import Foundation
enum BlinqpayFirestoreCollections {
    case users
    case posts
    
    var identifier: String {
        switch self {
        case .users:
            return "users"
        case .posts:
            return "post"
        }
        
    }
}
