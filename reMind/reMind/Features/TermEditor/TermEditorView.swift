//
//  TermEditorView.swift
//  reMind
//
//  Created by Pedro Sousa on 30/06/23.
//

import SwiftUI

struct TermEditorView: View {
    @Environment (\.dismiss) var dismiss: DismissAction
    
    var box: Box
    @ObservedObject var viewModel: TermViewModel
    @State var term: String = ""
    @State var meaning: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                reTextField(title: "Term", text: $term)
                reTextEditor(title: "Meaning", text: $meaning, maxSize: 150)
                
                Spacer()

                Button(action: {
                    print("save and add new")
                }, label: {
                    Text("Save and Add New")
                        .frame(maxWidth: .infinity)
                })
                .buttonStyle(reButtonStyle())
            }
            .padding()
            .background(reBackground())
            .navigationTitle("New Term")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        viewModel.newTerm(addTo: box, value: term, meaning: meaning)
                        dismiss()
                    }
                    .fontWeight(.bold)
                }
            }
        }
    }
}

struct TermEditorView_Previews: PreviewProvider {
    static var previews: some View {
        TermEditorView(box: Box.newObject(), viewModel: TermViewModel(box: Box.newObject()))
    }
}
