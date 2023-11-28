//
//  GlobalStore.swift
//  MarketCoins
//
//  Created by Gabriel Francisco on 22/07/23.
//

import Foundation

protocol GlobalStoreProtocol: GenericStoreProtocol{
    func fetchGlobal(completion: @escaping completion<GlobalModel?>)
}

class GlobalStore: GenericStoreRequest, GlobalStoreProtocol {
    
    func fetchGlobal(completion: @escaping completion<GlobalModel?>){
        do {
            guard let url = try GlobalRouter.global.asUrlRequest() else {
                return completion(nil, error) }
            request(url: url, completion: completion)
        } catch let error {
            completion (nil, error)
        }
    }

}
