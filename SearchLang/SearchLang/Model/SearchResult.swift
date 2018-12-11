//
//  SearchResult.swift
//  SearchLang
//


import Foundation
import UIKit


struct SearchResult{

    var owner : Owner!
    var descriptionField : String!
    var name : String!
    var isUpdate : Bool!
    
    init(fromDictionary dictionary: [String:Any]){
        
        descriptionField = dictionary["description"] as? String
        name = dictionary["full_name"] as? String
        isUpdate = false
        if let ownerData = dictionary["owner"] as? [String:Any]{
            owner = Owner(fromDictionary: ownerData)
        }
    
    
}
struct Owner{
    
    
    var login : String!
    init(fromDictionary dictionary: [String:Any]){
        
        login = dictionary["login"] as? String
    }
}


}
