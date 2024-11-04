//
//  playerClass.swift
//  Black Jack
//
//  Created by Javier Friedman on 7/26/24.
//

import SwiftUI

class Player: ObservableObject {
    //each player will have an array of two cards
    @Published var hand: [card] = []
    @Published var score: Int = 0
    @Published var moneyInBank = 0
    @Published var moneyBet = 0

    
    
    
    func setHand(cardOne: card, cardTwo: card)
    {
        hand.append(cardOne)
        hand.append(cardTwo)
        var setscore = cardOne.rank + cardTwo.rank
        if(setscore ==  22){
            setscore = 12
        }
        score = setscore
    }
    
    func getFirstCard() -> card{
        return hand.first ?? cardBack
        
    }
    
    func addCard(thecard: card){
        hand.append(thecard)
        
    }
    
    func addToBet(money: Int){
        moneyInBank -= money
        moneyBet += money

    }
    
    func getSecondCard() -> card
    {
        return hand.last ?? cardBack
        
    }
    
    func updateScore() {
        var numAces: Int = 0
        var currentScore: Int = 0
            
            for card in hand {
                if(card.rank == 11){
                    numAces += 1
                    print("ace is present")
                }
                currentScore += card.rank
            }
        
        
        
        if(currentScore > 21 && numAces > 0){
            print("redoing because of ace")
            currentScore = 0
            
            //count but for ace make it 1
            for card in hand {
                if(card.rank == 11){
                    currentScore += 1
                } else {
                    currentScore += card.rank
                    
                }
                
            }
            
        }
            
            
        score = currentScore
    
        
        
    }
    
}
