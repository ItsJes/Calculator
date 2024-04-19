//
//  ViewController.swift
//  Calculator
//
//  Created by Jessica Sendejo on 7/6/22.
//
import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var input: UILabel!
    @IBOutlet weak var output: UILabel!
    @IBOutlet weak var radDegLabel: UILabel!
    
    let operators = ["/", "+", "*", "-"]
    let preoperators = ["/", "+", "*"]
    let numbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    
    var currentString: String = ""
    //var currentResult: Double!
    var trackingString: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clear()
    }
    
    func clear() {
        currentString = ""
        trackingString = ""
        input.text = ""
        output.text = "0"
    }
    
    func clearAfterZero() {
        currentString = ""
        trackingString = ""
        input.text = "0"
        output.text = "ERROR"
    }
    
    func formatResult(result: Double) -> String {
            let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 5
            
            var formattedResult = formatter.string(from: NSNumber(value: result)) ?? ""
            
            // Trim trailing zeros
            if let dotIndex = formattedResult.lastIndex(of: ".") {
                var endIndex = formattedResult.index(before: formattedResult.endIndex)
                while formattedResult[endIndex] == "0" {
                    formattedResult.remove(at: endIndex)
                    endIndex = formattedResult.index(before: endIndex)
                }
                if formattedResult[endIndex] == "." {
                    formattedResult.remove(at: endIndex)
                }
            }
            
            return formattedResult
        }
    
    func addToStr(value: String) {
        currentString = currentString + value 
        trackingString = trackingString + value
        input.text = currentString
    }

    @IBAction func clearButton(_ sender: Any) {
        clear()
    }
    
    @IBAction func backButton(_ sender: Any) {
        if(!currentString.isEmpty){
            currentString.removeLast()
            input.text = currentString
            trackingString = currentString
        }
        
    }
    
    func validParentheseInput(s: String) -> Bool{
        
        for num in numbers{
            if s.contains(num + "(") || s.contains(")" + num){
                return false
            }
        }
        
        for op in operators {
            if s.contains(op + ")" ){
                return false
            }
        }
        return true
    }
    
    func checkParentheses(s: String) -> Bool {
        var resultStack : [String.Element] = []
        for letter in s {
            if letter == "(" {
                resultStack.append(letter)
            } else if letter == ")" {
                if resultStack.last == "(" {
                    resultStack.popLast()
                } else {
                    return false
                }
            }
        }
        return resultStack.isEmpty
    }
    
    func validLastInput(s: String) -> Bool{
        //  print("\(trackingString)")
        let last = String(s.last!)
        
        // print(operators.contains(last))
        
        if(operators.contains(last)){
            return false
        }
        
        return true
    }
    
    func checkEmptyString(s: String) -> Bool{
        if s.isEmpty{
            return false
        }
        return true
    }
    
    func validFirstInput(s: String) -> Bool{
        //print("\(trackingString)")
        let firstNum = String(s.first!)
        
        //print(preoperators.contains(firstNum))
        
        if(preoperators.contains(firstNum)){
            return false
        }
        
        return true
    }
    
    @IBAction func equalButton(_ sender: Any) {
        var result: Double
        var resultString: String
        
        trackingString = trackingString.replacingOccurrences(of: "^", with: "**")
        trackingString = trackingString.replacingOccurrences(of: "x", with: "*")
        
        if trackingString.contains("tan") || trackingString.contains("cos") || trackingString.contains("sin") {
            clear()
        }
        
        if checkEmptyString(s: trackingString) && validFirstInput(s: trackingString) && validLastInput(s: trackingString) && checkParentheses(s: trackingString) && validParentheseInput(s: trackingString) {
            var updatedString = ""
            var currentNumber = ""
            var hasDecimal = false
            
            for char in trackingString {
                if numbers.contains(String(char)) {
                    currentNumber.append(char)
                } else if char == "." {
                    if !hasDecimal {
                        currentNumber.append(char)
                        hasDecimal = true
                    } else {
                        // Handle multiple decimal points in a number (e.g., "1.2.3")
                        clear()
                        return
                    }
                } else {
                    if !currentNumber.isEmpty {
                        // Append ".0" to the completed numbers if no decimal point
                        updatedString += currentNumber.contains(".") ? currentNumber : currentNumber + ".0"
                        currentNumber = ""
                        hasDecimal = false
                    }
                    updatedString.append(char)
                }
            }
            
            // Append ".0" to the last completed number (if any)
            if !currentNumber.isEmpty {
                updatedString += currentNumber.contains(".") ? currentNumber : currentNumber + ".0"
            }
            
            let doubleValue = updatedString
            let expression = NSExpression(format: doubleValue)
            
            print("\(doubleValue)")
            
            result = expression.expressionValue(with: nil, context: nil) as! Double
            resultString = formatResult(result: result)
            
            trackingString = resultString
            currentString = resultString
            output.text = resultString
        } else {
            clear()
        }
    }

    @IBAction func percentageButton(_ sender: Any) {
        addToStr(value: "%")
        let parsed = trackingString.replacingOccurrences(of: "%", with: "*0.01")

        if parsed.count != 0{
            if validFirstInput(s: parsed){
                if validLastInput(s: parsed){
                    if checkParentheses(s: parsed){
                        let expression = NSExpression(format: parsed)
                        var result = expression.expressionValue(with: nil, context: nil) as! Double
                        let resultString = formatResult(result: result)
                        trackingString = resultString
                        //input.text = resultString
                        output.text = resultString
                    }
                }
                else{
                    clear()
                }
            }
            else{
                clear()
            }
        }
        else{
            currentString = ""
            trackingString = ""
        }
    }
    
    @IBAction func radDegButton(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        if(radDegLabel.text == "RAD"){
            radDegLabel.text = "DEG"
            userDefaults.set(true, forKey: "RAD")
        }else{
            radDegLabel.text = "RAD"
            userDefaults.set(false, forKey: "RAD")
        }
        
        userDefaults.synchronize()
        
    }
    
    @IBAction func tanButton(_ sender: Any) {
        addToStr(value: "tan")
        let parsed = trackingString.replacingOccurrences(of: "tan", with: "")
        if parsed.count != 0{
            //let parsed = trackingString.replacingOccurrences(of: "tan", with: "")
            
            //result = sinh(x: Double(5))
            if validFirstInput(s: parsed){
                if validLastInput(s: parsed){
                    if checkParentheses(s: parsed){
                        let expression = NSExpression(format: parsed)
                        var result = expression.expressionValue(with: nil, context: nil) as! Double
                        
                        if(radDegLabel.text == "RAD"){
                            result = tan(result)
                        }
                        else{
                            result = tan(((result / 180) * .pi))
                            
                        }
                        let resultString = formatResult(result: result)
                        trackingString = resultString
                        currentString = resultString
                        output.text = resultString
                    }
                }
                else{
                    clear()
                }
            }
            else{
                clear()
            }
        }
        
        else{
            currentString = ""
            trackingString = ""
        }
    }
    
    @IBAction func cosButton(_ sender: Any) {
        addToStr(value: "cos")
        let parsed = trackingString.replacingOccurrences(of: "cos", with: "")
        
        //result = sinh(x: Double(5))
        if parsed.count != 0{
            if validFirstInput(s: parsed){
                if validLastInput(s: parsed){
                    if checkParentheses(s: parsed){
                        let expression = NSExpression(format: parsed)
                        var result = expression.expressionValue(with: nil, context: nil) as! Double
                        
                        if(radDegLabel.text == "RAD"){
                            result = cos(result)
                        }
                        else{
                            result = cos(((result / 180) * .pi))
                            
                        }
                        
                        let resultString = formatResult(result: result)
                        trackingString = resultString
                        currentString = resultString
                        output.text = resultString
                    }
                }
                else{
                    clear()
                }
            }
            else{
                clear()
            }
        }
        else{
            currentString = ""
            trackingString = ""
            
        }
    }
    
    @IBAction func sinButton(_ sender: Any) {
        addToStr(value: "sin")
        
        let parsed = trackingString.replacingOccurrences(of: "sin", with: "")
        if parsed.count != 0{
            if validFirstInput(s: parsed){
                if validLastInput(s: parsed){
                    if checkParentheses(s: parsed){
                        let expression = NSExpression(format: parsed)
                        var result = expression.expressionValue(with: nil, context: nil) as! Double
                        
                        if(radDegLabel.text == "RAD"){
                            result = sin(result)
                        }
                        else{
                            result = sin(((result / 180) * .pi))
                            
                        }
                        
                        let resultString = formatResult(result: result)
                        trackingString = resultString
                        currentString = resultString
                        output.text = resultString
                        //input.text = resultString
                    }
                }
                else{
                    clear()
                }
            }
            else{
                clear()
            }
        }
        else{
            currentString = ""
            trackingString = ""
        }
    }
    
    @IBAction func numberButtonPressed(_ sender: Any) {
        if let buttonText = (sender as? UIButton)?.titleLabel?.text {
            addToStr(value: buttonText)
            
        }
    }
}


