//
//  BoxViewModel.swift
//  reMind
//
//  Created by Pedro Sousa on 17/07/23.
//

import Foundation

class BoxViewModel: ObservableObject, Hashable{
    @Published var boxes: [Box] = []
    @Published private var boxWillChange: Void = ()

    init() {
        self.boxes = Box.all()
        self.boxes.forEach{
            $0.objectWillChange.assign(to: &$boxWillChange)
        }
    }

    func newBox(name: String, keyword: String, description: String, theme: Int){
        let box: Box = Box.newObject()
        box.objectWillChange.assign(to: &$boxWillChange)
        box.name = name
        box.rawTheme = Int16(theme)
        self.boxes.append(box)
    }
    
    func updateBox(box: Box, name: String? = nil, keyword: String? = nil, description: String? = nil, theme: Int? = nil){
        box.name = name ?? box.name
        box.rawTheme = Int16(theme ?? Int(box.rawTheme))
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

extension BoxViewModel{
    static func == (lhs: BoxViewModel, rhs: BoxViewModel) -> Bool {
        return lhs.boxes == rhs.boxes
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.boxes)
    }
}
