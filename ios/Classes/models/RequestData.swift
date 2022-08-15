//
//  RequestData.swift
//  flutter_bpass_lib
//
//  Created by 김형도 on 2022/04/20.
//

import Foundation

struct RequestData: Codable {
  let state: String
  let type: Int
  let dataHash: String?
  let did: String?
  
  init(from dict: Dictionary<String, Any>?) {
    self.state = dict?["state"] as? String ?? ""
    self.type = dict?["type"] as? Int ?? 0
    self.dataHash = dict?["dataHash"] as? String
    self.did = dict?["did"] as? String
  }
}
