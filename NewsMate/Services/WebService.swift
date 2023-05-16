//
//  WebService.swift
//  NewsMate
//
//  Created by Marco Mascorro on 5/16/23.
//

import Foundation
import UIKit


//[Article]
//https://newsapi.org/v2/top-headlines?country=us&apiKey=a248e3201c034cae986da78666b11b9e


class WebService {
    
    func getArticles(url: URL, completion: @escaping([Article]?)->Void){
        
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            
            // Create a data task
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    completion(nil)
                    return
                }
                
                // Check if response status code is in the success range
                if let httpResponse = response as? HTTPURLResponse,
                   (200...299).contains(httpResponse.statusCode) {
                    // Ensure data is not nil
                    guard let data = data else {
                        print("No data received")
                        completion(nil)
                        return
                    }
                    
                    do{
                        let article = try JSONDecoder().decode(NewsResponse.self, from: data)
                        completion(article.articles)
                    } catch {
                        print(error.localizedDescription)
                        completion(nil)
                    }
                
                } else {
                    print("Invalid response or status code")
                    completion(nil)
                    return
                }
            }
            
            // Start the data task
            task.resume()
    }
    
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        
        
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            // Check if response status code is in the success range
            if let httpResponse = response as? HTTPURLResponse,
               (200...299).contains(httpResponse.statusCode) {
                // Ensure data is not nil
                guard let data = data else {
                    print("No image data received")
                    completion(nil)
                    return
                }
                
                if let image = UIImage(data: data) {
                    completion(image)
                    print("hello")
                } else {
                    print("Invalid image data")
                    completion(nil)
                }
            } else {
                print("Invalid response or status code")
                completion(nil)
            }
        }.resume()
        
        
    }
}
