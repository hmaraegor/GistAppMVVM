//
//  DateService.swift
//  GistAppMVVM
//
//  Created by Egor on 09.11.2020.
//

import Foundation

class DateService {
    
    static func getDate(from strDate: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let myDate = formatter.date(from: strDate) //as NSDate?
        formatter.dateFormat = "HH:mm d MMM y"
        let newDate = formatter.string(from: myDate!)
        
        return newDate
    }
    
}
