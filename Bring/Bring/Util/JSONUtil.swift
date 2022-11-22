//
//  JSONUtil.swift
//  CustomCalender
//
//  Created by dddddddd9 on 2022/11/18.
//

import Foundation


class JSONUtil {
    
    public static func dictToString(_ dic:[String : Any]) -> String? {
        let data = try? JSONSerialization.data(withJSONObject: dic, options: [])
        let str = String(data: data!, encoding: String.Encoding.utf8)
        return str
    }

    public static func stringToDict(_ str: String) -> [String : Any] {
        let data = str.data(using: String.Encoding.utf8)
        if let dict = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : Any] {
            return dict
        }
        return [String : Any]()
    }
    
    public static func createJSONObject(data: Data) -> [String : Any] {
        
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]

            return json
        }
        catch let error as NSError {
            DLogUtil.debug(tag: #file, content: error)
            return [String : Any]()
        }
    }
    
    public static func createJSONObjectEUCKR(data: Data) -> [String : Any] {
        
        do {
            let dataString = NSString(data: data, encoding: CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.EUC_KR.rawValue)))
            
            DLogUtil.debug(tag: #file, content: dataString ?? "")
            let datadata = dataString!.data(using: String.Encoding.utf8.rawValue)
            let json = try JSONSerialization.jsonObject(with: datadata!, options: []) as! [String : Any]

            return json
        }
        catch let error as NSError {
            DLogUtil.debug(tag: #file, content: error)
            return [String : Any]()
        }
    }
    
    public static func parsingJSONObject(jsonObject: [String : Any], key: String) -> [String : Any] {
        
        
        if !jsonObject.keys.contains(key) {
            return [String : Any]()
        }
       
        if jsonObject[key] == nil {
            return [String : Any]()
        }
        
        return jsonObject[key] as? [String : Any] ?? [String : Any]()
    }
    
    public static func parsingJSONArray(jsonObject: [String : Any], key: String) -> [[String : Any]] {
        


        if !jsonObject.keys.contains(key) {
            return [[String : Any]]()
        }
       
        if jsonObject[key] == nil {
            return [[String : Any]]()
        }
        
        return jsonObject[key] as? [[String : Any]] ?? [[String : Any]]()
    }
    
    public static func parsingArray(jsonObject: [String : Any], key: String) -> [Any] {
        if !jsonObject.keys.contains(key) {
            return [Any]()
        }
       
        if jsonObject[key] == nil {
            return [Any]()
        }
        
        return jsonObject[key] as? [Any] ?? [Any]()
    }
    
    public static func parsingString(jsonObject: [String : Any], key: String) -> String {
        
        if !jsonObject.keys.contains(key) {
            return ""
        }
       
        if jsonObject[key] == nil {
            return ""
        }
        
        return jsonObject[key] as? String ?? ""
    }
    
    public static func parsingInt(jsonObject: [String : Any], key: String) -> Int {
        
        if !jsonObject.keys.contains(key) {
            return 0
        }
       
        if jsonObject[key] == nil {
            return 0
        }
        
        return jsonObject[key] as? Int ?? 0
    }
    
    public static func parsingBool(jsonObject: [String : Any], key: String) -> Bool {
        
        if !jsonObject.keys.contains(key) {
            return false
        }
       
        if jsonObject[key] == nil {
            return false
        }
        
        return jsonObject[key] as? Bool ?? false
    }
    
    public static func parsingFloat(jsonObject: [String : Any], key: String) -> Float {
    
        if !jsonObject.keys.contains(key) {
            return 0
        }
       
        if jsonObject[key] == nil {
            return 0
        }
        
        return jsonObject[key] as? Float ?? 0
        
    }
    
}
