//
//  TermViewModel.swift
//  reMind
//
//  Created by Marcos Bezerra on 30/01/24.
//

import Foundation


class TermViewModel: ObservableObject{
    private let box: Box
    @Published var terms: [Term]
    
    init(box: Box){
        self.box = box
        let setTerms = box.terms as? Set<Term> ?? []
        terms = Array(setTerms)
    }
    
    func newTerm(value: String, meaning: String){
        let term: Term = Term.newObject()
        term.value = value
        term.meaning = meaning
        terms.append(term)
        box.addToTerms(term)
    }
    
    func updateTerm(term: Term, value: String?, meaning: String?){
        term.value = value ?? term.value
        term.meaning = meaning ?? term.meaning
        objectWillChange.send()
    }
    
    func deleteTerm(term: Term){
        box.removeFromTerms(term)
        if let index = terms.firstIndex(of: term){
            terms.remove(at: index)
            CoreDataStack.shared.saveContext()
        }
    }
}


