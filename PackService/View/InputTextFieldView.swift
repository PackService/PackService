//
//  InputTextFieldView.swift
//  PackService
//
//  Created by 박윤환 on 2023/01/05.
//

import UIKit
import SwiftUI

struct InputTextFieldView: UIViewRepresentable {    
    
    @Binding var text: String
    
    var placeholder: String
    let placeholderColor: UIColor
    
    var tintColor: UIColor
    var backgroundColor: UIColor
    var textColor: UIColor
    
    let font: UIFont
    
    let isSecure: Bool
    
    init(
        text: Binding<String>,
        placeholder: String,
        placeholderColor: UIColor = UIColor(ColorManager.foreground2),
        tintColor: UIColor = UIColor(ColorManager.primaryColor),
        backgroundColor: UIColor = UIColor(ColorManager.background2),
        textColor: UIColor = UIColor(ColorManager.defaultForeground),
        font: UIFont = UIFont(name: "Pretendard-SemiBold", size: 20.0)!,
        isSecure: Bool = false
    ) {
        self._text = text
        
        self.placeholder = placeholder
        self.placeholderColor = placeholderColor
        
        self.tintColor = tintColor
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        
        self.font = font
        
        self.isSecure = isSecure
        
    }
    
    func makeUIView(context: Context) -> UITextField {
//        UITextField.appearance().clearButtonMode = .whileEditing
        let textfield = CustomTextField()
        
        textfield.frame = .zero
        
        textfield.placeholder = placeholder
        let placeholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: placeholderColor])
        textfield.attributedPlaceholder = placeholder
        
        textfield.tintColor = tintColor
        textfield.backgroundColor = backgroundColor
        textfield.textColor = textColor
        
        textfield.font = font
        
        textfield.delegate = context.coordinator
        
        textfield.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 0.0))
        textfield.leftViewMode = .always

        textfield.clearButtonMode = .whileEditing
        
        textfield.layer.cornerRadius = 10
        
        textfield.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        textfield.isSecureTextEntry = isSecure
        
        return textfield
    }
    
    func updateUIView(_ textfield: UITextField, context: Context) {
        textfield.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String
        
        init(text: Binding<String>) {
            self._text = text
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            textField.backgroundColor = UIColor(ColorManager.background)
            textField.layer.borderWidth = 2.0
            textField.layer.borderColor = UIColor(ColorManager.primaryColor).cgColor
 
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            textField.backgroundColor = UIColor(ColorManager.background2)
            textField.layer.borderWidth = 0.0
//            textField.layer.borderColor = UIColor(ColorManager.primaryColor).cgColor
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            return false
        }
    }
    
    class CustomTextField: UITextField {
        
        private let commonInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        private let clearButtonOffset: CGFloat = 10
        private let clearButtonLeftPadding: CGFloat = 10
        
        override open func textRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: commonInsets)
        }
        
        override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: commonInsets)
        }
        
        // clearButton의 위치와 크기를 고려해 inset을 삽입
        override open func editingRect(forBounds bounds: CGRect) -> CGRect {
            let clearButtonWidth = clearButtonRect(forBounds: bounds).width
            let editingInsets = UIEdgeInsets(
                top: commonInsets.top,
                left: commonInsets.left,
                bottom: commonInsets.bottom,
                right: clearButtonWidth + clearButtonOffset + clearButtonLeftPadding
            )
            
            return bounds.inset(by: editingInsets)
        }
        
        // clearButtonOffset만큼 x축 이동
        override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
            var clearButtonRect = super.clearButtonRect(forBounds: bounds)
            clearButtonRect.origin.x -= clearButtonOffset
            return clearButtonRect
        }
    }
        
}



//HStack {
//    Text("UIKit : ")
//    UITextFieldViewRepresentable(text: $text, placeholder: placeholder, placeholderColor: .gray)
//        .updatePlaceholder(placeholder)
//        .withDefaultUITextFieldModifier()
//}
//}
//}
//}

//struct UITextFieldViewRepresentable: UIViewRepresentable {
//@Binding var text: String
//var placeholder: String
//let placeholderColor: UIColor
//
//init(text: Binding<String>, placeholder: String = "PLACEHOLDER", placeholderColor: UIColor = .gray) {
//self._text = text
//self.placeholder = placeholder
//self.placeholderColor = placeholderColor
//}

//func makeUIView(context: Context) -> some UIView {
//let textField = getTextField()
//textField.delegate = context.coordinator
//return textField
//}

////From SwiftUI To UIKit
//func updateUIView(_ uiView: UIViewType, context: Context) {
//guard let textField = uiView as? UITextField else { return }
//textField.text = text
//}


////From UIKit to SwiftUI
//func makeCoordinator() -> Coordinator {
//// CUSTOM INSTANCE BETWEEN INTERFACES
//return Coordinator(text: $text)
//
//}
//
//func updatePlaceholder(_ text: String) -> UITextFieldViewRepresentable {
//print("UPDATE PLACEHOLDER")
//var viewRepresentable = self
//viewRepresentable.placeholder = text
//return viewRepresentable
//}
//
//private func getTextField() -> UITextField {
//let textField = UITextField(frame: .zero)
//let placeholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: placeholderColor])
//textField.attributedPlaceholder = placeholder
//return textField
//}
//
//class Coordinator: NSObject, UITextFieldDelegate {
//@Binding var text: String
//init(text: Binding<String>) {
//self._text = text
//}
//
//func textFieldDidChangeSelection(_ textField: UITextField) {
//text = textField.text ?? ""
//}
//}
//}
