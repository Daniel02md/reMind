//
//  Box+CoreDataClass.swift
//  reMind
//
//  Created by Pedro Sousa on 25/09/23.
//
//

import Foundation
import CoreData

@objc(Box)
public final class Box: NSManagedObject {

}

extension Box {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Box> {
        return NSFetchRequest<Box>(entityName: "Box")
    }

    @NSManaged public var identifier: UUID?
    @NSManaged public var name: String?
    @NSManaged public var boxDescription: String?
    @NSManaged public var keywords: String?
    @NSManaged public var rawTheme: Int16
    @NSManaged public var createdAt: Date
    @NSManaged public var terms: NSSet?

}

// MARK: Generated accessors for terms
extension Box {

    @objc(addTermsObject:)
    @NSManaged public func addToTerms(_ value: Term)

    @objc(removeTermsObject:)
    @NSManaged public func removeFromTerms(_ value: Term)

    @objc(addTerms:)
    @NSManaged public func addToTerms(_ values: NSSet)

    @objc(removeTerms:)
    @NSManaged public func removeFromTerms(_ values: NSSet)

}

extension Box : Identifiable {

}

extension Box: CoreDataModel {
    var theme: reTheme {
        return reTheme(rawValue: Int(self.rawTheme)) ?? reTheme.lavender
    }

    var numberOfTerms: Int { self.terms?.count ?? 0 }
}

extension Box{
    override public func awakeFromInsert() {
        super.awakeFromInsert()
        self.createdAt = Date()
        self.identifier = UUID()
    }
}

enum reTheme: Int {
    case mauve = 0
    case lavender
    case aquamarine

    var name: String {
        switch self {
        case .aquamarine:
            return "aquamarine"
        case .mauve:
            return "mauve"
        case .lavender:
            return "lavender"
        }
    }
}
