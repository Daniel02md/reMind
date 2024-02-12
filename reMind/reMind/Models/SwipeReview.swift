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
    var report: [TermReport] = []
    var count: Int{
        termsReviewed.count + termsToReview.count
    }
    
    @discardableResult
    mutating func correct() -> Bool{
        if termsToReview.first != nil{
            let removedTerm = termsToReview.remove(at: 0)
            removedTerm.rawSRS = Int16(removedTerm.srs.next().rawValue)
            report.append(.init(value: removedTerm.value,
                                meaning: removedTerm.meaning,
                                status: true))
            termsReviewed.append(removedTerm)
            return true
        }
        return false
    }
    
    @discardableResult
    mutating func wrong() -> Bool{
        if termsToReview.first != nil{
            let removedTerm = termsToReview.remove(at: 0)
            removedTerm.rawSRS = Int16(removedTerm.srs.before().rawValue)
            report.append(.init(value: removedTerm.value,
                                meaning: removedTerm.meaning,
                               status: false))
            termsReviewed.append(removedTerm)
            return true
        }
        return false
    }
}

extension SwipeReview: Hashable{
    static func == (lhs: SwipeReview, rhs: SwipeReview) -> Bool {
        return lhs.termsToReview == rhs.termsToReview &&
               lhs.termsReviewed == rhs.termsReviewed &&
               lhs.report == rhs.report
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.report)
        hasher.combine(self.termsToReview)
        hasher.combine(self.termsReviewed)
    }
}
