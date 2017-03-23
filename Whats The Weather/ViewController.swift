//
//  ViewController.swift
//  Whats The Weather
//
//  Created by Daniele Lanzetta on 15.04.16.
//  Copyright © 2016 Daniele Lanzetta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    
    
    
    
    @IBOutlet weak var result: UILabel!

    @IBOutlet weak var cityTextField: UITextField!
    
    @IBAction func findWeather(_ sender: AnyObject) {
        let url = URL (string: "http://www.weather-forecast.com/locations/" + cityTextField.text!.replacingOccurrences(of: " ", with: "-") + "/forecasts/latest")!
        
        
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            
            if let urlContent = data {
                
                let webcontent = NSString(data: urlContent, encoding: String.Encoding.utf8.rawValue)
                
                let websiteArray = webcontent?.components(separatedBy: "3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                if websiteArray!.count > 1 {
                    
                    let weatherArray = websiteArray![1].components(separatedBy: "</span>")
                    
                    if weatherArray.count > 1 {
                        
                        let weatherSummary = weatherArray[0].replacingOccurrences(of: "&deg;", with: "°")
                        
                        DispatchQueue.main.async(execute: { () -> Void in
                            
                            self.result.text = weatherSummary
                            
                        })
                        
                    }
                    
                }
                
            }
        }) 
        
        task.resume()
    }
        
        
        
        

        
    }


    

  






