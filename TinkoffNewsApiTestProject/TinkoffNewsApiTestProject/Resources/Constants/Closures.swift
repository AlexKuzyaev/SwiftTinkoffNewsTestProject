//
//  Closures.swift
//  TinkoffNewsApiTestProject
//
//  Created by Александр Кузяев on 30.05.2020.
//  Copyright © 2020 Alexandr Kuzyaev. All rights reserved.
//

import Foundation

typealias ResultDictClosure = (Result<[[String: AnyObject]]>) -> Void
typealias ResultStringClosure = (Result<String>) -> Void
