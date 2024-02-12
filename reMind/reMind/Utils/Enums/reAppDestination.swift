//
//  reDestination.swift
//  reMind
//
//  Created by Marcos Bezerra on 10/02/24.
//

import Foundation

enum reAppDestination: Hashable{
    case Boxes
    case Box(TermViewModel)
    case Swipper(SwipeReview)
    case SwipperReport(report: [TermReport], termsToReview: Int)
}
