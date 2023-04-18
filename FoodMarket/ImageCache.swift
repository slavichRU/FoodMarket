//
//  ImageCache.swift
//  FoodMarket
//
//  Created by Vyacheslav Usikov on 18.04.2023.
//

import Foundation
import UIKit

class ImageCache {
    static var storage: [URL: UIImage] = [:]
    
    static func getImage(url: URL, completion: @escaping (UIImage?) -> Void)  {
        if let image = storage[url] {
            completion(image)
            
        } else {
            
            let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, let image = UIImage(data: data)
                else {
                    print("cto to poshlo ne tak")
                    completion(nil)
                    return
                }
                print("0")
                //imageData.updateValue(image, forKey: url)
                storage[url] = image
                DispatchQueue.main.async {
                    completion(image)
                }
            }
            dataTask.resume()
        }
    }
}
