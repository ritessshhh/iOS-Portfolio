//
//  CoinData.swift
//  ByteCoin-iOS16
//
//  Created by ritessshhh on 06/05/2023.
//

import Foundation

struct CoinData : Codable{
    let rate     : Double
    let currency : String
    
    enum CodingKeys: String, CodingKey{
        case rate     = "rate"
        case currency = "asset_id_quote"
    }
}
