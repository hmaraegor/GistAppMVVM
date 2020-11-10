//
//  DetailViewModelType.swift
//  GistAppMVVM
//
//  Created by Egor on 09.11.2020.
//

import Foundation

protocol DetailViewModelType: AnyObject {
    var files: [File] { get }
    var gist: Gist { get }
    var author: String { get }
    var changed: String { get }
    var firstFileName: String { get }
    func getFileText(completionHandler: @escaping (String) -> ()) -> Void
}
