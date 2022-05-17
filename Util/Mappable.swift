//
//  Mappable.swift
//  Demo (iOS)
//
//  Created by edy on 2022/1/18.
//
import Foundation

public protocol Mappable: Codable {}

public extension Mappable{
    func toDictionary() -> [String:Any]{
        let mirro = Mirror(reflecting: self)
        var dic = [String:Any]()
        for case let (key?,value) in mirro.children{
            dic[key] = value
        }
        return dic
    }
    
    func toJsonString() -> String{
        return toDictionary().toJsonString
    }
    
    func toJsonData() -> Data?{
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(self){
            return data
        }
        return nil
    }
    
    static func mapFromJsonString(jsonString: String) -> Self?{
        guard let jsonData = jsonString.data(using: .utf8) else{return nil}
        let decoder = JSONDecoder()
        if let obj = try? decoder.decode(self, from: jsonData){
            return obj
        }
        return nil
    }
    
    static func mapFromDictionary(dic: [String:Any]) -> Self?{
        let value = dic.toJsonString
        return mapFromJsonString(jsonString: value)
    }
}

public extension Array{
    func toJsonString() -> String?{
        guard JSONSerialization.isValidJSONObject(self) else{return nil}
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: []) else{return nil}
        guard let value = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else{return nil}
        return value as String
    }
}

public extension Array where Element: Decodable{
    static func mapFromJson(value:[[String:Any]]) -> Array<Element>?{
        guard let jsonString = value.toJsonString() else{return nil}
        guard let jsonData = jsonString.data(using: .utf8) else{return nil}
        let decoder = JSONDecoder()
        if let obj = try? decoder.decode(self, from: jsonData){
            return obj
        }
        return nil
    }
}
