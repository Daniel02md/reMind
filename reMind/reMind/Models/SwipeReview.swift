//
//  SwipeReview.swift
//  reMind
//
//  Created by Pedro Sousa on 04/07/23.
//

import Foundation

struct SwipeReview {
    var termsToReview: [Term]
    var termsReviewed: [Term] = []
}

extension SwipeReview: Hashable{
    static func == (lhs: SwipeReview, rhs: SwipeReview) -> Bool {
        return lhs.termsToReview == rhs.termsToReview && lhs.termsReviewed == rhs.termsReviewed
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.termsToReview)
        hasher.combine(self.termsReviewed)
    }
}
