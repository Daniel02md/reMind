//
//  Term+CoreDataProperties.swift
//  reMind
//
//  Created by Pedro Sousa on 25/09/23.
//
//

import Foundation
import CoreData

@objc(Term)
public final class Term: NSManagedObject {

}

extension Term {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Term> {
        return NSFetchRequest<Term>(entityName: "Term")
    }

    @NSManaged public var creationDate: Date?
    @NSManaged public var identifier: UUID?
    @NSManaged public var lastReview: Date?
    @NSManaged public var meaning: String?
    @NSManaged public var rawSRS: Int16
    @NSManaged public var rawTheme: Int16
    @NSManaged public var value: String?
    @NSManaged public var boxID: Box?

}

extension Term: Identifiable{
    
}

extension Term: CoreDataModel {
    var srs: SpacedRepetitionSystem {
        return SpacedRepetitionSystem(rawValue: Int(rawSRS)) ?? SpacedRepetitionSystem.first
    }

    var theme: reTheme {
        return reTheme(rawValue: Int(self.rawTheme)) ?? reTheme.lavender
    }
}

extension Term{
    override public func awakeFromInsert() {
        super.awakeFromInsert()
        let date = Date()
        self.creationDate = date
        self.lastReview = date
        self.rawSRS = Int16(SpacedRepetitionSystem.none.rawValue)
        self.identifier = UUID()
    }
}

enum SpacedRepetitionSystem: Int {
    case none = 0
    case first = 1
    case second = 2
    case third = 3
    case fourth = 5
    case fifth = 8
    case sixth = 13
    case seventh = 21
}
