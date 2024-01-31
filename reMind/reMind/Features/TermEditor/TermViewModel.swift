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
        print(self.terms)
    }
    
    func newTerm(addTo box: Box, value: String, meaning: String){
        let term: Term = Term.newObject()
        term.boxID = box
        term.value = value
        term.meaning = meaning
        terms.append(term)
    }
}


