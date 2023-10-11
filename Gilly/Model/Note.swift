//
//  File.swift
//  Gilly
//
//  Created by Dylan Elliott on 9/10/2023.
//

import Foundation

indirect enum Note: Equatable {
    case a
    case bFlat
    case b
    case c
    case cSharp
    case d
    case eFlat
    case e
    case f
    case fSharp
    case g
    case gSharp
    case nTh(Note, Int)
    
    static var allNotes: [Note] { [.a, .bFlat, .b, .c, .cSharp, .d, .eFlat, .e, .f, .fSharp, .g, .gSharp] }

    var rawValue: Int {
        switch self {
        case .a: return 0
        case .bFlat: return 1
        case .b: return 2
        case .c: return 3
        case .cSharp: return 4
        case .d: return 5
        case .eFlat: return 6
        case .e: return 7
        case .f: return 8
        case .fSharp: return 9
        case .g: return 10
        case .gSharp: return 11
        case let .nTh(note, octave): return note.rawValue + octave * Self.allNotes.count
        }
    }
    
    init(rawValue: Int) {
        let noteIndex = rawValue % Self.allNotes.count
        let note = Self.allNotes[noteIndex]
        let octave = (rawValue - noteIndex) / Self.allNotes.count
        
        if octave == 0 {
            self = note
        } else {
            self = .nTh(note, octave)
        }
    }
    
    var nextOctave: Note {
        switch self {
        case let .nTh(note, octave): return .nTh(note, octave + 1)
        default: return .nTh(self, 1)
        }
    }
    
    func advanced(by offset: Int) -> Note {
        .init(rawValue: (rawValue + offset) % Self.allNotes.count)
    }
    
    func advanced(by interval: Interval) -> Note {
        .init(rawValue: (rawValue + interval.semitones) % Self.allNotes.count)
    }
}

extension Note {
    func distance(from root: Note) -> Int {
        guard root != self else { return 0 }
        
        if root.rawValue < self.rawValue {
            return self.rawValue - root.rawValue
        } else {
            return self.nextOctave.distance(from: root)
        }
    }
}

extension Array where Element == Note {
    func advanced(byOffset offset: Int) -> [Note] {
        map { $0.advanced(by: offset) }
    }
    
    func advanced(byOctaves octaves: Int) -> [Note] {
        advanced(byOffset: octaves * Note.allNotes.count)
    }
}
