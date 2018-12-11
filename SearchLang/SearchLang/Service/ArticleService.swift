//
//  NewsFeedService.swift
//  SearchLang
//


import Foundation
import UIKit

//1 using associatedType in protocol
protocol GetArticle {
    associatedtype T
    func getArticlesList(str: String,completion: @escaping (Result<T>) -> Void)
}

//2 conform to protocol
struct ArticleService: GetArticle {
    

    
    
    
    //3 EndPoint
    let endpoint: String = "https://api.github.com/search/repositories?q="
    
    let downloader = JSONDownloader()
    
    //the associated type is inferred by <[SearchResult?]>
    typealias CompletionHandler = (Result<[SearchResult?]>) -> ()
    
    //4 protocol required function
    func getArticlesList(str: String,completion: @escaping CompletionHandler) {
        // Checking URL is Valid
        guard let url = URL(string: self.endpoint + str) else {
            completion(.Error(.invalidURL))
            return
        }
        //5 using the JSONDownloader function
        let request = URLRequest(url: url)
        let task = downloader.jsonTask(with: request) { (result) in
            
            DispatchQueue.main.async {
                switch result {
                case .Error(let error):
                    completion(.Error(error))
                    return
                case .Success(let json):
                    //6 parsing the Json response
                    guard let articleListArray = json["items"] as? [[String: AnyObject]] else {
                        completion(.Error(.jsonParsingFailure))
                        return
                    }
                    
                    //7 maping the array and create Article objects
                    let articleArray = articleListArray.map{SearchResult(fromDictionary: ($0 as NSDictionary) as! [String : Any])}
                    completion(.Success(articleArray))
                }
            }
        }
        task.resume()
    }
}


