//
//  TermViewModel.swift
//  reMind
//
//  Created by Marcos Bezerra on 30/01/24.
//

import Foundation


class TermViewModel: ObservableObject{
    @Published var terms: [Term]
    
    init(box: Box){
        let setTerms = box.terms as? Set<Term> ?? []
        terms = Array(setTerms)
    }
    
    func newTerm(addTo box: Box, value: String, meaning: String){
        let term: Term = Term.newObject()
        term.value = value
        term.meaning = meaning
        terms.append(term)
        box.addToTerms(term)
    }
}


