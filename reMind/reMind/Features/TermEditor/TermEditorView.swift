//
//  TermEditorView.swift
//  reMind
//
//  Created by Pedro Sousa on 30/06/23.
//

import SwiftUI

struct TermEditorView: View {
    @Environment (\.dismiss) var dismiss: DismissAction
    
    var term: Term? = nil
    @ObservedObject var viewModel: TermViewModel
    @State var value: String = ""
    @State var meaning: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                reTextField(title: "Term", text: $value)
                reTextEditor(title: "Meaning", text: $meaning, maxSize: 150)
                
                Spacer()
                if term == nil {
                    Button(action: {
                        print("save and add new")
                    }, label: {
                        Text("Save and Add New")
                            .frame(maxWidth: .infinity)
                    })
                    .buttonStyle(reButtonStyle())
                }
            }
            .padding()
            .background(reBackground())
            .navigationTitle(term == nil ? "New Term" : "Edit Term")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if let term = term{
                            viewModel.updateTerm(term: term, value: value, meaning: meaning)
                        } else{
                            viewModel.newTerm(value: value, meaning: meaning)
                        }
                        dismiss()
                    }
                    .fontWeight(.bold)
                }
            }
            .onAppear{
                if let term = term{
                    self.value = term.value ?? ""
                    self.meaning = term.meaning ?? ""
                }
            }
        }
    }
}

struct TermEditorView_Previews: PreviewProvider {
    static var term: Term {
        let term = Term(context: CoreDataStack.inMemory.managedContext)
        term.value = "Term"
        term.meaning = "Meaning"
        return term
    }
    static var previews: some View {
        TermEditorView(
            term: TermEditorView_Previews.term,
            viewModel: TermViewModel(box: .newObject())
        )
    }
}
