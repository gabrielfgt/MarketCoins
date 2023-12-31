//
//  CoinsListInteractor.swift
//  MarketCoins
//
//  Created by Gabriel Francisco on 24/07/23.
//  Copyright (c) 2023 DEVFAST.CO. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol CoinsListBusinessLogic {
    func doFetchGlobalValues(request: CoinsList.FetchGlobalValues.Request)
    func doFetchListCoins(request: CoinsList.fetchListCoins.Request)
}

protocol CoinsListDataStore {
    //var name: String { get set }
}

class CoinsListInteractor: CoinsListBusinessLogic, CoinsListDataStore {
    var presenter: CoinsListPresentationLogic?
    var globalValuesWorker: GlobalValuesWorker?
    var coinListWorker: CoinsListWorker?
    //var name: String = ""
    
    init(presenter: CoinsListPresentationLogic = CoinsListPresenter(),
         globalValuesWorker: GlobalValuesWorker = GlobalValuesWorker(),
         coinListWorker: CoinsListWorker = CoinsListWorker()) {
        
        self.presenter = presenter
        self.globalValuesWorker = globalValuesWorker
        self.coinListWorker = coinListWorker
    }
    
    func doFetchGlobalValues(request: CoinsList.FetchGlobalValues.Request) {
        globalValuesWorker?.doFetchGlobalValues(completion: { result in
            switch result {
            case .success(let globalModel):
                self.createGlobalValuesResponse(baseCoin: request.baseCoin, global: globalModel)
            case .failure(let error):
                self.presenter?.presentError(error: error)
            }
        })
    }
    
    func doFetchListCoins(request: CoinsList.fetchListCoins.Request) {
        let baseCoin = request.baseCoin
        let orderBy = request.orderBy
        let top = request.top
        let percentagePrice = request.pricePercentage
        
        coinListWorker?.doFetchListCoins(baseCoin: baseCoin,
                                         orderBy: orderBy,
                                         top: top,
                                         percentagePrice: percentagePrice,
                                         completion: { result in
            switch result {
            case .success(let listCoinsModel):
                self.createListCoinsResponse(request: request, listCoins: listCoinsModel)
            case .failure(let error):
                self.presenter?.presentError(error: error)
            }
            })
    }
    
    private func createGlobalValuesResponse(baseCoin: String, global: GlobalModel?) {
        if let global {
            let totalMarketCap = global.data.totalMarketCap.filter { $0.key == baseCoin }
            let totalVolume = global.data.totalVolume.filter { $0.key == baseCoin }
            
            let response = CoinsList.FetchGlobalValues.Response(
                baseCoin: baseCoin,
                totalMarketCap: totalMarketCap,
                totalVolume: totalVolume)
            
            presenter?.presentGlobalValues(response: response)
            
        } else {
            self.presenter?.presentError(error: .undefinedErorr)
        }
    }
    
    private func createListCoinsResponse (request: CoinsList.fetchListCoins.Request, listCoins: [CoinModel]?){
        if let listCoins {
            func priceChangePercentage(pricePercentage: String, coin: CoinModel) -> Double{
                if pricePercentage == "1h" {
                    return coin.priceChangePercentage1H ?? 0.00
                } else if pricePercentage == "24h"{
                    return coin.priceChangePercentage24H ?? 0.00
                } else if pricePercentage == "7d"{
                    return coin.priceChangePercentage7D ?? 0.00
                } else {
                    return coin.priceChangePercentage30D ?? 0.00
                }
            }
                
            let response = listCoins.map { coin in
                                             return CoinsList.fetchListCoins.Response(
                                                baseCoin: request.baseCoin,
                                                id: coin.id,
                                                symbol: coin.symbol,
                                                name: coin.name,
                                                image: coin.image,
                                                currentPrice: coin.currentPrice ?? 0.00,
                                                marketCap: coin.marketCap ?? 0.00,
                                                marketCapRank: coin.marketCapRank,
                                                priceChangePercentage: priceChangePercentage(
                                                    pricePercentage: request.pricePercentage,
                                                    coin: coin)
                                             )
            }
        
            presenter?.presentListCoins(response: response)
            
        } else {
            self.presenter?.presentError(error: .undefinedErorr)
        }
    }
}
