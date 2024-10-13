//
//  RatingView.swift
//  BookWorm
//
//  Created by Abhishek Rathore on 13/10/24.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    
    var offColor = Color.gray
    var onColor = Color.yellow
    var image = Image(systemName: "star.fill")
    
    var body: some View {
        HStack{
            ForEach(1..<6, id: \.self){ number in
                Button{
                    rating = number
                }
                label:{
                    image.foregroundStyle(rating < number ? offColor : onColor )
                }
            }
        }.buttonStyle(.plain)
    }
}

#Preview {
    RatingView(rating: .constant(3))
}
