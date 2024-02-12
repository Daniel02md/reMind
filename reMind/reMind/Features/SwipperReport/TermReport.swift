//
//  TermReport.swift
//  reMind
//
//  Created by Marcos Bezerra on 11/02/24.
//

import Foundation

struct TermReport: Identifiable, Hashable{
    let id: UUID
    let value: String?
    let meaning: String?
    let status: Bool
    
    init(value: String? = nil, meaning: String? = nil, status: Bool) {
        self.id = UUID()
        self.value = value
        self.meaning = meaning
        self.status = status
    }
}
