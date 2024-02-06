//
//  TermRowView.swift
//  reMind
//
//  Created by Marcos Bezerra on 04/02/24.
//

import SwiftUI

struct TermRowView: View {
    @ObservedObject var viewModel: TermViewModel
    @State private var isEditingTerm = false
    let term: Term

    var body: some View {
        Button {
            isEditingTerm.toggle()
        } label: {
            Text(term.value ?? "Unknown")
                .padding(.vertical, 8)
                .fontWeight(.bold)
                .swipeActions(edge: .trailing) {
                    Button(role: .destructive) {
                        print("delete")
                    } label: {
                        Image(systemName: "trash")
                    }
                }
        }
        .sheet(isPresented: $isEditingTerm){
            TermEditorView(term: term, viewModel: viewModel)
        }
    }
}

struct TermRowView_Previews: PreviewProvider {
    static var term: Term{
        let term = Term(context: CoreDataStack.inMemory.managedContext)
        term.meaning = "Meaning"
        term.value = "Term"
        return term
    }
    
    static var previews: some View {
        TermRowView(viewModel: TermViewModel(box: .newObject()), term: TermRowView_Previews.term)
    }
}
