//
//  viewControllerExtension.swift
//  Video_Player
//
//  Created by Lokesh on 09/02/20.
//  Copyright © 2020 Lokesh. All rights reserved.
//

import UIKit

import Foundation

extension UIViewController{
    func readingJSONFile(fileName: String) -> [String:Any]{
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? [String:Any]{
                    print(jsonResult)
                    return jsonResult
                }
            } catch let error{
                print(error.localizedDescription)
                return [:]
            }
        }
        
        return [:]
    }

}
