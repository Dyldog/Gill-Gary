//
//  ContentView.swift
//  Gilly
//
//  Created by Dylan Elliott on 9/10/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            ScaleView()
        }
        .padding()
    }
}

struct ScaleView: View {
    @State var origin: Int = 2
    @State var width: Int = 4
    
    var body: some View {
        VStack {
            FretboardView(
                positions: Scale.major.notes(startingFrom: .g, octaves: 3)
                    .positions(in: .init(origin: origin, width: width))
            )
            
            HStack {
                Spacer()
                positionToolbar
                Spacer()
                sizeToolbar
                Spacer()
            }
        }
    }
    
    private var sizeToolbar: some View {
        HStack {
            Button {
                width = max(0, width - 1)
            } label: {
                Image(systemName: "arrowtriangle.right.and.line.vertical.and.arrowtriangle.left.fill")
            }
            
            Button {
                width = width + 1
            } label: {
                Image(systemName: "arrowtriangle.left.and.line.vertical.and.arrowtriangle.right.fill")
            }
            
        }
    }
    
    private var positionToolbar: some View {
        HStack {
            Button {
                origin = max(0, origin - 1)
            } label: {
                Image(systemName: "arrow.left")
            }
            
            Button {
                origin = origin + 1
            } label: {
                Image(systemName: "arrow.right")
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
