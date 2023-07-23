//
//  GlobalUserData.swift
//  Ern3st
//
//  Created by Muhammad Ali on 16/12/2022.
//

import Foundation
class GlobalUserData{
    static var username: String = ""
    static var userEmail: String = ""
    static var userPassword: String = ""
    static var userHeoight: Int = 0
    static var userOrder: UserOrder?
    static var userId: String = ""
    static var products: [Product] = []
    static var scans: [Scan] = []
    static var orderId = ""
    static var userProfile: UserProfile = UserProfile()
    static var lastScanRecord: ScanRecord = ScanRecord()
    
}
