//
//  BoxEditorView.swift
//  reMind
//
//  Created by Pedro Sousa on 29/06/23.
//

import SwiftUI

struct BoxEditorView: View {
    @Environment (\.dismiss) var dismiss
    @EnvironmentObject var viewModel: BoxViewModel
    
    var box: Box?
    @State private var name: String = ""
    @State private var keywords: String = ""
    @State private var description: String = ""
    @State private var theme: Int = 0
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                reTextField(title: "Name", text: $name)
                reTextField(title: "Keywords",
                            caption: "Separated by , (comma)",
                            text: $keywords)
                
                reTextEditor(title: "Description",
                             text: $description,
                             maxSize: 150)

                reThemePickerView(selectedTheme: $theme)
                Spacer()
            }
            .padding()
            .background(reBackground())
            .navigationTitle("\(box == nil ? "New" : "Edit") Box")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if let fulfilledBox = box {
                            viewModel.updateBox(box: fulfilledBox, name: name, theme: theme)
                            
                            
                        } else{
                            viewModel.newBox(name: name, keyword: keywords, description: description, theme: theme)
                        }
                        dismiss()
                    }
                    .fontWeight(.bold)
                }
            }
            .onAppear{
                if let editedBox = box{
                    self.name = editedBox.name ?? ""
                    self.theme = Int(editedBox.rawTheme)
                }
            }
        }
    }
}

struct BoxEditorView_Previews: PreviewProvider {
    static var previews: some View {
        BoxEditorView()
    }
}
