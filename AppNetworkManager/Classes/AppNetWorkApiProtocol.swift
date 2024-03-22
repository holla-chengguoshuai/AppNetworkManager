//
//  AppNetWorkApiProtocol.swift
//  AppNetWorkManager
//
//  Created by xcode on 2024/3/19.
//

import Foundation
import Alamofire

/// 回调对象
public enum App_Response<T> {
    case success(T)
    case faile(Int)

    var value: T? {
        switch self {
        case .success(let value):
            return value
        case .faile:
            return nil
        }
    }
}

public protocol App_ApiProtocol {
    var host: String { get }
    var pathURL: String { get }
    var method: HTTPMethod { get }
    var encoding: ParameterEncoding { get }
    
    func header(parameter: [String: Any]?) -> HTTPHeaders?
}


public extension App_ApiProtocol {

    func request(parameter: [String: Any]? = nil, method: HTTPMethod = .post, timeout: TimeInterval = 30) -> AppNetworkManager {
        AF.sessionConfiguration.timeoutIntervalForRequest = timeout
        AF.sessionConfiguration.timeoutIntervalForResource = timeout
        let parameterJson = parameter
        print("\n\n Request:\(self.host)\(self.pathURL)\(parameter?.network_JsonString ?? "")\n")

        let header = self.header(parameter: parameterJson)
        
        return AppNetworkManager(request: AF.request( "\(self.host)\(self.pathURL)", method: method, parameters: parameterJson, encoding: JSONEncoding.default, headers: header))
    }
    
    
}


public extension Dictionary {
    var network_JsonString: String {
        let defaultJsonStr = "[]"

        guard let data = try? JSONSerialization.data(withJSONObject: self) else {
            return defaultJsonStr
        }

        return String(data: data, encoding: .utf8) ?? defaultJsonStr
    }
}
