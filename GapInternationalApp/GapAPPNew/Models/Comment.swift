//
//  Comment.swift
//  GapAPPNew
//
//  Created by NAMAN GARG on 6/21/21.
//

import Foundation


class Comment{
    
    let resourceApi = "https://gapinternationalwebapi20200521010239.azurewebsites.net/api/User"
    
    func addComment(_ user:String, _ chapter:String , _ comment:String, _ completion: @escaping ((Completion)-> Void)){
        let resource = resourceApi + "/SaveJournal"
        
        
        guard let resourceURL = URL(string: resource) else{
            fatalError()
        }
        
        let date = Date()
        let curr = date.description
        let commentModel = JournalElement(userName: user, chapterName: chapter, comment: comment, level: 1, date: curr)
        guard let userData = try? JSONEncoder().encode(commentModel) else {
                        print("Error: Trying to convert model to JSON data")
                        return
                    }
        
        var request = URLRequest(url: resourceURL)
        request.httpMethod = "POST"
        // Set HTTP Request Header
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = userData
        
        URLSession.shared.dataTask(with:request) { data, response, error in
            
            if let error = error {
                print("Error took place \(error)")
                return
            }
            guard let data = data else {return}
            do{
                let CompletionModel = try JSONDecoder().decode(Completion.self, from: data)
                print("Response data:\n \(CompletionModel.result!)")
                    completion(CompletionModel)
                    
            }catch let jsonErr{
                print(jsonErr)
           }
           }.resume()
    }
    
    func showComment(_ user:String, _ completion: @escaping ((Journal)-> Void)){
           let url = resourceApi + "/GetJournal?UserName=\(user)"
        let resourceURL = URL(string: url)
        URLSession.shared.dataTask(with:resourceURL!) { data, response, error in
            
            if let error = error {
                print("Error took place \(error)")
                return
            }
            guard let data = data else {return}
            do{
                let comment = try JSONDecoder().decode(Journal.self, from: data)
                    completion(comment)
                    
            }catch let jsonErr{
                print(jsonErr)
           }
           }.resume()
        }
}
