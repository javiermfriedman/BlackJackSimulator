//
//  LoadingScreen.swift
//  Black Jack
//
//  Created by Javier Friedman on 7/26/24.
//

import SwiftUI

struct homePage: View {
    @State var showBuyInView = false
    
    var body: some View {
        ZStack{
            Image("tableBG")
                .resizable().ignoresSafeArea()
//            Color.green.ignoresSafeArea()
            VStack{
                Text("BLACK JACK")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 40)
                Text("by Javi")
                
                Spacer()
                if !showBuyInView {
                    Button{
                        showBuyInView = true
                    }label: {
                        Text("PLAY")
                    }
                }
               
                Spacer()
            }
             
            if(showBuyInView){
                LoadingScreen(showview: $showBuyInView)
            }
        }
    }
}
struct LoadingScreen: View {
    @Binding var showview: Bool
    @State var showPlayButton: Bool = false
    @State var numberInput: String = ""
    @State var playGame: Bool = false
    @State var money: Int = 0
    @StateObject var game = gameClass()
    
    
    
    
    
    var body: some View {
        
            
            VStack(content: {
                Text("How much will you buy in for")
                    .font(.headline)
                    .foregroundStyle(.white)
                HStack(spacing: 0){
                    Text("$")
                        .font(.system(size: 50))
                        .fontWeight(.bold)
                        .foregroundColor(.white)  // Changed from .foregroundStyle(.white)
                        .background(Color("greenType"))
                    TextField("TAP", text: $numberInput)
                        .font(.system(size: 50))
                        .fontWeight(.bold)
                        .foregroundColor(.white)  // Changed from .foregroundStyle(.white)
                        .background(Color("greenType"))

                        .keyboardType(.numberPad)
                        .textFieldStyle(PlainTextFieldStyle())
                        .frame(width: 140) // Center the text within the TextField
                        .accentColor(.clear)
                        .onChange(of: numberInput, initial: false) { oldValue, newValue in
                                                
                            money = Int(newValue) ?? 0
            
                                if money > 0 {


                                    showPlayButton = true
                                    
                                } else {
                                    showPlayButton = false
                                }
                                

                            }
                                
                    
                }
                    
                
                if(showPlayButton){
                    
                    
                    Button{
                        playGame = true

                        
                    }label: {
                        Image(systemName: "play.square")
                            .resizable()
                            .background(Color.green)
                            .frame(width: 50, height: 50)
                            
                            
                    }
                }

            })
            .fullScreenCover(isPresented: $playGame, onDismiss: {
                showPlayButton = false
                showview = false
            }, content: {
                GameBoard(money: $money, playGame: $playGame, game: game, player: game.playerOne)
            })
          
                
            
            
            
        
        
    }
}

#Preview {
    homePage()
//    LoadingScreen(numberInput: "10")
}

