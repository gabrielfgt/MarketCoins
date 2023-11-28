//
//  CoinsListModels.swift
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

enum CoinsList {
  // MARK: Use cases
  
  enum FetchGlobalValues {
    
      struct Request {
          let baseCoin: String
    }
      struct Response {
          let baseCoin: String
          let totalMarketCap: [String: Double]
          let totalVolume: [String: Double]
      }
      struct ViewModel {
          struct GlobalValues {
              let title: String
              let value: String
          }
          let globalValues: [GlobalValues]
      }
  }
    
    enum fetchListCoins {
        struct Request {
            let baseCoin: String
            let orderBy: String
            let top: Int
            let pricePercentage: String
        }
        
        struct Response {
            let baseCoin: String
            let id: String
            let symbol: String
            let name: String
            let image: String
            let currentPrice: Double
            let marketCap: Double
            let marketCapRank: Int?
            let priceChangePercentage: Double
        }
        
        struct ViewModel {
            
            struct Coin {
                let id: String
                let name: String
                let rank: String
                let iconUrl: String
                let symbol: String
                let price: String
                let changePercentage: String
                let marketCapitalization: String
            }
            let coins: [Coin]
        }
    }
}