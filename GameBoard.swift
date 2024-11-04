import SwiftUI

struct GameBoard: View {
    @Binding var money: Int
    @Binding var playGame: Bool
    @ObservedObject var game: gameClass
    @ObservedObject var player: Player
    
    @State private var showFirstCard = false
    @State private var showSecondCard = false
    
    @State private var playNextRound: Bool = false
    
    @State private var showPlayerHand: Bool = false
    @State private var showMoneyBetting: Bool = true
    
    @State private var busted = false
    
    @State private var showPostHand = false
    @State private var showDealerHand = false
    
    @State private var showEarnings = false
    
    @State var canHit = false
    
    // New state variable to manage button visibility
    @State private var showPlayNextRoundButton: Bool = false
    
    var body: some View {
        ZStack {
            Image("background-plain")
            
            //X button
            VStack{
                HStack{
                    Button{
                        playGame = false
                    } label: {
                        Image(systemName: "x.square")
                            .resizable()
                            .foregroundStyle(.black)
                            .frame(width: 30, height: 30)
                            .padding(.top, 80)
                            .padding(.leading, 40)
                        
                    }
                        
                    Spacer()
                }
                Spacer()
            }
            
            
            VStack {
                
                // Dealer hand view
                if(!showMoneyBetting){
                    Text("Dealer's Hand")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .padding(.top, 30)
                    
                }else {
                    Text("Dealer's Hand")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.clear)
                        .padding(.top, 30)
                    
                }
                
                
                // Dealer cards
                ZStack {
                    if !showDealerHand {
                        HStack {
                            if showFirstCard {
                                Image("back")
                                    .resizable()
                                    .frame(width: 135, height: 203)
                                    .padding(.leading, 40)
                                    .padding(.top, 40)
                                
                            } else {
                                Rectangle()
                                    .fill(.clear)
                                    .frame(width: 155, height: 243)
                            }
                        }
                    }
                    
                    //showing dealer cards
                    HStack {
                        if !showDealerHand {
                            if showSecondCard {
                                Image(game.getDealerCard())
                                    .resizable()
                                    .frame(width: 130, height: 200)
                                    .padding(.trailing, 40)
                            }
                        } else {
                            HStack{
                                if game.Dealer.hand.count < 4{
                                    ForEach(game.Dealer.hand) { card in
                                        Image(card.imageString)
                                            .resizable()
                                            .frame(width: 130, height: 200)
                                    }
                                    .padding(.leading, -65)
                                    
                                } else {
                                    ForEach(game.Dealer.hand) { card in
                                        Image(card.imageString)
                                            .resizable()
                                            .frame(width: 130, height: 200)
                                    }
                                    .padding(.leading, -95)
                                    
                                    
                                }
                                
                            }
                            .padding(.leading, 95)
                            
                            
                        }
                    }
                    
                    
                    // Earnings
                    if busted || game.gameStatus != "still playing" {
                        if busted {
                            earnings(color: .red, symbol: "-", number: game.playerOne.moneyBet)
                        } else if game.gameStatus == "player won" {
                            earnings(color: .green, symbol: "+", number: game.playerOne.moneyBet)
                        } else if game.gameStatus == "dealer won" {
                            earnings(color: .red, symbol: "-", number: game.playerOne.moneyBet)
                        } else if game.gameStatus == "draw" {
                            earnings(color: .gray, symbol: "+", number: 0)
                        }
                    }
                }
                .padding()
                
                // Currency display
                ZStack {
                    Rectangle()
                        .fill(.yellow)
                        .stroke(Color.black, lineWidth: 4)
                        .frame(width: 240, height: 40)
                    
                    Text("Money Bet: $\(player.moneyBet)")
                        .font(.title)
                        .bold()
                }
                
                // Hit buttons
                HStack(spacing: 20) {
                    
                    if(canHit){
                        Button {
                            game.playerHit()
                            showPlayerHand = true
                            if game.playerOne.score > 21 {
//                                game.playerOne.moneyInBank -= game.playerOne.moneyBet
                                busted = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    showEarnings = true
                                    showDealerHand = true
                                }
                            }
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                                    .fill(.blue)
                                    .stroke(Color.black, lineWidth: 4)
                                    .frame(width: 160, height: 70)
                                
                                Text("HIT")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.black)
                            }
                        }
                        
                        // Stand button
                        Button {
                            
                            showDealerHand = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                showPlayerHand = true
                                //set the dealers hand
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    game.setDealerCards()
                                    //have another dispatch queuee
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                        game.calcuateWinner()
                                        //have another dispatch queuee
                                    }
                                }
                            }
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                                    .fill(.indigo)
                                    .stroke(Color.black, lineWidth: 4)
                                    .frame(width: 160, height: 70)
                                
                                Text("STAND")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.black)
                            }
                        }
                    } else {
                        ZStack {
                            RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                                .fill(.blue)
                                .stroke(Color.black, lineWidth: 4)
                                .frame(width: 160, height: 70)
                            
                            Text("HIT")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.black)
                        }
                        ZStack {
                            RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                                .fill(.indigo)
                                .stroke(Color.black, lineWidth: 4)
                                .frame(width: 160, height: 70)
                            
                            Text("STAND")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.black)
                        }

                    }
                    
                }
                
                ZStack {
                    if showPlayerHand { 
                        playerHandView(showView: $showPlayerHand, game: game)
                    } else if showMoneyBetting {
                        moneyBettingView(showView: $showMoneyBetting, player: game.playerOne)
                            .onDisappear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    showFirstCard = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        showSecondCard = true
                                        canHit = true
                                    }
                                }
                            }
                    } else {
                        VStack {
                            Spacer()
                            
                            if showSecondCard {
                                Text("Swipe up to see hand")
                                    .font(.title)
                            }
                        }
                    }
                    
                    if busted || game.gameStatus != "still playing" {
                        VStack {
                           
                            
                            Spacer()
                            if showPlayNextRoundButton {
                                Button {
                                    showMoneyBetting = true
                                    showPlayerHand = false
                                    showDealerHand = false
                                    showEarnings = false
                                    showFirstCard = false
                                    showSecondCard = false
                                    showPlayNextRoundButton = false
                                    game.gameStatus = "still playing"
                                    busted = false
                                    game.startNewRound()
                                } label: {
                                    ZStack {
                                        RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                                            .fill(.green)
                                            .stroke(Color.black, lineWidth: 2)
                                            .frame(width: 250, height: 100)
                                        
                                        Text("Play Next Round")
                                            .font(.title)
                                            .bold()
                                            .foregroundStyle(.white)
                                    }
                                }
                                .padding()
                            }
                        }
                        .onAppear {
                            // Delay the appearance of the button
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // Adjust the delay as needed
                                showPlayNextRoundButton = true
                            }
                        }
                    }
                }
            }
            .safeAreaInset(edge: .top, spacing: 0) {
                Color.clear.frame(height: 50) // Adds padding at the top
            }
            .safeAreaInset(edge: .bottom, spacing: 20) {
                Color.clear.frame(height: 50) // Adds padding at the bottom
            }
        }
        .gesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.height < -100 && showSecondCard { // Adjust threshold as needed
                        showPlayerHand = true
                    }
                }
        )
        .onAppear {
            game.startGame(currency: money)
        }
    }
}

#Preview {
    GameBoard(money: .constant(1), playGame: .constant(true), game: gameClass(), player: Player())
}
