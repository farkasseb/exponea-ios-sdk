//
//  DatabaseManagerType.swift
//  ExponeaSDK
//
//  Created by Dominik Hádl on 11/04/2018.
//  Copyright © 2018 Exponea. All rights reserved.
//

import Foundation

/// Protocol to manage Tracking events
public protocol DatabaseManagerType: class {
    func trackCustomer(projectToken: String, customerId: KeyValueModel, properties: [KeyValueModel], timestamp: Double?) -> Bool
    func trackEvents(projectToken: String, customerId: KeyValueModel, properties: [KeyValueModel],
                     timestamp: Double?, eventType: String?) -> Bool
    func trackInstall(projectToken: String, properties: [KeyValueModel]) -> Bool
    func fetchTrackCustomer() -> [TrackCustomers]?
    func fetchTrackEvents() -> [TrackEvents]?
    func deleteTrackCustomer(object: AnyObject) -> Bool
    func deleteTrackEvent(object: AnyObject) -> Bool
}
