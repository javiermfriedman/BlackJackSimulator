//
//  GameManager.swift
//  Black Jack
//
//  Created by Javier Friedman on 7/26/24.
//

import Foundation
import SwiftUI

let cardBack = card(imageString: "back", suit: "B", rank: 0)

class gameClass: ObservableObject {
    @Published var Dealer = Player()
    @Published var deck: [card] = []
    @Published var playerOne = Player()
    @Published var gameStatus: String = "still playing"
    
    init(){
        buildDeck()
        deck.shuffle()
    }
    
    //start the game do everything here
    func startGame(currency: Int){
        playerOne.moneyInBank = currency
        setHand(player: Dealer)
        setHand(player: playerOne)
    }
    
    func startNewRound(){
        if deck.count < 10{
            deck.removeAll()
            buildDeck()
        }
        
        playerOne.hand.removeAll()
        Dealer.hand.removeAll()
        
        setHand(player: Dealer)
        setHand(player: playerOne)
        playerOne.moneyBet = 0
    }
    
    func setDealerCards(){
        let playerPoint = playerOne.score
        print("playerscore is \(playerPoint)")
        var points: Int = 0
        var isAce = false
        
        //calculate rank
        for card in Dealer.hand {
            if card.rank == 11{
                print("dealer has ace")
                isAce = true
            }
            points += card.rank
        }
        
        print("dealerScore \(points)")
        
        while points < playerPoint {
            //add a new card
            Dealer.addCard(thecard: getTopDeck())
            points = 0
            for card in Dealer.hand {
                points += card.rank
            }
        }
        
        print("dealerScore \(points)")
        if(points > playerPoint && isAce){
            
            points = 0
            while points < playerPoint {
                for card in Dealer.hand {
                    if card.rank == 11{
                        points += 1
                    } else {
                        points += card.rank
                    }
                    
                }
                
            }
            
        }
            
        
       
        
        print("dealerScore \(points)")
  
        
        Dealer.score = points
        print("dealerscore is \(Dealer.score)")
    }
    
    func calcuateWinner() {
        print("money in bank before is \(playerOne.moneyInBank)")
        if Dealer.score > 21 {
            gameStatus = "player won"
            playerOne.moneyInBank += playerOne.moneyBet * 2

        } else if playerOne.score > Dealer.score {
            gameStatus = "player won"
            if(playerOne.score == 21){
                playerOne.moneyInBank = playerOne.moneyBet * 3
            } else {
                playerOne.moneyInBank =  playerOne.moneyBet * 2
                
            }
            
        } else if playerOne.score == Dealer.score {
            gameStatus = "draw"
            playerOne.moneyInBank += playerOne.moneyBet
        } else {
            gameStatus = "dealer won"
        }
        
        print("money in bank after is \(playerOne.moneyInBank)")
        
    }
    
    func setHand(player: Player){
        player.setHand(cardOne: getTopDeck(), cardTwo: getTopDeck())
    }
    
    func getDealerCard() -> String {
        Dealer.getFirstCard().imageString
    }
    
    func getPlayer() -> Player{
        return playerOne
        
    }
    
    func playerHit(){
        playerOne.hand.append(getTopDeck())
        playerOne.updateScore()
    }
    
    
    func buildDeck(){
        for suit in Suit.allCases {
            for rank in 2...14 {
                let theRank: Int
                let combinedString = "\(rank)\(suit.rawValue)"
                
                if(rank < 10){
                    theRank = rank
                } else if(rank == 14){
                    theRank = 11
                } else {
                    theRank = 10
                }

                let newCard = card(imageString: combinedString, suit: suit.rawValue, rank: theRank)
//                print("\(newCard.imageString) rank is \(newCard.rank)")
                deck.append(newCard)
            }
        }
    }
    
    func getTopDeck() -> card{
        if(deck.isEmpty){
            buildDeck()
        }
        
        
        
        return deck.removeFirst()
        
    }
    
    
    
    
    
    
    
}


enum Suit: Character, CaseIterable {
    case hearts = "H"
    case diamonds = "D"
    case clubs = "C"
    case spades = "S"
}



struct card: Identifiable {
    let id = UUID()
    let imageString: String
    let suit: Character
    var rank: Int
    
    
}

enum GameError: LocalizedError {
    case busted
    
    var errorDescription: String? {
        switch self {
        case .busted:
            return "You have lost the game."
        }
    }
}
