//
//  Dictionary.swift
//  client
//
//  Created by 盛子康 on 2021/3/31.
//

public extension Dictionary{
    
    var toJsonData:Data {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: [])else{ fatalError() }
        return data
    }
    
}
