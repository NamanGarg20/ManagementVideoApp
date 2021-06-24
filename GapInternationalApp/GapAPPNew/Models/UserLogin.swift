//
//  UserLogin.swift
//  GapApp
//
//  Created by NAMAN GARG on 6/21/21.
//

import Foundation

class UserLogin{
    let resourceApi = "https://gapinternationalwebapi20200521010239.azurewebsites.net/api/User/"
    
    
    func userLogin(_ name: String, _ password:String,_ createAccount: Bool, _ completion: @escaping ((Completion)-> Void)){
        var resource = resourceApi
        
        if createAccount{
        resource += "CreateUserAccount"
        }else{
        resource += "UserLogin"
        }
        
        guard let resourceURL = URL(string: resource) else{
            fatalError()
        }
        
        let userModel = User(userName: name, password: password)
        guard let userData = try? JSONEncoder().encode(userModel) else {
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
}
