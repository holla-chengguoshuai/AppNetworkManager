//
//  AppNetWorkManager.swift
//  AppNetworkManager
//
//  Created by xcode on 2024/3/19.
//

import Foundation
import Alamofire
import SwiftyJSON

public struct AppNetworkManager {
    
    var request: DataRequest!
    
    init(request: DataRequest) {
        self.request = request
    }
    
    /// 返回 Response<T>
    public func json<T>(data path: String? = "data", complete: @escaping ((App_Response<T>) -> Void)) {
        request.responseData { response in
            switch response.result {
            case let .success(data):
                let responseJSON = SwiftyJSON.JSON(data)
                guard let result = responseJSON["result"].int, result == 0 else {
                    return self.handleFailed(response: response, complete: complete)
                }

                guard let key = path else {
                    if let result = responseJSON.object as? T {
                        return complete(.success(result))
                    } else {
                        return self.handleFailed(response: response, complete: complete)
                    }
                }

                let paths: [JSONSubscriptType] = key.components(separatedBy: ".").compactMap({ Int($0) ?? $0 })
                guard let resultJSON = responseJSON[paths].object as? T else {
                    return self.handleFailed(response: response, complete: complete)
                }
                return complete(.success(resultJSON))
            case .failure:
                return self.handleFailed(response: response, complete: complete)
            }
        }
    }
    
    /// 失败处理
    public func handleFailed<T>(response: AFDataResponse<Data>, complete: @escaping ((App_Response<T>) -> Void)) {
        guard let data = response.value else {
            complete(.faile(-1))
            return
        }
        let responseJSON = SwiftyJSON.JSON(data)
        var errorCode = -1
        errorCode = responseJSON["result"].intValue
        errorCode = responseJSON["code"].intValue
        self.loggError(response, responseJSON: responseJSON)
        complete(.faile(errorCode))
    }
    
    // 失败埋点上传
    func loggError(_ response: AFDataResponse<Data>,responseJSON:JSON) {
        let body = String(data: response.request?.httpBody ?? Data(), encoding: .utf8)
        var params: [String: Any] = ["request_url": response.request?.url?.path ?? "",
                                     "request_type": response.request?.httpMethod ?? "POST",
                                     "request_parameter": body ?? "",
                                     "http_error_code": response.response?.statusCode ?? 0,
                                     "http_error_desc": response.error?.errorDescription ?? "",
                                     "error_type": "http"]

        params["error_code"] = responseJSON

        if let metrics = response.metrics {
            let start: TimeInterval = metrics.taskInterval.start.timeIntervalSince1970
            let end: TimeInterval = metrics.taskInterval.end.timeIntervalSince1970
            let duration: TimeInterval = metrics.taskInterval.duration
            params["begin_time"] = NSNumber(value: Int(start))
            params["end_time"] = NSNumber(value: Int(end))
            params["duration"] = NSNumber(value: Int(duration))
        }

        print("app loggError, paramter:\(params)")    }
    
}
