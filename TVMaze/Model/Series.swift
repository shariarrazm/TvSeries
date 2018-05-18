//
//  Series.swift
//  TVMaze
//
//  Created by Shariar Razm1 on 2018-05-04.
//  Copyright © 2018 Shariar Razm. All rights reserved.
//

import Foundation
import UIKit
struct Series: Decodable {
    let name: String?
    let genres: [String]?
    let status: String?
    let runtime: Int?
    let rating: Rating?
    let image: Images?
    let summary: String?
}

struct Rating: Decodable {
    let average: Double?
}

