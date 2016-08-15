//
//  ParseClient.swift
//  Hungry
//
//  Created by Binwei Yang on 8/15/16.
//  Copyright © 2016 Binwei Yang. All rights reserved.
//

import UIKit
import Parse

class ParseClient: NSObject {
    static let configuration = ParseClientConfiguration {
        // Add your Parse applicationId:
        $0.applicationId = "4PJk43NpfayZmVtGNapnxln5GQblsnsc7GMLLtgB"
        // Uncomment and add your clientKey (it's not required if you are using Parse Server):
        // $0.clientKey = "your_client_key"
        
        // Uncomment the following line and change to your Parse Server address;
        $0.server = "http://localhost:1337/parse"
        
        // Enable storing and querying data from Local Datastore.
        // Remove this line if you don't want to use Local Datastore features or want to use cachePolicy.
        // $0.localDatastoreEnabled = true
    }
    
    static var defaultACL: PFACL?
    
    override class func initialize() {
        super.initialize()
        
        Parse.initializeWithConfiguration(configuration)
        
        // If you would like all objects to be private by default, remove this line.
        defaultACL?.publicReadAccess = true
        PFACL.setDefaultACL(defaultACL, withAccessForCurrentUser: true)
    }
    
    func queryOffers( limit: Int, includeKeys keys: [String]?, orderDescendingByKey key: String?, completion: ([Offer]!, NSError!) -> Void) {
        
        let query = PFQuery(className: Offer.parseClassName)
        
        query.limit = limit
        
        if let includeKeys = keys {
            query.includeKeys(includeKeys)
        }
        
        if let orderByKey = key {
            query.addDescendingOrder(orderByKey)
        }
        
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error) in
            if (nil == error) {
                let offers = Offer.offersFromArray(objects!)
                completion(offers, error)
            }
            else {
                completion(nil, error)
            }
        }
    }
}
