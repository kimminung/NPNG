//
//  RemoteProduct.swift
//  NPNGWishList
//
//  Created by 민웅킴 on 4/30/24.
//

import Foundation
                    // 외부의 방식을 swift방식으로 바꾼다. < - > 인코더 (내 -> 외)
struct RemoteProduct: Decodable {
    var id: Int
    var title: String
    var description: String
    var price: Int
    var discountPercentage: Double
    var rating: Double
    var stock: Int
    var brand: String
    var category: String
    var thumbnail: URL
    var images: [String]
    
}
