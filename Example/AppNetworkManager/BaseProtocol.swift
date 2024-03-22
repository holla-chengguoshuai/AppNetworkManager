//
//  BaseProtocol.swift
//  AppNetworkManager_Example
//
//  Created by xcode on 2024/3/20.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import AppNetworkManager
import Alamofire


enum BaseProtocol: App_ApiProtocol {
    
    case getBlockList
    
    var pathURL: String {
        get {
            switch self {
            case .getBlockList:
                return "PcGirl/BlockList/getBlockList"
            }
        }
    }
    
    var method: HTTPMethod {
        get {
            return .post
        }
    }
    
    var encoding: ParameterEncoding {
        get {
            return  URLEncoding.default
        }
    }
}
