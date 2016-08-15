//
//  Offer.swift
//  Hungry
//
//  Created by Binwei Yang on 8/15/16.
//  Copyright © 2016 Binwei Yang. All rights reserved.
//

import UIKit
import Parse

class Offer: NSObject {
    static let parseClassName = "Hungry_Offer"
    
    var realObject: PFObject!
    
    init(className newClassName: String) {
        realObject = PFObject(className: newClassName)
    }
    
    init(object realObject: PFObject) {
        self.realObject = realObject
    }
    
    var foodType: String? {
        get {
            return realObject["food_type"] as? String
        }
        set {
            realObject["food_type"] = foodType
        }
    }
    
    var foodDescription: String? {
        get {
            return realObject["description"] as? String
        }
        set {
            realObject["description"] = foodType
        }
    }
    
    var price: Double? {
        get {
            return realObject["price"] as? Double
        }
        set {
            realObject["price"] = price
        }
    }
    
    var seller: PFUser? {
        get {
            return realObject["seller"] as? PFUser
        }
        set {
            realObject["seller"] = seller
        }
    }
    
    var buyer: PFUser? {
        get {
            return realObject["buyer"] as? PFUser
        }
        set {
            realObject["buyer"] = seller
        }
    }
    
    subscript (key: String) -> AnyObject! {
        return realObject.objectForKey(key)
    }
    
    class func offersFromArray(objects: [PFObject]) -> [Offer] {
        var offers = [Offer] ()
        
        for object in objects {
            let offer = Offer(object: object)
            offers.append(offer)
        }
        
        return offers
    }
}
