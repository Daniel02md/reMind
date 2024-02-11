//
//  reAppRouter.swift
//  reMind
//
//  Created by Marcos Bezerra on 10/02/24.
//

import Foundation
import SwiftUI

final class reAppRouter: Router{
    @Published var navigationPath: NavigationPath
    
    
    init(navigationPath: NavigationPath){
        self.navigationPath = navigationPath
    }
    
    func navigate(to destination: reAppDestination) {
        
    }
    
    func navigateBackward() {
        navigationPath.removeLast()
    }
    
    func navigateBackward(step index: Int) {
        navigationPath.removeLast(index)
    }
    
    func navigateToRoot() {
        navigationPath.removeLast(navigationPath.count)
    }
    
    
}
