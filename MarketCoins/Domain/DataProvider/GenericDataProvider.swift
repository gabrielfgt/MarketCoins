//
//  GenericDataProvider.swift
//  MarketCoins
//
//  Created by Gabriel Francisco on 22/07/23.
//

import Foundation

protocol GenericDataProviderDelegate {
    func success (model: Any)
    func errorData (_ provider: GenericDataProviderDelegate?, error: Error)
}

class DataProviderManager<T, S>{
    var delegate: T?
    var model: S?
}
