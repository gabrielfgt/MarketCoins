//
//  GlobalValuesDataProvider.swift
//  MarketCoins
//
//  Created by Gabriel Francisco on 24/07/23.
//

import Foundation

protocol GlobalValuesDataProviderDelegate: GenericDataProviderDelegate {}

class GlobalValuesDataProvider: DataProviderManager<GlobalValuesDataProviderDelegate, GlobalModel> {
    
    private let globalStore: GlobalStoreProtocol?
    
    init (globalStore: GlobalStoreProtocol = GlobalStore()) {
        self.globalStore = globalStore
    }
    
    func fetchGlobalValues(){
        globalStore?.fetchGlobal(completion: { result, error in
            if let error {
                self.delegate?.errorData(self.delegate, error: error)
            }
            if let result {
                self.delegate?.success(model: result)
            }
        })
    }
}
