//
//  NumericKeyboardViewModel.swift
//  midwaymath
//
//  Created by Mohammad_Shehab on 15/12/2023.
//

import Foundation


class NumericKeyboardViewModel : ObservableObject {
    
    @Published var currentInput : String = ""
    @Published var showKeyboard : Bool = false
    @Published var currentTextInputKey = ""
    var EnterCallback: (() -> Void)?
}
