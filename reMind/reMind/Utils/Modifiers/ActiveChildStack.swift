//
//  ActiveChildStack.swift
//  reMind
//
//  Created by Marcos Bezerra on 07/02/24.
//

import Foundation
import SwiftUI

struct ActiveChildStack: EnvironmentKey{
    static var defaultValue: [Binding<Bool>] = []
}



extension EnvironmentValues{
    var childStack: [Binding<Bool>]{
        get {self[ActiveChildStack.self]}
        set {
            self[ActiveChildStack.self] += newValue
        }
    }
}

extension View{
    func childStack(_ child: Binding<Bool>) -> some View{
        environment(\.childStack, [child])
    }
}
