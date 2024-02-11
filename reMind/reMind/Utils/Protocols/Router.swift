//
//  Router.swift
//  reMind
//
//  Created by Marcos Bezerra on 10/02/24.
//

import Foundation
import SwiftUI

protocol Router: AnyObject, ObservableObject{
    associatedtype Destination: Hashable
    
    var navigationPath: NavigationPath{get}
    
    func navigate(to destination: Destination)
    func navigateBackward()
    func navigateBackward(step index: Int)
    func navigateToRoot()
}

