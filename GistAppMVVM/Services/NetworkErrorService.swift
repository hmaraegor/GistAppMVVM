//
//  NetworkErrorService.swift
//  GistAppMVVM
//
//  Created by Egor on 08.11.2020.
//

import Foundation

enum NetworkErrorService: Error {
    case badURL
    case noResponse
    case noData
    case jsonDecoding
    case modelEncoding
    case networkError
    case badResponse
}
