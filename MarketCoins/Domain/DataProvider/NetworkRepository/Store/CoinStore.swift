//
//  CoinStore.swift
//  MarketCoins
//
//  Created by Gabriel Francisco on 22/07/23.
//

import Foundation

protocol CoinStoreProtocol: GenericStoreProtocol{
    func fetchListCoins(by vsCurrency: String,
                        with cryptocurrency: [String]?,
                        orderby order: String,
                        total parPage: Int,
                        page: Int,
                        percentagePrice: String,
                        completion: @escaping completion <[CoinModel]?>)
    func fetchHistorical (by id: String,
                          currency vsCurrency: String,
                          from: String,
                          to: String,
                          completion: @escaping completion <MarketChartModel?>)
    func fetchHistorical (by id: String,
                          currency vsCurrency: String,
                          of days: String,
                          completion: @escaping completion <[GraphicDataModel]?>)
    func fetchCoin(by id: String,
                   completion: @escaping completion <[CurrentDataModel]?>)
}

class CoinStore: GenericStoreRequest, CoinStoreProtocol {

    func fetchListCoins(by vsCurrency: String, with cryptocurrency: [String]?, orderby order: String, total parPage: Int, page: Int, percentagePrice: String, completion: @escaping completion <[CoinModel]?>) {
        do {
            guard let url = try CoinsRouter.coinsMarkets(currency: vsCurrency,
                                                         cryptocurrency: cryptocurrency,
                                                         order: order,
                                                         parPage: parPage,
                                                         page: page,
                                                         percentage: percentagePrice).asUrlRequest()
            else {
                return completion (nil, error)
            }
            request(url: url, completion: completion)
        }   catch let error {
            completion (nil, error)
        }
    }
    func fetchHistorical(by id: String, currency vsCurrency: String, from: String, to: String, completion: @escaping completion<MarketChartModel?>) {
        do {
            guard let url  = try CoinsRouter.coinsByIdMarketChart(id: id, currency: vsCurrency, from: from, to: to).asUrlRequest()
            else {
                return completion(nil, error)
            }
            request(url: url, completion: completion)
        } catch let error {
            completion(nil, error)
        }
    }
    
    func fetchHistorical(by id: String, currency vsCurrency: String, of days: String, completion: @escaping completion<[GraphicDataModel]?>) {
        do {
            guard let url = try CoinsRouter.coinsByIdOhlc(id: id, currency: vsCurrency, days: days).asUrlRequest()
            else {
                return completion (nil, error)
            }
            request (url: url, completion: completion)
        } catch let error {
            completion (nil, error)
        }
    }
    
    func fetchCoin(by id: String, completion: @escaping completion<[CurrentDataModel]?>) {
        do {
            guard let url = try CoinsRouter.coinsById(id: id).asUrlRequest()
            else {
                return completion (nil, error)
            }
            request(url: url, completion: completion)
        } catch let error {
            completion (nil, error)
        }
    }
}
