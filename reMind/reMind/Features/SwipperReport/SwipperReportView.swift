//
//  SwipperReportView.swift
//  reMind
//
//  Created by Marcos Bezerra on 19/01/24.
//

import SwiftUI

struct SwipperReportView: View {
    @State var report: [TermReport]
    @State var termsToReview: Int
    @EnvironmentObject var router: reAppRouter
    
    var body: some View {
        VStack(spacing: 0){
            Text("\(report.count)/\(termsToReview) terms were reviewed")
                .fontWeight(.bold)
                .padding(.top)
            
            List{
                if report.isEmpty{
                    Text("Nothing was reviewed")
                }
                Section{
                    ForEach(report) { term in
                        CardTermView(term: term.value ?? "Unknown",
                                     meaning: term.meaning ?? "",
                                     isReviewd: term.status)
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

    static var report = {
        var report: [TermReport] = []

        report.append(.init(value: "Term1", meaning: "Meaning 1", status: false))
        report.append(.init(value: "Term2", meaning: "Meaning 2", status: false))
        report.append(.init(value: "Term3", meaning: "Meaning 3", status: false))
        report.append(.init(value: "Term4", meaning: "Meaning 4", status: true))
        return report
    } ()
    
    static var swipeReview = SwipeReview(termsToReview: [], report: report)
    
    
    static var previews: some View {
        NavigationStack{
            SwipperReportView(report: swipeReview.report, termsToReview: 4)
                
        }
        .environmentObject(SwipperReportView_Previews.router)
    }
}
