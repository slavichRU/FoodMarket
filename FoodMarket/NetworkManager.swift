//
//  NetworkManager.swift
//  FoodMarket
//
//  Created by Vyacheslav Usikov on 10.04.2023.
//

import Foundation
import UIKit

final class NetworkManager {
    static let shared = NetworkManager()
    
    private let domain = "https://rickandmortyapi.com/api"
    
    private init() {}
    
    func getAvatar(completion: @escaping (Result <GetAllHeroes, Error>) -> Void) {
        
       // let url = URL(string: "https://rickandmortyapi.com/api/character")!
    let url = URL(string: "https://universe-meeps.leagueoflegends.com/v1/ru_ru/faction-browse/index.json")!
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error != nil {
                print(error!.localizedDescription)
                return
            }
                
                do {
                    let dataJson = try JSONDecoder().decode(GetAllHeroes.self, from: data!)
                    DispatchQueue.main.async {
                        completion(.success(dataJson))
                    }
                } catch let error {
                    print(error)
                }
        }.resume()
        }
    
//    func getAvatar2() -> UIImage {
//
//        let url = URL(string: "https://rickandmortyapi.com/api/character/2")!
//        let request = URLRequest(url: url)
//       let image = URLSession.shared.dataTask(with: request) { data, response, error in
//            if error != nil {
//                print(error!.localizedDescription)
//                return
//            }
//
//                do {
//                    let dataJson = try JSONDecoder().decode(Hero.self, from: data!)
//                    let a = dataJson.image
//                    let image = UIImage(named: "https://rickandmortyapi.com/api/character/2")!
//                    //return image
//                } catch let error {
//                    print(error.localizedDescription)
//                }
//        }.resume()
//
//    }
    
}
