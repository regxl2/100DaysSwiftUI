//
//  Order.swift
//  Cupcake Corner
//
//  Created by Abhishek Rathore on 12/10/24.
//
import Foundation

@Observable
class Order: Codable{
    
    enum CodingKeys: String, CodingKey{
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequest = "specialRequest"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _streetAddress = "streetAddress"
        case _city = "city"
        case _zipCode = "zipCode"
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type  = 0
    var quantity = 3
    
    var specialRequest = false {
        didSet{
            if specialRequest == false{
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zipCode = ""
    
    var hasValidAddress: Bool{
        !name.isEmpty && !streetAddress.isEmpty && !city.isEmpty && !zipCode.isEmpty
    }
    
    var cost: Decimal {
        // $2 per cake
        var cost = Decimal(quantity) * 2

        // complicated cakes cost more
        cost += Decimal(type) / 2

        // $1/cake for extra frosting
        if extraFrosting {
            cost += Decimal(quantity)
        }

        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }

        return cost
    }
}
