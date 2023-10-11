//
//  Scale.swift
//  Gilly
//
//  Created by Dylan Elliott on 9/10/2023.
//

import Foundation

struct Scale {
    let intervals: [Interval]
    
    func notes(startingFrom root: Note, octaves: Int = 1) -> [Note] {
        guard octaves > 0 else { return [] }
        
        let notes = intervals.reduce((root, [root])) { result, interval in
            let next = result.0.advanced(by: interval)
            return (next, result.1 + [next])
        }.1
        
        return (0 ..< octaves).flatMap { octave in
            notes.advanced(byOctaves: octave)
        }
    }
}

extension Scale {
    static let major: Scale = .init(intervals: [
        .tone, .tone, .semitone, .tone, .tone, .tone, .semitone
    ])
}
