//
//  CircularProgressView.swift
//  Trent Gets Schooled
//
//  Created by Saaz Shaikh on 31/07/2023.
//

import SwiftUI

struct CircularProgressView: View {
    
    var process: CGFloat
    
    var body: some View {
        
        ZStack{
            
            Circle ()
                .stroke(lineWidth: 20)
                .opacity(0.05)
            
            Circle()
                .trim(from: 0, to: process)
                .stroke(style: .init(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                 // this makes the round edged line in the circle
                .foregroundColor(.blue)
                .shadow(color: .green,radius: 5)
                .rotationEffect(Angle(degrees: 270))
                // to get the round edged line to start from the top of the circle 
            
            
        }
        
    }
}

struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView(process: 0.25)
    }
}
