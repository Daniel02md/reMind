//
//  RadialButtomView.swift
//  reMind
//
//  Created by Marcos Bezerra on 15/01/24.
//

import SwiftUI

struct reRadialButtonView: View {
    @State var tag: Int
    @State var theme: reTheme = .aquamarine
    @Binding var selection: Int
    
    
    var body: some View {
        
        Button(action: {selection = tag}){
            Circle()
                .strokeBorder(lineWidth: selection == tag ? 10 : 25)
                .foregroundColor(theme.render)
                .frame(width: 50, height: 50)
        }
        
    }
}

struct reRadialButtonView_Previews: PreviewProvider {
    static var previews: some View {
        reRadialButtonView(tag: 0, selection: .constant(0))
            
    }
}
