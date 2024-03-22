//
//  ConvApi.swift
//  AppNetworkManager_Example
//
//  Created by xcode on 2024/3/20.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import AppNetworkManager
import Alamofire
import CommonCrypto

public let app_version = "2.13.0"

public let app_bundleId = "com.teamo.ios"

public let app_SHA256Key = "44b146a132a47b8eb94e7797bc05edd3"


//#if DEBUG
    public let app_baseURL = "http://api-sandbox.camproapp.com/api/"
//#else
//    public let app_baseURL = "https://api.camproapp.com/api/"
//#endif


extension App_ApiProtocol {
    var host: String {
        return app_baseURL
    }
    
    var pathURL: String {
        return "PcGirl/BlockList/getBlockList"
    }
    
    func header(parameter: [String: Any]?) -> HTTPHeaders? {
        
        var header = [
            "language": "en",
            "device_id": "094DF60CDAA05F156B0CBBC259A9F858",
            "app_version": app_version,
            "timezone": "8",
            "phone_model_name": "iPhone 12",
            "Accept": "application/json",
            "Content-Type": "application/json; charset=utf-8",
        ] as HTTPHeaders
        let timestamp = "\(Int(Date().timeIntervalSince1970))"
        let version = app_version
        let bundleId = app_bundleId
        let temp = "\(bundleId)\(timestamp)\(version)\(parameter?.asJsonString ?? "" )"
        let sgin = temp.hmacBase64(algorithm: .SHA256, key: app_SHA256Key)
        header.add(name: "Timestamp", value: timestamp)
        header.add(name: "Version", value: version)
        header.add(name: "BundleId", value: bundleId)
        header.add(name: "Sign", value: sgin)
        header.add(name: "DeviceId", value: "094DF60CDAA05F156B0CBBC259A9F858")
        return header
        
    }
}


extension String {
    func hmac(algorithm: CryptoAlgorithm, key: String) -> String {
        let str = cString(using: String.Encoding.utf8)
        let strLen = Int(lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = algorithm.digestLength
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        let keyStr = key.cString(using: String.Encoding.utf8)
        let keyLen = Int(key.lengthOfBytes(using: String.Encoding.utf8))

        CCHmac(algorithm.HMACAlgorithm, keyStr!, keyLen, str!, strLen, result)

        let digest = stringFromResult(result: result, length: digestLen)

        result.deallocate()

        return digest
    }

    func hmacBase64(algorithm: CryptoAlgorithm, key: String) -> String {
        let str = cString(using: String.Encoding.utf8)
        let strLen = Int(lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = algorithm.digestLength
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        let keyStr = key.cString(using: String.Encoding.utf8)
        let keyLen = Int(key.lengthOfBytes(using: String.Encoding.utf8))

        CCHmac(algorithm.HMACAlgorithm, keyStr!, keyLen, str!, strLen, result)

        var hmacData = Data(bytes: result, count: Int(algorithm.digestLength))

//        var hmacData: NSData = NSData(bytes: result, length: Int(algorithm.digestLength))

        var hmacBase64 = hmacData.base64EncodedString(options: .lineLength76Characters)

        return hmacBase64
    }

    private func stringFromResult(result: UnsafeMutablePointer<CUnsignedChar>, length: Int) -> String {
        let hash = NSMutableString()
        for i in 0 ..< length {
            hash.appendFormat("%02x", result[i])
        }
        return String(hash).lowercased()
    }

    /// range转换为NSRange
    public func nsRange(from range: Range<String.Index>) -> NSRange {
        return NSRange(range, in: self)
    }

    // Base64编码
    func encodBase64() -> String? {
        if let data = data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }

    // Base64解码
    func decodeBase64() -> String? {
        if let data = Data(base64Encoded: self) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
}


enum CryptoAlgorithm {
    case MD5, SHA1, SHA224, SHA256, SHA384, SHA512

    var HMACAlgorithm: CCHmacAlgorithm {
        var result: Int = 0
        switch self {
        case .MD5: result = kCCHmacAlgMD5
        case .SHA1: result = kCCHmacAlgSHA1
        case .SHA224: result = kCCHmacAlgSHA224
        case .SHA256: result = kCCHmacAlgSHA256
        case .SHA384: result = kCCHmacAlgSHA384
        case .SHA512: result = kCCHmacAlgSHA512
        }
        return CCHmacAlgorithm(result)
    }

    var digestLength: Int {
        var result: Int32 = 0
        switch self {
        case .MD5: result = CC_MD5_DIGEST_LENGTH
        case .SHA1: result = CC_SHA1_DIGEST_LENGTH
        case .SHA224: result = CC_SHA224_DIGEST_LENGTH
        case .SHA256: result = CC_SHA256_DIGEST_LENGTH
        case .SHA384: result = CC_SHA384_DIGEST_LENGTH
        case .SHA512: result = CC_SHA512_DIGEST_LENGTH
        }
        return Int(result)
    }
}
