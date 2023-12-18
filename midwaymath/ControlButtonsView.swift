//
//  ControlButtonsView.swift
//  midwaymath
//
//  Created by Mohammad_Shehab on 15/12/2023.
//

import SwiftUI

struct ControlButtonsView : View {
    
    @ObservedObject var sliderData = SliderModel()
    
    var explanationText: some View {
        Text("""
            Explanation:
            
            The midpoint between \(sliderData.start) and \(sliderData.end) is calculated using the formula:
            
            Midpoint = (Start Value + End Value) / 2
            
            Midpoint = (\(sliderData.start.trimmingCharacters(in: .whitespaces)) + \(sliderData.end))/ 2 = \(Int(sliderData.sliderValue))
            
            The formula divides the sum of the start and end values by 2 to find the point equidistant between them.
            """)
        .font(.title2)
        .multilineTextAlignment(.center)
        .padding()
        .fixedSize(horizontal: false, vertical: true)
    }
    
    var body : some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    sliderData.sliderValue = sliderData.currentSliderRange.lowerBound
                }) {
                    Image(systemName: "arrow.left.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.blue)
                        .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 3)
                }
                
                Button(action: {
                    sliderData.sliderValue = sliderData.currentSliderRange.upperBound
                }) {
                    Image(systemName: "arrow.right.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.green)
                        .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 3)
                }
                .padding()
                Spacer()
            }
            
            HStack {
                Spacer() 
                Button("Retry  🔄") {
                    sliderData.reset()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 3)
                
                Button("Check My Answer 🤔") {
                    sliderData.validateAnswer()
                }
                .padding()
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 3)
                
                Button("I Give Up! 💢") {
                    sliderData.giveUp()
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 3)
                Spacer()
            }
            
            
            if sliderData.showExplanation {
                explanationText
                    .font(.title3)
                    .padding()
                    .background(Color.yellow.opacity(0.3))
                    .cornerRadius(10)
                    .padding()
            }
            
            Text("Score: \(sliderData.score) \(sliderData.score < 0 ? "😞" : "😊")")
                .font(.headline)
                .padding()
                .foregroundColor(.white)
                .background(sliderData.score < 0 ? Color.red : Color.green)
                .cornerRadius(10)
                .padding(.horizontal)
                .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 3)
        }
    }
}

struct ControlButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        ControlButtonsView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}

