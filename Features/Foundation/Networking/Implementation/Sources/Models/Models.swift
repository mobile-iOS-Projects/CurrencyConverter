//
//  Models.swift
//  Networking
//
//  Created by Siarhei Runovich on 18.05.24.
//

import Foundation

// MARK: - HTTPHeaders

/// HTTP header values based on key value pairs
public typealias HTTPHeaders = [String: String]

// MARK: - HTTPParameters

/// HTTP parameter values based on key value pairs
public typealias HTTPParameters = [String: Any]

// MARK: - ResourceResponse

/// Response from loading a resource
public typealias ResourceResponse = (data: Data, response: URLResponse)
