//
//  reThemePickerView.swift
//  reMind
//
//  Created by Marcos Bezerra on 15/01/24.
//

import SwiftUI

struct reThemePickerView: View {
    @Binding var selectedTheme: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            Text("Theme")
                .fontWeight(.bold)
                .padding(.bottom, 16)
            
            HStack(spacing: 20){
                reRadialButtonView(tag: 0, theme: .mauve, selection: $selectedTheme)
                
                reRadialButtonView(tag: 1, theme: .lavender, selection: $selectedTheme)
                
                reRadialButtonView(tag: 2, theme: .aquamarine, selection: $selectedTheme)
            }
        }
        .frame(height: 94)
    }
}

struct reThemePickerView_Previews: PreviewProvider {
    
    static var previews: some View {
        reThemePickerView(selectedTheme: .constant(2))
    }
}
