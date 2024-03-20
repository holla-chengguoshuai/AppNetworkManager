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
    
    case getAppInfo
    case getAppInfoV2
    case getBanners
    case getDisable
    case getOtherGifts
    case getGiftBoxInfo // 获取盲盒礼物详情
    case fetchGiftActiveData // 中台 ：获取礼物活动数据 1.10.0
    case AppInfoGetConfig
    
    
    
    var pathURL: String {
        get {
            let info: String = "AppInfo"
            switch self {
            case .getAppInfo:
                return "\(info)/getAppInfo"
            case .getAppInfoV2:
                return "\(info)/getAppInfo/V2"
            case .getBanners:
                return "\(info)/getBanners"
            case .getDisable:
                return "\(info)/getPcGirlAppInfoDisable"
            case .getOtherGifts:
                return "\(info)/getOtherGifts"
            case .getGiftBoxInfo:
                return "Gift/mysteryBox/getList"
            case .fetchGiftActiveData:
                return "PcGirl/ranking/gourds"
            case .AppInfoGetConfig:
                return "AppInfo/getConfig"
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
            return URLEncoding.default
        }
    }
    
    func header(parameter: [String : Any]?) -> HTTPHeaders? {
        return [
            "language": "",
            "device_id": "",
            "app_version": "",
            "timezone": "",
            "phone_model_name": "",
            "Accept": "application/json",
            "Content-Type": "application/json; charset=utf-8"
        ]
    }
    
    var host: String {
        get {
            return ""
        }
    }
}
