//
//  playerHand view.swift
//  Black Jack
//
//  Created by Javier Friedman on 7/29/24.
//

import SwiftUI


struct playerHandView: View {
    @Binding var showView: Bool
    @ObservedObject var game: gameClass
    
    var body: some View {
        ZStack {
            Color.brown.ignoresSafeArea()
            
            VStack{
                ZStack{
                    Rectangle()
                        .fill(Color("brownType"))
                        .stroke(Color.black, lineWidth: 2)

                        .frame(width: 300, height: 60)
                    Text("CURRENT SCORE: \(game.playerOne.score)")
                        .font(.title3)
                        .fontWeight(.semibold)

                }
                .padding(.top, 35)
                                
                HStack(spacing: -50) {
                    ForEach(game.getPlayer().hand) { card in
                        ZStack{
                            Image(card.imageString)
                                .resizable()
                                .frame(width: 120, height: 190)
                        }
                    }
                }
                .padding(.bottom, 10)
            }
        }
    }
}
#Preview {
    playerHandView(showView: .constant(true), game: gameClass())
}
