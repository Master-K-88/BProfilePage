//
//  UserAPI.swift
//  blinqpost
//
//  Created by Oko-osi Korede on 11/11/2022.
//

import Foundation
import FirebaseFirestore

enum UserAPI {
    case createNewUser([String: Any])
    case getUserProfile
    case fetchAllUser // We only have one user so it is the same as getUserProfile
    case storeUserData([String: Any])
    case getPost
    case getVideos
}

extension UserAPI: BlinqpayRequestType {
    
    var operation: Operations {
        switch self {
        case .createNewUser(let params):
            return .create(data: params)
        case .fetchAllUser:
            return .query
        case .getUserProfile:
            return .read
        case .storeUserData(let params):
            return .update(data: params)
        case .getVideos, .getPost:
            return .query
        }
    }
    
    var userID: String {
        return "2tJqjVZWQRczkDqqjzrG"
    }
    
    var baseDocumentReference: DocumentReference? {
        return nil
    }
    
    var documentRefernce: DocumentReference? {
        switch self {
        case .createNewUser(_):
            return collectionReference?.document("\(userID)")
        case .getUserProfile:
            return collectionReference?.document("\(userID)")
        case .fetchAllUser, .getVideos, .getPost:
            return nil
        case .storeUserData(_):
            return collectionReference?.document("\(userID)")
            
        }
        
    }
    
    var collectionReference: CollectionReference? {
        switch self {
        case .getUserProfile, .fetchAllUser, .createNewUser, .storeUserData:
            return Firestore.firestore().collection(BlinqpayFirestoreCollections.users.identifier)
        case .getPost, .getVideos:
            return Firestore.firestore().collection(BlinqpayFirestoreCollections.posts.identifier)
        }
    }
    
    var collectionQuery: Query? {
        switch self {
        case .getPost:
            return collectionReference?.whereField("video", isEqualTo: false)
        case .getVideos:
            return collectionReference?.whereField("video", isEqualTo: true)
        default:
            return collectionReference
        }
   
    }
    
}
