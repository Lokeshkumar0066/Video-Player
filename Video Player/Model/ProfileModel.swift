//
//  ProfileModel.swift
//  Video Player
//
//  Created by manish on 10/02/20.
//  Copyright © 2020 manish. All rights reserved.
//

import UIKit

class ProfileModel: NSObject {
    var userImageUrl: String?
    var userName: String?
    var title: String?
    var postDescription: String?
    var postId: String?
    var postUserImageUrl: String?
    
    init(userName: String,title:String,userImageUrl: String, postDescription:String) {
        self.userName = userName
        self.title = title
        self.userImageUrl = userImageUrl
        self.postDescription = postDescription
    }
    
    
    init(dictProfile: NSDictionary) {
        self.userName = dictProfile["userName"] as? String
        self.title = dictProfile["title"] as? String
        self.userImageUrl = dictProfile["userImageUrl"] as? String
        self.postDescription = dictProfile["description"] as? String
    }

    
    init(postDictionnary: NSDictionary) {
        self.postId = postDictionnary["id"] as? String
        self.postUserImageUrl = postDictionnary["userImageUrl"] as? String
    }
    
    public class func modelFromDictionnaryArray(arrPost: [AnyObject]) -> [ProfileModel] {
        var items = [ProfileModel]()
        
        for data in arrPost {
            items.append(ProfileModel(postDictionnary: data as! NSDictionary))
        }
        return items
    }
    
}
