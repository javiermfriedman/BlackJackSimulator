//
//  earnings.swift
//  Black Jack
//
//  Created by Javier Friedman on 7/29/24.
//

import SwiftUI

struct earnings: View {
    let color: Color
    let symbol: String
    let number: Int
    
    
    var body: some View {
        ZStack{
            Text("\(symbol) $\(number)")
                .font(.system(size: 100))
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .foregroundStyle(.black)
                .padding(.leading, 5)
            
            Text("\(symbol) $\(number)")
                .font(.system(size: 100))
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .foregroundStyle(color)
        }
    }
}

#Preview {
    earnings(color: .red, symbol: "+", number: 10)
}
