//
//  TodaysCardsView.swift
//  reMind
//
//  Created by Pedro Sousa on 03/07/23.
//

import SwiftUI

struct TodaysCardsView: View {
    @State var numberOfPendingCards: Int
    @State var theme: reTheme
    @State private var isSwipping: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading, spacing: 8) {
                Text("Today's Cards")
                    .font(.title)
                    .fontWeight(.semibold)
                Text("\(numberOfPendingCards) cards to review")
                    .font(.title3)
                
                Button(action: {
                    isSwipping = true
                }, label: {
                    Text("Start Swipping")
                        .frame(maxWidth: .infinity)
                })
                .buttonStyle(reColorButtonStyle(.mauve))
                .padding(.top, 10)
                .navigationDestination(isPresented: $isSwipping){
                    SwipperView(review: SwipeReview(termsToReview: [
                        Term.newObject()
                    ]))
                    .navigationBarBackButtonHidden(true)
                }
            }
            .padding(.vertical, 16)
        }
    }
}

struct TodaysCardsView_Previews: PreviewProvider {
    static var previews: some View {
        TodaysCardsView(numberOfPendingCards: 10, theme: .mauve)
            .padding()
    }
}
