//
//  TodaysCardsView.swift
//  reMind
//
//  Created by Pedro Sousa on 03/07/23.
//

import SwiftUI

struct TodaysCardsView: View {
    @EnvironmentObject var router: reAppRouter
    @EnvironmentObject var viewModel: TermViewModel
    var pending: Int
    var theme: reTheme
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Today's Cards")
                .font(.title)
                .fontWeight(.semibold)
            Text("\(pending) cards to review")
                .font(.title3)
            
            Button(action: {
                if pending > 0{
                    router.navigate(to: .Swipper(SwipeReview(
                        termsToReview: viewModel.termsToReview)))
                }
            }, label: {
                Text("Start Swipping")
                    .frame(maxWidth: .infinity)
            })
            .buttonStyle(reColorButtonStyle(theme,
                                            pending > 0 ? 1 : 0.50))
            .padding(.top, 10)
        }
        .padding(.vertical, 16)
    }
}

struct TodaysCardsView_Previews: PreviewProvider {
    @ObservedObject static var router = reAppRouter(navigationPath: .init())
    @ObservedObject static var viewModel = TermViewModel(box:.newObject())
    static var previews: some View {
        TodaysCardsView(pending: 0, theme: .mauve)
            .environmentObject(router)
            .environmentObject(viewModel)
            .padding()
    }
}
