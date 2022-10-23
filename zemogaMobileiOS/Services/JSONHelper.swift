//
//  JSONHelper.swift
//  meliMobileiOS
//
//  Created by Oscar David Myerston Vega on 3/09/22.
//

import Foundation

class JSONHelper {
    static func deserialize<T>(_ object: [AnyHashable: Any], type: T.Type) -> T? where T: Codable {
       do {
           guard let data = try? JSONSerialization.data(withJSONObject:object,
                                                        options: .prettyPrinted) else { return nil }
           return try JSONDecoder().decode(type, from: data)
       } catch let error {
           print(">> Error Get/Parese as Data Custom =\(error.localizedDescription) !!")
       }
       return nil
    }
       
    static func serialize<T>(value: T) -> [AnyHashable: Any] where T: Codable {
       do {
           let data = try JSONEncoder().encode(value)
           return try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String : Any]
       } catch {
           return [:]
       }
    }
    
    static func getDictionary(_ data: Data) -> [AnyHashable: Any]?  {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [AnyHashable: Any]
        } catch let error {
            print(">> Error Get/Parese as Data Custom =\(error.localizedDescription) !!")
        }
        return nil
    }
    
    static func convertToDictionary(text: String) -> [AnyHashable: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error)
            }
        }
        return nil
    }
    
    static func convertToJson(_ dictionary: [AnyHashable: Any]) -> String? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
            
            return String(data: jsonData, encoding: .utf8)
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }

}

extension Encodable {
    
    /**
     * Convert `Encodable` object to `Dictionary`
     *
     * - Returns: Encodable object as Dictionary
     */
    
    func dictionary() -> [AnyHashable: Any] {
        do {
            let data = try JSONEncoder().encode(self)
            return try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any] ?? [:]
        } catch {
            return [:]
        }
    }
    
}
