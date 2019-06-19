//
//  Translation.swift
//  UnderConstructionApp
//
//  Created by Amparo Iglesias on 6/19/19.
//  Copyright © 2019 Amparo Iglesias. All rights reserved.
//

import Foundation

class Translation {
    private init() {}

    static let shared = Translation()
    
    
    // JSON data response struct
    struct queryResponse: Codable {
        let code: Int
        let lang: String
        let text: [String]
    }
    
    // Translate() comes with a completion handler.
    func Translate(phrase: String, toLang: String, completion: @escaping ((String) -> Void)) {
        // assembling the URL
        let translateURL = "https://translate.yandex.net/api/v1.5/tr.json/translate"
        
        let key = "trnsl.1.1.20190619T233304Z.81bff74a4854c8ce.ea75e891c448c2f3d1226dea91ec24e162fba1d7"
        let text = phrase
        let url_formatted_text = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let lang = toLang
        let format = "plain"
        let Url = URL(string: "\(translateURL)" + "?key=\(key)&text=\(url_formatted_text!)&lang=\(lang)&format=\(format)")!
        
        var request = URLRequest(url: Url)
        // Post the assembled URL
        request.httpMethod = "POST"
        
        // start waiting for the JSON response if data was found then decode it
        let task = URLSession.shared.dataTask(with: request) { (data,
            response, error) in
            if error != nil {
                completion("ERROR")
            }
            if let data = data {
                completion(self.DecodeJSON(data: data))
            }
        }
        task.resume()
    }
    
    func DecodeJSON(data: Data) -> String  {
        do {
            // data we are getting from API response
            let decoder = JSONDecoder()
            let response = try decoder.decode(queryResponse.self, from: data)
            switch(response.code) {
            case 200: return response.text[0]
            case 401: return "ERROR"
            case 402: return "ERROR"
            case 404: return "ERROR"
            case 413: return "ERROR"
            case 422, 501: return "ERROR"
            default:
                return "ERROR"
            }
        } catch {print(error)}
        return "ERROR"
    }
    


}
