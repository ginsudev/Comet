//
//  RespringButton.swift
//  Comet
//
//  Created by Noah Little on 26/3/2023.
//

import SwiftUI

public struct RespringButton: View {
    public init() { }
    
    public var body: some View {
        Button {
            Respring.execute()
        } label: {
            Label(Copy.respring, systemImage: "arrow.triangle.2.circlepath")
        }
    }
}

struct RespringButton_Previews: PreviewProvider {
    static var previews: some View {
        RespringButton()
    }
}
