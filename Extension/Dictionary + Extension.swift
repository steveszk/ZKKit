//
//  Dictionary.swift
//  client
//
//  Created by 盛子康 on 2021/3/31.
//

public extension Dictionary{
    
    var toJsonData: Data{
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: [])else{ fatalError() }
        return data
    }
    
    var toJsonString: String{
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: [])else{ fatalError() }
        guard let value = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else{ fatalError() }
        return value as String
    }
}
