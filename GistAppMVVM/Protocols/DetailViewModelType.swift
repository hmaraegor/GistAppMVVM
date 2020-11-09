//
//  DetailViewModelType.swift
//  GistAppMVVM
//
//  Created by Egor on 09.11.2020.
//

import Foundation

protocol DetailViewModelType {
    var files: [File] { get }
    var gist: Gist { get }
    func getFileTextViaAlamofire (completionHandler: @escaping (String) -> ()) -> Void
}
