import SwiftUI
import Combine

class SliderModel: ObservableObject {
    @Published var id: UUID = UUID()
    @Published var currentSliderRange: ClosedRange<Double> = 0.0...10.0
    @Published var start: String = " 0"
    @Published var end: String = " 10"
    @Published var sliderValue: Double = 0.0
    @Published var showExplanation: Bool = false
    @Published var finalAnswer: String = ""
    @Published var showAlert: Bool = false
    @Published var score: Int = 0
    @Published var inputText: String = ""
    
    func submit() {
        
        if(startInt > endInt) {
            print ("not going to submit")
            return
        }
        
        currentSliderRange = Double(startInt)...Double(endInt)
        sliderValue = Double(startInt)
        id = UUID()
    }
   
    var endInt: Int {
        get {
            return Int(end.trimmingCharacters(in: .whitespaces)) ?? 0
        }
        set(newEndInt) {
            // Perform some action with newEndInt
            // For example, updating 'end' with a string representation of newEndInt
            end = " " + String(newEndInt)
        }
    }

    var sliderValueText : String {
        get  {
            return String(Int(sliderValue))
        }
    }
    
    var startInt : Int {
        get {
            return Int(start.trimmingCharacters(in: .whitespaces)) ?? 0
        }
        set(newStartInt){
            start = " " + String(newStartInt)
        }
    }
    
    func reset() {
        currentSliderRange = 0.0...10.0
        showExplanation = false
        id = UUID()
        start = "0"
        end = "10"
        sliderValue = 0.0
        finalAnswer = ""
        //sliderValueText = ""
        score = 0
    }
    
    func redrawSlider(){
        currentSliderRange = Double(startInt)...Double(endInt)
        id = UUID()
    }
    
    func validateAnswer() {
        
        let midpoint = (startInt + endInt) / 2
        if Int(sliderValue) == midpoint {
            finalAnswer = "Yay! You got it!"
            showAlert = true
            showExplanation = true
            score += 10 // Increment score on correct answer
        } else {
            finalAnswer = "Oops! Wrong. Try again."
            showAlert = true
            // Implement beep sound here
            score -= 5 // Decrement score on incorrect answer
        }
    }
    
    func giveUp() {
        showExplanation = true
        let midpoint = (startInt + endInt) / 2
        sliderValue = Double(midpoint)
        score -= 3 // Deduct score when giving up
    }
}
