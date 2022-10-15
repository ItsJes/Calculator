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
    
    var currentString: String = ""
    //var currentResult: Double!
    var trackingString: String = "0"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clear()
        // Do any additional setup after loading the view.
    }
    
    func clear() {
        currentString = ""
        trackingString = "0"
        input.text = "0"
        output.text = "0"
    }
    func formatResult(result: Double) -> String {
        if(result.truncatingRemainder(dividingBy: 1) == 0){
            return String(format: "%.0f", result)
        }
        else{
            return String(format: "%.5f", result)
        }
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
        }
        
    }
    
    
    @IBAction func decimalButton(_ sender: Any) {
        addToStr(value: ".")
    }
    
    
    @IBAction func divisionButton(_ sender: Any) {
        addToStr(value: "/")
    }
    
    @IBAction func multiplicationButton(_ sender: Any) {
        addToStr(value: "*")
    }
    
    @IBAction func subtractionButton(_ sender: Any) {
        addToStr(value: "-")
    }
    
    @IBAction func AdditionButton(_ sender: Any) {
        addToStr(value: "+")
    }
    
    
    @IBAction func equalButton(_ sender: UIButton) {
        
        var result: Double
        var resultString: String
        let expression = NSExpression(format: trackingString)
        result = expression.expressionValue(with: nil, context: nil) as! Double
         
        resultString = formatResult(result: result)
        trackingString = resultString
        currentString = resultString
        output.text = resultString
        
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
            output.text = resultString
        }
        else{
            currentString = ""
        }
    }
    
    
    @IBAction func cosButton(_ sender: Any) {
        addToStr(value: "cos")
        let parsed = trackingString.replacingOccurrences(of: "cos", with: "")
        
        //result = sinh(x: Double(5))
        if parsed.count != 0{
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
            output.text = resultString
        }
        else{
            currentString = ""
        }
    }
    
    
    @IBAction func sinButton(_ sender: Any) {
        addToStr(value: "sin")
        
        let parsed = trackingString.replacingOccurrences(of: "sin", with: "")
        if parsed.count != 0{
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
            output.text = resultString
        }
        else{
            currentString = ""
        }
    }
    
    @IBAction func numberButtonPressed(_ sender: Any) {
        addToStr(value: (sender as! UIButton).titleLabel?.text ?? "")
    }
}


