//
//  MoneyBettingView.swift
//  Black Jack
//
//  Created by Javier Friedman on 7/29/24.
//

import SwiftUI

struct moneyBettingView: View {
    @Binding var showView: Bool
    @ObservedObject var player: Player
    
    var body: some View {
        ZStack {
            Color("MustardType").ignoresSafeArea()
            
            VStack{
                ZStack{
                    Rectangle()
                        .fill(.yellow)
                        .stroke(Color.black, lineWidth: 2)

                        .frame(width: 300, height: 60)
                    Text("AMOUNT IN THE BANK: $\(player.moneyInBank)")
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                .padding(.top, 40)
                
                Text("HOW MUCH WILL YOU BET?")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .font(.title)
                    .foregroundStyle(.white)
                
                HStack {
                    if player.moneyInBank >= 1{
                    Button{
                        player.addToBet(money: 1)
                    }label: {
                        customChip(color: .white, cost: 1, player: player)
                        
                    }
                    } else {
                        customChip(color: .red, cost: 1, player: player)
                        
                    }
                    if player.moneyInBank >= 5{
                    Button{
                        player.addToBet(money: 5)
                    }label: {
                        customChip(color: .blue, cost: 5, player: player)
                    }
                    } else {
                        customChip(color: .red, cost: 5, player: player)
                        
                    }
                    
                    if player.moneyInBank >= 25{
                    Button{
                        player.addToBet(money: 25)
                    }label: {
                        customChip(color: .green, cost: 25, player: player)
                        
                    }
                    } else {
                        customChip(color: .red, cost: 25, player: player)
                        
                    }
                    if player.moneyInBank >= 100{
                        Button{
                            player.addToBet(money: 100)
                        }label: {
                            customChip(color: .purple, cost: 100, player: player)
                            
                        }
                    } else {
                        customChip(color: .red, cost: 100, player: player)
                        
                    }
                    
                    
                }
            }
            if player.moneyBet > 0 {
                VStack{
                    HStack{
                        
                        Button{
                            showView = false
                            
                        }label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                    .fill(Color("greenType"))
                                    .frame(width: 200, height: 50)
                                Text("Done Betting")
                                    .font(.headline)
                                    .foregroundStyle(.white)
                            }
                        }
                        .padding(.horizontal, 30)
                        .padding(.top, 6)
                        
                        
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
        
    }
}

struct customChip: View {
    let color: Color
    let cost: Int
    @ObservedObject var player: Player
    
    
    var body: some View {
        
        ZStack{
            Ellipse()
                .fill(color)
                .stroke(Color.black, lineWidth: 5)
                .frame(width: 90, height: 90)
            Text("$\(cost)")
                .font(.title)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .foregroundStyle(Color(.yellow))
            
            
        }
        
            

    }
}

#Preview {
    moneyBettingView(showView: .constant(true), player: Player())
}
