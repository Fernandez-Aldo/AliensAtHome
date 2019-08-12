//
//  Networking.swift
//  AliensAtHome
//
//  Created by MAC Consultant on 8/9/19.
//  Copyright © 2019 Aldo. All rights reserved.
//

import UIKit

//Use of API to fetch Data from www.reddit.com.
class Networking {
    
    func getTopPost(after: String = "", taskCallback: @escaping (ResponseData) -> ())  {
        let redditUrl = URL(string: "https://www.reddit.com/r/popular/top.json?after=\(after)")
        
        URLSession.shared.dataTask(with: redditUrl!) { (data, response
            , error) in

            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let redditData = try decoder.decode(RedditBase.self, from: data)
                let data = redditData.data
                
                taskCallback(data)
            } catch let err {
                print("Err", err)
                
            }
            }.resume()
    }
    
    func loadImage(image: String, imageLoaded: @escaping (UIImage?) -> ()) {
        guard let urlString = image.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)?.replacingOccurrences(of: "&amp;", with: "&") else {
            imageLoaded(nil)
            return
        }
    //properly encoding this as a valid URL
        guard let url = URL(string: urlString) else {
            imageLoaded(nil)
            return
        }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request as URLRequest){ data,response,error in
            if let data = data, let img: UIImage = UIImage(data: data) {
                imageLoaded(img)
            }
            else {
                imageLoaded(nil)
            }
            }.resume()
    }
}
    
    
    

