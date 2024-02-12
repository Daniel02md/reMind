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
    @StateObject var router = reAppRouter(navigationPath: .init())
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navigationPath){
                BoxesView()
                    .navigationDestination(for: reAppDestination.self){ destination in
                        switch destination{
                            case .Boxes:
                                BoxesView()
                            case .Box(let vm):
                                BoxView()
                                .environmentObject(vm)
                            
                            case .Swipper(let swipeReview):
                                SwipperView(review: swipeReview)
                                .navigationBarBackButtonHidden(true)
                            
                            case .SwipperReport(report: let report, termsToReview: let terms):
                                SwipperReportView(report: report, termsToReview: terms)
                                .navigationBarBackButtonHidden(true)
                        }
                    }
            }
            .environmentObject(router)
        }
        .onChange(of: scenePhase){ phase in
            switch(phase){
            case .active:
                break
            default:
                CoreDataStack.shared.saveContext()
            }
        }
    }
}
