//
//  PostController.swift
//  AliensAtHome
//
//  Created by MAC Consultant on 8/12/19.
//  Copyright © 2019 huevo. All rights reserved.
//

import UIKit

class PostController {
    
    var networking: Networking = Networking()
    var posts : [Post] = []
    var cache = NSCache<AnyObject, AnyObject>()
    
    var nextPage: String = ""
    
    var selectedPostIndex = 0
    
    var count: Int {
        get {
            return posts.count
        }
    }
    
    func selectedArticleData() -> (title: String, author: String?)? {
        if selectedPostIndex > posts.count - 1 {
            return nil
        }
        else {
            let data = posts[selectedPostIndex].data
            return (title: data.title, author: data.author)
        }
    }
    
    func getTopPosts(_ completion: @escaping ()->Void) {
        networking.getTopPost(after: nextPage) { postsData in
            self.posts += postsData.children
            if let after = postsData.after {
                self.nextPage = after
            }
            completion()
        }
    }
    /*
    func data(at index: Int) -> PostData {
        return posts[index].data
    }
    */
    func data(at index: Int) -> (title: String, comments: String?, date: String?) {
        let data = posts[index].data
        let title = data.title
        var comments: String?
        if let numComments = data.numComments {
            comments = String.init(format: NSLocalizedString("%d comments",
                                                             comment: ""),
                                   numComments)
        }
        var date: String?
        if let dateCreated = data.createdUTC {
            //date = dateFormatter.timeSince(from: NSDate(timeIntervalSince1970: TimeInterval(dateCreated)))
            
            date = Date(timeIntervalSince1970: TimeInterval(dateCreated)).timeSince
        }
        return (title: title, comments: comments, date: date)
    }
    
    func thumbnailImage(at index: Int, _ completion: @escaping (UIImage?)->Void) {
        let object = posts[index].data
        if let imageUrl = object.thumbnail {
            imageHelper(imageUrl, completion)
        }
    }
    
    func fullImage(at index: Int, _ completion: @escaping (UIImage?)->Void) {
        let object = posts[index].data
        if let imageUrl = object.preview?.images.first?.source.url {
            imageHelper(imageUrl, completion)
        }
        else {
            completion(nil)
        }
    }
    
    private func imageHelper(_ url: String, _ completion: @escaping (UIImage?)->Void) {
        if let image = self.cache.object(forKey: url as AnyObject) as? UIImage {
            completion(image)
        } else {
            networking.loadImage(image: url) { image in
                DispatchQueue.main.async {
                    if let im = image {
                        self.cache.setObject(im, forKey: image as AnyObject)
                    }
                    completion(image)
                }
            }
        }
    }
    
    func removePost(at index: Int) {
        posts.remove(at: index)
    }
    /*
    func getTopPost(after: String, _ completion: @escaping (ResponseData)->Void) {
        networking.getTopPost(after: after, taskCallback: completion)
    }
     */
    
}
