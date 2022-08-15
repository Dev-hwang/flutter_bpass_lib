//
//  RequestResult.swift
//  flutter_bpass_lib
//
//  Created by 김형도 on 2022/04/20.
//

import Foundation

struct RequestResult: Codable {
  let state: String
  let type: Int
  let code: String?
}
