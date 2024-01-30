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
                BoxesView(viewModel: BoxViewModel())
            }
        }
        .onChange(of: scenePhase){ phase in
            if phase == .background{
                CoreDataStack.shared.saveContext()
            }
        }
    }
}
