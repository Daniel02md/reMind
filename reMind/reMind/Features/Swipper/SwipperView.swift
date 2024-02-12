//
//  SwipperView.swift
//  reMind
//
//  Created by Pedro Sousa on 03/07/23.
//

import SwiftUI

struct SwipperView: View {
    @EnvironmentObject var router: reAppRouter
    @State var review: SwipeReview
    @State private var direction: SwipperDirection = .none

    var body: some View {
        VStack {
            SwipperLabel(direction: $direction)
                .padding()

            Spacer()

            SwipperCard(direction: $direction,
                frontContent: {
                    Text(review.termsToReview.first?.value ?? "Fim")
                }, backContent: {
                    Text(review.termsToReview.first?.meaning ?? "Fim")
                })

            Spacer()

            Button(action: {
                router.navigate(to: .SwipperReport(report: review.report,
                                                   termsToReview: review.count))
            }, label: {
                Text("Finish Review")
                    .frame(maxWidth: .infinity, alignment: .center)
            })
            .buttonStyle(reButtonStyle())
            .padding(.bottom, 30)
                
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(reBackground())
        .navigationTitle("\(review.termsToReview.count) terms left")
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: direction){ newValue in
            switch newValue{
            case .right:
                review.correct()
            case .left:
                review.wrong()
            default:
                break
            }
        }
        .onChange(of: review){ _ in
            if review.termsToReview.isEmpty{
                router.navigate(to: .SwipperReport(report: review.report,
                                                   termsToReview: review.count))
            }
        }
    }
}

struct SwipperView_Previews: PreviewProvider {
    
    @StateObject static var router = reAppRouter(navigationPath: .init())
    
    static var termsToReview = {
        var termsToReview: [Term] = []
        let term1 = Term(context: CoreDataStack.inMemory.managedContext)
        term1.value = "Wrong"
        term1.meaning = "Meaning goes here..."
        term1.rawSRS = 1
        
        
        let term2 = Term(context: CoreDataStack.inMemory.managedContext)
        term2.value = "Wrong2"
        term2.meaning = "Meaning goes here 2"
        term2.rawSRS = 1
        
        
        let term3 = Term(context: CoreDataStack.inMemory.managedContext)
        term3.value = "Front Value"
        term3.meaning = "Meaning"
        term3.rawSRS = 1
        
        let term4 = Term(context: CoreDataStack.inMemory.managedContext)
        term4.value = "Front Value 2"
        term4.meaning = "Description 2"
        term4.rawSRS = 1
        
        termsToReview.append(contentsOf: [term1, term2, term3, term4])
        return termsToReview
    } ()
    
    static var swipeReview = SwipeReview(termsToReview: termsToReview)
    static var previews: some View {
        NavigationStack (path: $router.navigationPath){
            SwipperView(review: SwipperView_Previews.swipeReview)
        }
        .environmentObject(router)
    }
}
