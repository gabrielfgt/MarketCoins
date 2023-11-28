//
//  ListCoinsDataProvider.swift
//  MarketCoins
//
//  Created by Gabriel Francisco on 22/07/23.
//

import Foundation

protocol ListCoinDataProviderDelegate: GenericDataProviderDelegate {}

class ListCoinsDataProvider:
    DataProviderManager<ListCoinDataProviderDelegate, [CoinModel]>{
    
    private let coinsStore: CoinStoreProtocol?
    
    init(coinsStore: CoinStoreProtocol = CoinStore()) {
        self.coinsStore = coinsStore
    }
    
    func fetchListCoins (by vsCurrency: String,
                         with cryptocurrency: [String]?,
                         orderby order: String,
                         total parPage: Int,
                         page: Int,
                         percentagePrice: String) {
        coinsStore?.fetchListCoins(by: vsCurrency,
                                   with: cryptocurrency,
                                   orderby: order,
                                   total: parPage,
                                   page: page,
                                   percentagePrice: percentagePrice,
                                   completion: { result, error in
            if let error {
                self.delegate?.errorData(self.delegate, error: error)
            }
            if let result {
                self.delegate?.success(model: result)
            }
        })
    }
}


