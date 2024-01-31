//
//  BoxView.swift
//  reMind
//
//  Created by Pedro Sousa on 03/07/23.
//

import SwiftUI

struct BoxView: View {
    var box: Box

    @ObservedObject var viewModel: TermViewModel
    @State private var searchText: String = ""
    @State private var isCreatingTerm: Bool = false
    @State private var isEditingTerm: Bool = false
    private var filteredTerms: [Term] {
        let terms: [Term] = viewModel.terms
        
        if searchText.isEmpty {
            return terms
        } else {
            return terms.filter { ($0.value ?? "").contains(searchText) }
        }
    }
    
    init (box: Box){
        self.box = box
        viewModel = TermViewModel(box: box)
    }
    var body: some View {
        List {
                TodaysCardsView(numberOfPendingCards: 0,
                                theme: .mauve)
            Section {
                ForEach(filteredTerms) { term in
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
            } header: {
                Text("All Cards")
                    .textCase(.none)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Palette.label.render)
                    .padding(.leading, -16)
                    .padding(.bottom, 16)
            }

        }
        .scrollContentBackground(.hidden)
        .background(reBackground())
        .navigationTitle(box.name ?? "Unknown")
        .searchable(text: $searchText, prompt: "")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    isEditingTerm.toggle()
                } label: {
                    Image(systemName: "square.and.pencil")
                }

                Button {
                    isCreatingTerm.toggle()
                } label: {
                    Image(systemName: "plus")
                }

            }
        }
        .sheet(isPresented: $isEditingTerm){
            TermEditorView(box: box, viewModel: viewModel)
        }
        .sheet(isPresented: $isCreatingTerm){
            TermEditorView(box: box, viewModel: viewModel)
        }
    }
}

struct BoxView_Previews: PreviewProvider {
    static let box: Box = {
        let box = Box(context: CoreDataStack.inMemory.managedContext)
        box.name = "Box 1"
        box.rawTheme = 0
        BoxView_Previews.terms.forEach { term in
            box.addToTerms(term)
        }
        return box
    }()

    static let terms: [Term] = {
        let term1 = Term(context: CoreDataStack.inMemory.managedContext)
        term1.value = "Term 1"

        let term2 = Term(context: CoreDataStack.inMemory.managedContext)
        term2.value = "Term 2"

        let term3 = Term(context: CoreDataStack.inMemory.managedContext)
        term3.value = "Term 3"

        return [term1, term2, term3]
    }()
    

    static var previews: some View {
        NavigationStack {
            BoxView(box: BoxView_Previews.box)
        }
    }
}
