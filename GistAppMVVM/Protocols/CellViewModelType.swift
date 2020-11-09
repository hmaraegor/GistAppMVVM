//
//  CellViewModelType.swift
//  GistAppMVVM
//
//  Created by Egor on 08.11.2020.
//

import Foundation
import UIKit

protocol CellViewModelType: AnyObject {
    var files: String { get }
    var author: String { get }
    var avatarUrl: String  { get }
    var date: String  { get }
}
