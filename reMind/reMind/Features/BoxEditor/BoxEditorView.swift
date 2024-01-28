//
//  BoxEditorView.swift
//  reMind
//
//  Created by Pedro Sousa on 29/06/23.
//

import SwiftUI

struct BoxEditorView: View {
    @Environment (\.dismiss) var dismiss
    @ObservedObject var viewModel: BoxViewModel
    
    @State private var name: String = ""
    @State private var keywords: String = ""
    @State private var description: String = ""
    @State private var theme: Int = 1
    
    init(viewModel: BoxViewModel = BoxViewModel()) {
            self.viewModel = viewModel
        }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                reTextField(title: "Name", text: $name)
                reTextField(title: "Keywords",
                            caption: "Separated by , (comma)",
                            text: $keywords)
                
                reTextEditor(title: "Description",
                             text: $description)

                reRadioButtonGroup(title: "Theme",
                                   currentSelection: $theme)
                Spacer()
            }
            .padding()
            .background(reBackground())
            .navigationTitle("New Box")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        viewModel.newBox(name: name, keyword: keywords, description: description, theme: theme)
                        dismiss()
                    }
                    .fontWeight(.bold)
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
