//
//  Interval.swift
//  Gilly
//
//  Created by Dylan Elliott on 9/10/2023.
//

import Foundation

enum Interval {
    case semitone
    case tone
    
    var semitones: Int {
        switch self {
        case .semitone: return 1
        case .tone: return 2
        }
    }
}
