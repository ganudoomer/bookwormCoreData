//
//  RatingView.swift
//  bookwormCore
//
//  Created by Sree on 31/10/21.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    var label = ""
    var maximumRating = 5
    
    var offImage: Image?
    var onImage  = Image(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor  = Color.yellow
    var body: some View {
        HStack{
            if label.isEmpty == false {
                Text("label")
            }
            ForEach(1..<maximumRating + 1){ number in
                self.image(for: number).foregroundColor(number > self.rating ? self.offColor : self.onColor).onTapGesture {
                    self.rating = number
                }.accessibilityRemoveTraits(.isImage)
                    .accessibilityAddTraits(number > rating ? .isButton : [.isButton,.isSelected])
                    .accessibilityLabel("\(number == 1 ? "1 stars": "\(number) stars")")
            }
        }.accessibilityElement()
            .accessibilityLabel("Rating")
            .accessibilityValue("\(rating == 1 ? "1 stars": "\(rating) stars")")
            .accessibilityAdjustableAction { direction in
                switch direction {
                case .increment:
                    if rating < maximumRating { rating += 1  }
                case .decrement:
                    if rating < maximumRating { rating -= 1  }
                default:
                    break
                    
                }
            }
    }
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(4))
    }
}
