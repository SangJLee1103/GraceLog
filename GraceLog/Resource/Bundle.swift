//
//  Bundle.swift
//  GraceLog
//
//  Created by 이상준 on 3/8/25.
//

import Foundation

extension Bundle {
    func decodeMockJSON<T: Decodable>(_ type: T.Type, from fileName: String) -> T? {
        guard let url = self.url(forResource: fileName, withExtension: "json") else {
            print("⚠️ \(fileName).json 파일을 찾을 수 없습니다")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode(type, from: data)
        } catch {
            print("⚠️ \(fileName).json 파일 로드/디코딩 오류: \(error)")
            return nil
        }
    }
}
