//
//  FeedModel.swift
//  Video Player
//
//  Created by manish on 10/02/20.
//  Copyright © 2020 manish. All rights reserved.
//

import UIKit

class FeedModel {
    var id: String?
    var userName: String?
    var vUrl: String?
    var userImageUrl: String?
    var time: String?
    
    init(id: String,userName: String,vUrl:String,userImageUrl: String, time:String) {
        self.id = id
        self.userName = userName
        self.vUrl = vUrl
        self.userImageUrl = userImageUrl
        self.time = time
    }
    
    
    init(dictionnary: NSDictionary) {
        self.id = dictionnary["id"] as? String
        self.userName = dictionnary["userName"] as? String
        self.vUrl = dictionnary["vUrl"] as? String
        self.userImageUrl = dictionnary["userImageUrl"] as? String
        self.time = dictionnary["time"] as? String
    }
    
    public class func modelFromDictionnaryArray(array: [AnyObject]) -> [FeedModel] {
        var items = [FeedModel]()
        for data in array {
            items.append(FeedModel(dictionnary: data as! NSDictionary))
        }
        return items
    }
    
}
