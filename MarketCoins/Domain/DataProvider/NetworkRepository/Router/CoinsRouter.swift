//
//  CoinsRouter.swift
//  MarketCoins
//
//  Created by Gabriel Francisco on 22/07/23.
//

import Foundation

enum CoinsRouter {
    
    case coinsMarkets(
        currency: String,
        cryptocurrency: [String]?,
        order: String,
        parPage: Int,
        page: Int,
        percentage: String
    )
    case coinsByIdMarketChart(
        id: String,
        currency: String,
        from: String,
        to: String
    )
    case coinsByIdOhlc(
        id: String,
        currency: String,
        days: String
    )
    case coinsById(id: String)
    
    var path: String {
        switch self {
        case .coinsMarkets:
            return API.coinsMarkets
        case .coinsByIdMarketChart(let id, _, _, _):
            return String(format: API.coinsByIdMarketChart, id)
        case .coinsByIdOhlc(let id, _, _):
            return String(format: API.coinsByIdOhlc, id)
        case .coinsById(id: let id):
            return String(format: API.coinsById, id)
        }
    }
    
    func asUrlRequest () throws -> URL? {
        guard let url = URL(string: API.baseURL) else { return nil}
        
        switch self {
        case .coinsMarkets(let currency, let cryptocurrency, let order, let parPage, let page, let percentage):
            var parameters: [String: String] = [
                "vs_currency": currency,
                "order": order,
                "per_page": String(parPage),
                "page": String(page),
                "sparkline": String(false),
                "percentage": percentage
            ]
            
            if let cryptocurrency {
                parameters["ids"] = cryptocurrency.joined(separator: ",")
            }
            return url.appendingQuerryParameters(path: path, paramethers: parameters)
            
        case .coinsByIdMarketChart(_, let currency, let from, let to):
            let parameters: [String: String] = [
                "vs_curency": currency,
                "from": from,
                "to": to
            ]
            return url.appendingQuerryParameters(path: path, paramethers: parameters)
            
        case .coinsByIdOhlc(_, let currency, let days):
            let parameters: [String: String] = [
                "vs_curerncy": currency,
                "days": days,
            ]
            return url.appendingQuerryParameters(path: path, paramethers: parameters)
            
        case .coinsById:
            let parameters: [String: String] = [
                "localization": "false",
                "tickers": String(false),
                "market_data": String(true),
                "community_data": String(false),
                "developer_data": String(false),
                "sparkline": String(false)
            ]
            return url.appendingQuerryParameters(path: path, paramethers: parameters)
        }
    }
}
