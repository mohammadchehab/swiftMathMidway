import SwiftUI

struct ContentView: View {
    
    @ObservedObject var sliderData = SliderModel()
    @ObservedObject var numericKeyboardData = NumericKeyboardViewModel()
    
    
    @State var id : UUID = UUID()
    
    private func wireKeyboardOnEnter() {
        
        numericKeyboardData.EnterCallback = {
            // Access the current value of the binding directly
            let currentKey = numericKeyboardData.currentTextInputKey
            
            switch currentKey {
            case "inputfield.start":
                let end = sliderData.endInt
                let start = Int(numericKeyboardData.currentInput) ?? 0
                if(start > end) {
                    return
                }
                sliderData.start = numericKeyboardData.currentInput
                break
            case "inputfield.end" :
                let start = sliderData.startInt
                let end = Int(numericKeyboardData.currentInput) ?? 0
                if(end < start) {
                    return
                }
                sliderData.endInt = Int(numericKeyboardData.currentInput)!
                break
            case "inputfield.answer":
                
                let currentValue = Int(numericKeyboardData.currentInput) ?? 0
                
                if (currentValue >  Int(sliderData.currentSliderRange.upperBound)  ||
                    currentValue < Int(sliderData.currentSliderRange.lowerBound))
                    
                {
                    return
                }
                
                sliderData.sliderValue = Double(numericKeyboardData.currentInput)!
                
                break
            default:
                // Handle other cases
                break
            }
        }
    }
    
    
    
    var body: some View {
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [
                Color.blue.opacity(0.7), // Set opacity for the blue color
                Color.purple.opacity(0.9) // Set opacity for the purple color
            ]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            
            VStack (alignment: .leading) {
                Text("Let's Find The Midway For 2 Numbers")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.purple)
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 2)
                
                
                ScrollView {
                    HStack {
                        Text("From:")
                            .font(.headline)
                        
                        Text(sliderData.start)
                            .font(.title)
                            .foregroundColor(.black)
                            .frame(width: 280, height: 50, alignment: .leading) // Fixing the size of the text control
                            .background(Color.white)
                            .cornerRadius(10)
                            .padding(.horizontal, 20)
                            .onChange(of: sliderData.start) {
                                sliderData.showExplanation = false
                                sliderData.redrawSlider()
                            }
                            .onTapGesture {
                                numericKeyboardData.showKeyboard.toggle()
                                numericKeyboardData.currentTextInputKey  = "inputfield.start"
                            }
                        
                        Text("To:")
                            .font(.headline)
                        
                        
                        Text(sliderData.end)
                            .font(.title)
                            .foregroundColor(.black)
                            .frame(width: 280, height: 50, alignment: .leading)
                            .background(Color.white)
                            .cornerRadius(10)
                            .padding(.horizontal, 20)
                            .onChange(of: sliderData.end) {
                                sliderData.showExplanation = false
                                sliderData.redrawSlider()
                            }
                            .onTapGesture {
                                numericKeyboardData.showKeyboard = true
                                numericKeyboardData.currentTextInputKey  = "inputfield.end"
                            }
                        
                        
                    }
                    .padding()
                    .background(Color.yellow.opacity(0.3))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                    
                    HStack {
                        Text("What do you think is the right answer?")
                            .font(.headline)
                        
                        
                        Text(sliderData.sliderValueText)
                            .font(.title)
                            .foregroundColor(.black)
                            .frame(width: 280, height: 50, alignment: .leading)
                            .background(Color.white)
                            .cornerRadius(10)
                            .padding(.horizontal, 20)
                            .onTapGesture {
                                numericKeyboardData.showKeyboard = true
                                numericKeyboardData.currentTextInputKey  = "inputfield.answer"
                            }
                        //.onChange(of: sliderData.)
                        
                        Spacer()
                    }
                    .padding()
                    .background(Color.yellow.opacity(0.3))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                    MidwaySlider(sliderData: sliderData)
                    
                    ControlButtonsView(sliderData: sliderData)
                    
                }
                
                if numericKeyboardData.showKeyboard {
                    CustomNumericKeyboard(numericKeyboardData: numericKeyboardData)
                        .offset(x:20)
                }
            }
            
            .alert(isPresented: $sliderData.showAlert) {
                Alert(title: Text("Result"),message: Text(sliderData.finalAnswer))
            }
            
            .preferredColorScheme(.light)
            .onAppear(perform: wireKeyboardOnEnter)
        }
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
