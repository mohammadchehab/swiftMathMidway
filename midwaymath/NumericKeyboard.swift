import SwiftUI

struct CustomNumericKeyboard: View {
    
    @ObservedObject var numericKeyboardData  = NumericKeyboardViewModel()
    
    let rows: [[String]] = [
        ["7", "8", "9"],
        ["4", "5", "6"],
        ["1", "2", "3"],
        ["Clear", "0", "Enter"]
    ]
    

    var body: some View {
        VStack(spacing: 10) {
            Text(numericKeyboardData.currentInput)
                .font(.title)
                .foregroundColor(.black)
                .frame(width: 280, height: 50) // Fixing the size of the text control
                .background(Color.white)
                .cornerRadius(10)
                .padding(.horizontal, 20)
            
            ForEach(rows, id: \.self) { row in
                HStack(spacing: 10) {
                    ForEach(row, id: \.self) { key in
                        Button(action: {
                            self.handleKeyPress(key)
                        }) {
                            Text(key)
                                .frame(width: 70, height: 70)
                                .font(.title)
                                .foregroundColor(.black)
                                .background(
                                    key == "Enter" ? Color.green : Color.yellow.opacity(0.5)
                                )
                                .cornerRadius(15)
                        }
                    }
                }
            }
        }
        .padding()
              .background(Color.gray.opacity(1))
              .cornerRadius(20)
              .shadow(radius: 5)
    }
    
    func handleKeyPress(_ key: String) {
        if key == "Clear" {
            numericKeyboardData.currentInput = ""
            numericKeyboardData.currentTextInputKey = ""
        } else if key == "Enter" {
            numericKeyboardData.showKeyboard = false
            numericKeyboardData.EnterCallback?()
            numericKeyboardData.currentInput = ""
            numericKeyboardData.currentTextInputKey = ""
          
        } else {
            numericKeyboardData.currentInput.append(key)
        }
    }
}

struct CustomNumericKeyboard_Previews: PreviewProvider {
    static var previews: some View {
        let numericKeyboardData = NumericKeyboardViewModel()
        CustomNumericKeyboard(numericKeyboardData: numericKeyboardData)
    }
}
