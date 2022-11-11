//
//  UserService.swift
//  blinqpost
//
//  Created by Oko-osi Korede on 11/11/2022.
//

import Foundation
import RxSwift

protocol UserServiceProtocol {
    func getUserProfile() -> Single<(Any?, Error?)>
    func fetchAllUsers() -> Single<(Any?, Error?)>
    func storeUserData(data: Parameter) -> Single<(Any?, Error?)>
    func fetchAllPosts() -> Single<(Any?, Error?)>
    func fetchAllVideos() -> Single<(Any?, Error?)>
}

struct UserService: UserServiceProtocol {
    let router = Router<UserAPI>()
    
    func getUserProfile() -> Single<(Any?, Error?)> {
        return router.request(.getUserProfile)
    }
    
    func fetchAllUsers() -> Single<(Any?, Error?)> {
        return router.request(.fetchAllUser)
    }
    
    func storeUserData(data: Parameter) -> Single<(Any?, Error?)> {
        return router.request(.storeUserData(data))
    }
    
    func fetchAllPosts() -> Single<(Any?, Error?)> {
        return router.request(.getPost)
    }
    
    func fetchAllVideos() -> Single<(Any?, Error?)> {
        return router.request(.getVideos)
    }
    
}
