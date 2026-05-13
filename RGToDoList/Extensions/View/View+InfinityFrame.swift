//
//  View+InfinityFrame.swift
//  RGToDoList
//
//  Created by joe on 5/13/26.
//

import SwiftUI

extension View {
    func infinityFrame() -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
