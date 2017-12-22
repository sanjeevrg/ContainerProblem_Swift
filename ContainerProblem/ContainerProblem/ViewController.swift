//
//  ViewController.swift
//  ContainerProblem
//
//  Created by Sanjeev on 15/12/17.
//  Copyright © 2017 . All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var containerSizes: [Int] = []
    var initialValue:[Int] = []
    var finalValue:[Int] = []
    var solution:[[Int]] = []
    var visited:[[Int]] = []
    
    @IBOutlet weak var solutionSteps: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func resetSelected(_ sender: Any) {
        solutionSteps.text = "";
        
    }
    
    @IBAction func submitSelected(_ sender: Any) {
        print("Submit clicked")
        //Read values from text fields
        let capacityText: String? = containerCapacity.text
        let initialArray = capacityText!.components(separatedBy: ",")
        containerSizes = initialArray.map { Int($0)!}
        
        let initialValues:String? = initialContainerValues.text
        let initialValuesArray = initialValues!.components(separatedBy: ",")
        initialValue = initialValuesArray.map { Int($0)!}
        
        let finalValues:String? = expectedContainerValues.text
        let finalValuesArray = finalValues!.components(separatedBy: ",")
        finalValue = finalValuesArray.map { Int($0)!}
        
        //Reset visited and solution array
        visited = []
        solution = []
        
        let result:Bool = containerSolution(initialValue:initialValue)
        if(result){
            for element in solution {
                print(element)
            }
            var finalSolution:[[Int]] = []
            for loop in stride(from: solution.count-1, to: 0, by: -1){
                finalSolution.append(solution[loop])
            }
            finalSolution.append(solution[0])
            solutionSteps.text = "Solution is:\n"
            for element in finalSolution {
                print(element)
                var formattedArray = (element.map{String($0)}).joined(separator: ",")
                formattedArray.append("\n")
                solutionSteps.text = solutionSteps.text.appending(formattedArray)
                
            }
        }else{
            print("Solution not feasible")
            solutionSteps.text = "Solution not feasible"
        }
        
    }
    @IBOutlet weak var containerCapacity: UITextField!
    @IBOutlet weak var expectedContainerValues: UITextField!
    @IBOutlet weak var initialContainerValues: UITextField!
    
    
    func containerSolution(initialValue:[Int]) -> Bool{
        print("Entered 1")
        let firstContainerSize = containerSizes[0]
        let secondContainerSize = containerSizes[1]
        let thirdContainerSize = containerSizes[2]
        let firstContainerQty = initialValue[0]
        let secContainerQty = initialValue[1]
        let thirdContainerQty = initialValue[2]
        
        //Terminating condition
        if(firstContainerQty == finalValue[0] && secContainerQty==finalValue[1] && thirdContainerQty==finalValue[2]){
            solution.append(initialValue)
            return true
        }
        //If not is already visited, return
        if(checkElementExists(intArray:visited,element:initialValue)) {
            return false
        }
        //Make entry to list of visited nodes
        visited.append(initialValue)
        print("Entered 2")
        //Empty first container
        if( firstContainerQty > 0) {
            //Empty first container into second
            print("Entered 3",firstContainerQty,secContainerQty,thirdContainerQty,firstContainerSize,secondContainerSize,thirdContainerSize)
            if(firstContainerQty+secContainerQty<=secondContainerSize){
                let arr:[Int] = [0,firstContainerQty+secContainerQty,thirdContainerQty]
                print("Entered 4",firstContainerQty,secContainerQty,thirdContainerQty,firstContainerSize,secondContainerSize,thirdContainerSize)
                if( containerSolution(initialValue:arr) ){
                    solution.append(initialValue)
                    return true
                }
            }else{
                let arr:[Int] = [firstContainerQty-(secondContainerSize-secContainerQty), secondContainerSize, thirdContainerQty]
                print("Entered 5",firstContainerQty,secContainerQty,thirdContainerQty,firstContainerSize,secondContainerSize,thirdContainerSize)
                if(containerSolution(initialValue:arr)){
                    solution.append(initialValue)
                    return true
                }
            }
            //Empty first container into third
            if(firstContainerQty+thirdContainerQty<=thirdContainerSize){
                print("Entered 6",firstContainerQty,secContainerQty,thirdContainerQty,firstContainerSize,secondContainerSize,thirdContainerSize)
                let arr:[Int] = [0,secContainerQty,firstContainerQty+thirdContainerQty]
                if( containerSolution(initialValue:arr) ){
                    solution.append(initialValue)
                    return true
                }
            }else{
                print("Entered 7",firstContainerQty,secContainerQty,thirdContainerQty,firstContainerSize,secondContainerSize,thirdContainerSize)
                let arr:[Int] = [firstContainerQty-(thirdContainerSize-thirdContainerQty), secContainerQty, thirdContainerSize]
                if(containerSolution(initialValue:arr)){
                    solution.append(initialValue)
                    return true
                }
            }
        }
        
        //Empty second container
        if( secContainerQty > 0){
            //Empty second container into first
            if(firstContainerQty+secContainerQty<=firstContainerSize){
                print("Entered 8",firstContainerQty,secContainerQty,thirdContainerQty,firstContainerSize,secondContainerSize,thirdContainerSize)
                let arr:[Int] = [firstContainerQty+secContainerQty,0,thirdContainerQty]
                if( containerSolution(initialValue:arr) ){
                    solution.append(initialValue)
                    return true
                }
            }
            else{
                print("Entered 9",firstContainerQty,secContainerQty,thirdContainerQty,firstContainerSize,secondContainerSize,thirdContainerSize)
                let arr:[Int] = [firstContainerSize, secContainerQty-(firstContainerSize-firstContainerQty), thirdContainerQty]
                if(containerSolution(initialValue:arr)){
                    solution.append(initialValue)
                    return true
                }
            }
            //Empty second container into third
            if(secContainerQty+thirdContainerQty<=thirdContainerSize){
                print("Entered 10",firstContainerQty,secContainerQty,thirdContainerQty,firstContainerSize,secondContainerSize,thirdContainerSize)
                let arr:[Int] = [firstContainerQty,0,secContainerQty+thirdContainerQty]
                if( containerSolution(initialValue:arr) ){
                    solution.append(initialValue)
                    return true
                }
            }else{
                print("Entered 11",firstContainerQty,secContainerQty,thirdContainerQty,firstContainerSize,secondContainerSize,thirdContainerSize)
                let arr:[Int] = [firstContainerQty, secContainerQty-(thirdContainerSize-thirdContainerQty), thirdContainerSize]
                if(containerSolution(initialValue:arr)){
                    solution.append(initialValue)
                    return true
                }
            }
            
        }
        
        //Empty third container
        if( thirdContainerQty > 0){
            //Empty third container into first
            if(firstContainerQty+thirdContainerQty<=firstContainerSize){
                print("Entered 12",firstContainerQty,secContainerQty,thirdContainerQty,firstContainerSize,secondContainerSize,thirdContainerSize)
                let arr:[Int] = [firstContainerQty+thirdContainerQty,secContainerQty,0]
                if( containerSolution(initialValue:arr) ){
                    solution.append(initialValue)
                    return true
                }
            }else{
                let arr:[Int] = [firstContainerSize, secContainerQty, thirdContainerQty-(firstContainerSize-firstContainerQty)]
                print("Entered 13",firstContainerQty,secContainerQty,thirdContainerQty,firstContainerSize,secondContainerSize,thirdContainerSize)
                if(containerSolution(initialValue:arr)){
                    solution.append(initialValue)
                    return true
                }
            }
            //Empty second container into third
            if(secContainerQty+thirdContainerQty<=secondContainerSize){
                let arr:[Int] = [firstContainerQty,secContainerQty+thirdContainerQty,0]
                print("Entered 14",firstContainerQty,secContainerQty,thirdContainerQty,firstContainerSize,secondContainerSize,thirdContainerSize)
                if( containerSolution(initialValue:arr) ){
                    solution.append(initialValue)
                    return true
                }
            }else{
                let arr:[Int] = [firstContainerQty, secondContainerSize, thirdContainerQty-(secondContainerSize-secContainerQty)]
                if(containerSolution(initialValue:arr)){
                    solution.append(initialValue)
                    return true
                }
            }
            
        }
        return false
    }
    
    // Check if element exists in array
    func checkElementExists(intArray:[[Int]],element:[Int]) -> Bool {
        let loop:Int = 0
        for loop in 0..<intArray.count{
            if(intArray[loop] == element) {
                return true
            }
            //loop += 1;
        }
        return false
    }
}

