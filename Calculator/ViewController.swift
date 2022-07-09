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
    
    func clear()
    {
        currentString = ""
        trackingString = "0"
        input.text = "0"
        output.text = "0"
    }
    func formatResult(result: Double) -> String
    {
        if(result.truncatingRemainder(dividingBy: 1) == 0)
        {
            return String(format: "%.0f", result)
        }
        else
        {
            return String(format: "%.5f", result)
        }
    }
    
    func addToStr(value: String)
    {
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
                result = tangent(x: result)
            }
            else{
                result = tangent(x: ((result / 180) * .pi))
                
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
                result = cosine(x: result)
            }
            else{
                result = cosine(x: ((result / 180) * .pi))
                
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
                result = sine(x: result)
            }
            else{
                result = sine(x: ((result / 180) * .pi))
                
            }
            
            let resultString = formatResult(result: result)
            trackingString = resultString
            output.text = resultString
        }
        else{
            currentString = ""
        }
    }
    @IBAction func nineButton(_ sender: Any) {
        addToStr(value: "9")
    }
    
    
    @IBAction func eightButton(_ sender: Any) {
        addToStr(value: "8")
    }
    
    @IBAction func sevenButton(_ sender: Any) {
        addToStr(value: "7")
    }
    
    @IBAction func sixButton(_ sender: Any) {
        addToStr(value: "6")
    }
    
    @IBAction func fiveButton(_ sender: Any) {
        addToStr(value: "5")
    }
    
    @IBAction func fourButton(_ sender: Any) {
        addToStr(value: "4")
    }
    
    
    @IBAction func threeButton(_ sender: Any) {
        addToStr(value: "3")
    }
    
    @IBAction func twoButton(_ sender: Any) {
        addToStr(value: "2")
    }
    
    
    @IBAction func oneButton(_ sender: Any) {
        addToStr(value: "1")
    }
    
    @IBAction func zeroButton(_ sender: Any) {
        addToStr(value: "0")
    }
    
    @objc func sine(x: Double) -> Double{
        return(sin(x))
    }
    
    @objc func cosine(x: Double) -> Double{
        return(cos(x))
    }
    
    @objc func tangent(x: Double) -> Double{
        return(tan(x))
    }
    
}


