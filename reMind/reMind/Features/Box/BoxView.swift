//
//  BoxView.swift
//  reMind
//
//  Created by Pedro Sousa on 03/07/23.
//

import SwiftUI

struct BoxView: View {
    @EnvironmentObject var viewModel: TermViewModel
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
    
    var body: some View {
        List {
            TodaysCardsView(pending: viewModel.termsToReview.count,
                            theme: viewModel.box.theme)
            Section {
                ForEach(filteredTerms) { term in
                    TermRowView(viewModel: viewModel, term: term)
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
        .navigationTitle(viewModel.box.name ?? "Unknown")
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
            BoxEditorView(box: viewModel.box)
        }
        .sheet(isPresented: $isCreatingTerm){
            TermEditorView(viewModel: viewModel)
        }
    }
}

struct BoxView_Previews: PreviewProvider {
    @ObservedObject static var router = reAppRouter(navigationPath: .init())
    
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
        term1.meaning = "Meaning 1"

        let term2 = Term(context: CoreDataStack.inMemory.managedContext)
        term2.value = "Term 2"
        term2.meaning = "Meaning 2"

        let term3 = Term(context: CoreDataStack.inMemory.managedContext)
        term3.value = "Term 3"
        term3.meaning = "Meaning 3"

        return [term1, term2, term3]
    }()
    

    static var previews: some View {
        NavigationStack(path: $router.navigationPath){
            BoxView()
                .environmentObject(TermViewModel(box: BoxView_Previews.box))
        }
        .environmentObject(router)
    }
}
