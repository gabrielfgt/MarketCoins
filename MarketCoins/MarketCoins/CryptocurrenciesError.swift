//
//  CryptocurrenciesError.swift
//  MarketCoins
//
//  Created by Gabriel Francisco on 24/07/23.
//

import Foundation

enum CryptocurrenciesError: Error {
    case internalServerError
    case badRequestError
    case notFoundError
    case undefinedErorr
    
    var description: String {
        switch self {
        case .internalServerError:
            return "Ocorreu um erro no servidor. Tente novamente mais tarde!"
        case .badRequestError:
            return "Sua requisição nao foi bem sucedida. Verificar parâmetros enviados."
        case .notFoundError:
            return "Página não encontrada."
        case .undefinedErorr:
            return "Ocorreu um erro, tente novamente."
        } 
    }
}
