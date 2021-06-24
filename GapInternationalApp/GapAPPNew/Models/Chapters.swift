//
//  Chapters.swift
//  GapApp
//
//  Created by NAMAN GARG on 6/18/21.
//

import Foundation

class Chapters{
    var chapterPlist = [String : [[String:String]]]()
    var chapterVideos = [[String:String]]()
    
    init(){
        chapterPlist = getPlist()
    }
    
    func getPlist() -> [String : [[String:String]]]{
        var config = [String : [[String:String]]]()
        
        if let plistPath = Bundle.main.url(forResource: "Chapters", withExtension: "plist"){
            do{
                let plistData = try Data(contentsOf: plistPath)
                
                if let dict = try PropertyListSerialization.propertyList(from: plistData, options: [], format: nil) as? [String : [[String:String]]]{
                    config = dict
                }
            }
            catch{
                print(error)
            }
        }
        return config
    }
    
    func getChapters() -> [[String:String]]{
        chapterVideos = chapterPlist["Chapters"]!
        return chapterVideos
    }
    
}
