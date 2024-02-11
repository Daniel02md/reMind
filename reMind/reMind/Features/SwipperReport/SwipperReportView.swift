//
//  SwipperReportView.swift
//  reMind
//
//  Created by Marcos Bezerra on 19/01/24.
//

import SwiftUI

struct SwipperReportView: View {
    @State var swipeReview: SwipeReview
    @EnvironmentObject var router: reAppRouter
    
    var body: some View {
        VStack(spacing: 0){
            Text("\(swipeReview.termsReviewed.count)/\(swipeReview.termsToReview.count) terms were reviewed")
                .fontWeight(.bold)
                .padding(.top)
            
            List{
                Section{
                    ForEach(swipeReview.termsReviewed) { term in
                        CardTermView(term: term.value!, meaning: term.meaning!, isReviewd: false)
                    }
                }
                .tint(Palette.reBlack.render)
            }
            
            .padding(.top, -15)
            .shadow(color: Palette.reBlack.render.opacity(0.15), radius: 6)
            .scrollContentBackground(.hidden)
            .background(.clear)
            
            
            Button{
                router.navigateBackward(step: 2)
            } label: {
                Text("Close Report")
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .buttonStyle(reButtonStyle())
            .padding(.bottom, 30)
            .padding(.horizontal)
            
        }
        
        .background(reBackground())
        .navigationTitle("Swipper Report")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SwipperReportView_Previews: PreviewProvider {
    @StateObject static var router = reAppRouter(navigationPath: .init())

    static var reviewdTerms = {
        var reviewdTerms: [Term] = []
        let term1 = Term(context: CoreDataStack.inMemory.managedContext)
        term1.value = "Front Value"
        term1.meaning = "Meaning"
        
        let term2 = Term(context: CoreDataStack.inMemory.managedContext)
        term2.value = "Front Value 2"
        term2.meaning = "Description 2"
        
        reviewdTerms.append(contentsOf: [term1, term2])
        return termsToReview
    } ()
    
    static var termsToReview = {
        var termsToReview: [Term] = []
        let term1 = Term(context: CoreDataStack.inMemory.managedContext)
        term1.value = "Wrong"
        term1.meaning = "Meaning goes here..."
        
        
        let term2 = Term(context: CoreDataStack.inMemory.managedContext)
        term2.value = "Wrong2"
        term2.meaning = "Meaning goes here 2"
        
        termsToReview.append(contentsOf: [term1, term2])
        return termsToReview
    } ()
    
    static var swipeReview = SwipeReview(termsToReview: termsToReview, termsReviewed: reviewdTerms)
    
    
    static var previews: some View {
        NavigationStack{
            SwipperReportView(swipeReview: swipeReview)
                
        }
        .environmentObject(SwipperReportView_Previews.router)
    }
}
