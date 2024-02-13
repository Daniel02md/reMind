//
//  BoxCardView.swift
//  reMind
//
//  Created by Pedro Sousa on 27/06/23.
//

import SwiftUI

struct BoxCardView: View {
    var boxName: String
    var numberOfTerms: Int
    var theme: reTheme
    var completionDelete:  () -> Void
    @State var showAlert: Bool = false
    
    init(boxName: String, numberOfTerms: Int, theme: reTheme, completionDelete: @escaping () -> Void) {
        self.boxName = boxName
        self.numberOfTerms = numberOfTerms
        self.theme = theme
        self.completionDelete = completionDelete
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(boxName)
                .font(.title3)
                .fontWeight(.bold)
            
            Label("\(numberOfTerms) terms", systemImage: "doc.plaintext.fill")
                .padding(8)
                .background(Palette.reBlack.render.opacity(0.2))
                .cornerRadius(10)
        }
        .foregroundColor(Palette.reBlack.render)
        .padding(16)
        .frame(width: 165, alignment: .leading)
        .background(theme.render)
        .cornerRadius(10)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .contentShape(.contextMenuPreview, RoundedRectangle(cornerRadius: 10))
        .contextMenu{
            Button(role: ButtonRole.destructive){
                showAlert.toggle()
            } label : {
                Label("Delete", systemImage: "trash")
            }
            Button(role: ButtonRole.cancel){
            } label : {
                Text("Cancel")
            }
        }
        .alert("Box \"\(boxName)\" deleted", isPresented: $showAlert){
            Button{
                Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false){ _ in
                    completionDelete()
                }
            } label:{
                Text("Ok")
            }
        } message: {
            Text("\(numberOfTerms) terms lost.")
        }
    }
}

struct BoxCardView_Previews: PreviewProvider {
    static var previews: some View {
        BoxCardView(boxName: "Math",
                    numberOfTerms: 35,
                    theme: .mauve){}
    }
}
