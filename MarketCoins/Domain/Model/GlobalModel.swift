//
//  GlobalModel.swift
//  MarketCoins
//
//  Created by Gabriel Francisco on 22/07/23.
//

import Foundation

struct GlobalModel: Codable {
    let data: CryptocurrencyModel
}

//MARK: - CryptocurrencyModel
struct CryptocurrencyModel: Codable {
    let activeCryptocurrencies: Int
    let upcomingIcos: Int
    let ongoingIcos: Int
    let endedIcos: Int
    let markets: Int
    let totalMarketCap: [String: Double]
    let totalVolume: [String: Double]
    let marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    let updatedAt: Int
    
    enum CodingKeys: String, CodingKey {
        case activeCryptocurrencies = "active_crypto_currencies"
        case upcomingIcos = "upcoming_icos"
        case ongoingIcos = "ongoin_icos"
        case endedIcos = "ended_icos"
        case markets
        case totalMarketCap = "total_market_cap"
        case totalVolume = "totalVolume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
        case updatedAt = "update_at"
    }
}
