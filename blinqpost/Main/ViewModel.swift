//
//  ViewModel.swift
//  blinqpost
//
//  Created by Oko-osi Korede on 11/11/2022.
//

import Foundation
import RxSwift
import RxCocoa
import FirebaseFirestore

class ViewModel {
    
    let userService = UserService()
    
    var collectionData = [MediaDataModel]()
    
    var userProfile = BehaviorSubject(value: UserProfile())
    var mediaData = BehaviorSubject(value: [MediaDataModel]())
    
    var videosData = BehaviorSubject(value: [MediaDataModel]())
    var postsData = BehaviorSubject(value: [MediaDataModel]())
    
    var videos = [MediaDataModel]()
    var posts = [MediaDataModel]()
    
    
    func getUserProfile()  {
        userService.getUserProfile().map { [weak self] (result, error) in
            print("A response came in \(result)")
            if let error = error {
                print("An error \(error) occured")
            } else {
                if let snaps = result as? DocumentSnapshot {
                    do {
                        let user = try snaps.data(as: UserProfile.self)
                        print("I am confirming the user data: \(user)")
                        self?.userProfile.on(.next(user))
                    } catch {
                        print("Error occured: \(error.localizedDescription)")
                    }
                    
                }
            }
            
        }
        .subscribe {
            Disposables.create { }
        }
    }
    
    func getPostData() {
        userService.fetchAllPosts().map { [weak self] (result, error) in
            print("A response came in \(result)")
            if let error = error {
                print("An error \(error) occured")
            } else {
                if let snaps = result as? QuerySnapshot {
                    let snaps = snaps.documents
                    print("\(snaps.count) videos came in")
                    var posts = [MediaDataModel]()
                    for snaps in snaps {
                        do {
                            let post = try snaps.data(as: MediaDataModel.self)
                            print("A video came in \(post)")
                            posts.append(post)
                        } catch {
                            print("Error occured: \(error.localizedDescription)")
                        }
                        
                    }
                    self?.mediaData.on(.next(posts))
                    self?.posts = posts
                    self?.postsData.on(.next(posts))
                }
            }
        }
        .subscribe {
            Disposables.create { }
        }
    }
    
    func getVideoData() {
        userService.fetchAllVideos().map { [weak self] (result, error) in
            print("A response came in \(result)")
            if let error = error {
                print("An error \(error) occured")
            } else {
                if let snaps = result as? QuerySnapshot {
                    let snaps = snaps.documents
                    print("\(snaps.count) videos came in")
                    var videos = [MediaDataModel]()
                    for snaps in snaps {
                        do {
                            let video = try snaps.data(as: MediaDataModel.self)
                            print("A video came in \(video)")
                            videos.append(video)
                        } catch {
                            print("Error occured: \(error.localizedDescription)")
                        }
                        
                    }
                    self?.videos = videos
                    self?.videosData.on(.next(videos))
                }
            }
        }
        .subscribe {
            Disposables.create { }
        }
    }
}
