//
//  BoxViewModel.swift
//  reMind
//
//  Created by Pedro Sousa on 17/07/23.
//

import Foundation

class BoxViewModel: ObservableObject {
    @Published var boxes: [Box] = []

    init() {
        self.boxes = Box.all()
    }

    func newBox(name: String, keyword: String, description: String, theme: Int){
        let box: Box = Box.newObject()
        box.name = name
        box.rawTheme = Int16(theme)
        self.boxes.append(box)
    }
    
    func getNumberOfPendingTerms(of box: Box) -> String {
        let term = box.terms as? Set<Term> ?? []
        let today = Date()
        let filteredTerms = term.filter { term in
            let srs = Int(term.rawSRS)
            guard let lastReview = term.lastReview,
                  let nextReview = Calendar.current.date(byAdding: .day, value: srs, to: lastReview)
            else { return false }

            return nextReview <= today
        }

        return filteredTerms.count == 0 ? "" : "\(filteredTerms.count)"
    }
}
