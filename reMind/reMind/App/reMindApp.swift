//
//  reMindApp.swift
//  reMind
//
//  Created by Pedro Sousa on 23/06/23.
//

import SwiftUI

@main
struct reMindApp: App {
    @Environment (\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                BoxesView()
            }
        }
        .onChange(of: scenePhase){ phase in
            switch(phase){
            case .active:
                {}()
            default:
                CoreDataStack.shared.saveContext()
            }
        }
    }
}
