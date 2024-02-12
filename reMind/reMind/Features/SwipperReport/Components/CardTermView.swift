//
//  CardTermView.swift
//  reMind
//
//  Created by Marcos Bezerra on 19/01/24.
//

import SwiftUI

struct CardTermView: View {
    @State private var isExpended: Bool = false
    @State var term: String
    @State var meaning: String
    @State var isReviewd: Bool
    
    var body: some View {
        
        DisclosureGroup(isExpanded: $isExpended){
            VStack(alignment: .leading, spacing: 0){
                Text(meaning)
                    .foregroundColor(Palette.reBlack.render)
                    .padding(.vertical, 5.5)
                    .padding(.horizontal, 10)
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 108)
            
            
        } label: {
            
            Label{
                Text(term)
            } icon: {
                Image(systemName: isReviewd ? "checkmark.circle" : "xmark.circle")
                    .padding(.leading, 20)
            }
            .frame(alignment: .leading)
            .frame(height: 59.89)
            .font(.system(size: 17, weight: .semibold))
            .foregroundColor(Palette.reBlack.render)
        }
        .listRowInsets(.init(top: 0, leading: -20, bottom: 0, trailing: 0))
        .padding(.horizontal, 20)
        .background(isReviewd ? Palette.success.render : Palette.error.render)
        
    }

}

struct CardTermView_Previews: PreviewProvider {
    static var term: String = "Math"
    static var meaning: String = "The meaning goes here"
    
    static var previews: some View {
        List{
            Section{
                ForEach(1...2, id: \.self){ _ in
                    CardTermView(term: term, meaning: meaning, isReviewd: true)
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .scrollContentBackground(.hidden)
        .shadow(color: Palette.reBlack.render.opacity(0.23), radius: 6)
        
    }
}
