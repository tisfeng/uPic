//
//  Data+Extension.swift
//  uPic
//
//  Created by Svend Jin on 2019/6/16.
//  Copyright © 2019 Svend Jin. All rights reserved.
//

import Cocoa
import CryptoSwift

extension Data {

    func toBytes() -> Array<UInt8> {
        return self.bytes
    }

    func toMd5() -> String {
        return self.md5().toHexString()
    }

    func toBase64() -> String {
        return self.bytes.toBase64()
    }

    func toSha1() -> String {
        return self.sha1().toHexString()
    }

    func toSha224() -> String {
        return self.sha224().toHexString()
    }

    func toSha256() -> String {
        return self.sha256().toHexString()
    }

    func toSha384() -> String {
        return self.sha384().toHexString()
    }

    func toSha512() -> String {
        return self.sha512().toHexString()
    }

    func toString() -> String {
        return String(data: self, encoding: .utf8)!
    }

    // 转换图片格式
    func convertImageData(_ fileType: NSBitmapImageRep.FileType = .png) -> Data? {
        let bitmap = NSBitmapImageRep(data: self)
        let data = bitmap?.representation(using: fileType, properties: [:])
        return data
    }

    /// Get github file sha.
    func githubSHA() -> String {
        let header = "blob \(self.count)\0".data(using: .utf8)!
        var store = Data()
        store.append(header)
        store.append(self)
        let sha1 = store.sha1().toHexString()
        return sha1
    }

    /// Get github file sha.
        func githubSHAAsync() async -> String {
            return await withCheckedContinuation { continuation in
                DispatchQueue.global().async {
                    let sha1 = self.githubSHA()
                    continuation.resume(returning: sha1)
                }
            }
        }
}
