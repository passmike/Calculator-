//
//  ViewController.swift
//  Calculator
//
//  Created by 張仕錦 on 2019/1/10.
//  Copyright © 2019 AppsMike. All rights reserved.
//

import UIKit

//列舉
enum OperationType{
    case add
    case subtract
    case multiply
    case divide
    case none
}

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    //此變數儲存(運算之前)畫面上的數字 先存入0
    var previousNumber:Double = 0
    
    //此變數儲存(當前)畫面上的數字 原始值0 所以存入0
    var numberOnScreen:Double = 0
    
    //此變數儲存是不是在運算的過程中 一開始不是所以false
    var performingMath = false
    
    //此變數儲存當下是何種運算 一開始都沒有所以none
    var operation:OperationType = .none
    
    //此變數來判斷是否重啟運算 把該答案數字直接替換成新輸入的數字
    var startNew = true
    
    //讓狀態列顯示白色的
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    //加法
    @IBAction func add(_ sender: UIButton) {
        label.text = "+"
        operation = .add
        //是運算中
        performingMath = true
        previousNumber = numberOnScreen
    }
    
    //減法
    @IBAction func subtract(_ sender: UIButton) {
        label.text = "-"
        operation = .subtract
        //是運算中
        performingMath = true
        previousNumber = numberOnScreen
    }
    
    //乘法
    @IBAction func multiply(_ sender: UIButton) {
        label.text = "x"
        operation = .multiply
        //是運算中
        performingMath = true
        previousNumber = numberOnScreen
    }
    
    //除法
    @IBAction func divide(_ sender: UIButton) {
        label.text = "/"
        operation = .divide
        //是運算中
        performingMath = true
        previousNumber = numberOnScreen
    }
    
    //設定C 清除鍵 且將所有的值回歸初始值
    @IBAction func clearC(_ sender: UIButton) {
        label.text = "0"
        //此變數儲存畫面上的數字 原始值0 所以存入0
        numberOnScreen = 0
        //此變數儲存畫面運算之前畫面上的數字 先存入0
        previousNumber = 0
        //此變數儲存是不是在運算的過程中 一開始不是所以false
        performingMath = false
        //此變數儲存是如何的運算 一開始都沒有所以none
        operation = .none
        
        startNew = true
    }
    
    //讓文字標籤顯示正確 沒有.0
    func makeOKNumberString(from number:Double){
        //讓小數到第9位就好 設一變數
        var okText:String
        //floor是四捨五入 四捨五入後還是原本數字
        if floor(number) == number{
            //就轉型成一個整數
            okText = "\(Int(number))"
        }else{
            okText = "\(number)"
        }
        //okText的位數大於或等於10
        if okText.count >= 10{
            //就取前面10個數字
            okText = String(okText.prefix(10))
        }
        label.text = okText
    }
    
    //設定＝ 答案
    @IBAction func giveMeAnswer(_ sender: UIButton) {
        //是運算中
        if performingMath == true{
            //判斷
            switch operation{
            case .add:
                numberOnScreen = previousNumber + numberOnScreen
                //驗證該答案數字是不是有小數
                makeOKNumberString(from: numberOnScreen)
            case .subtract:
                numberOnScreen = previousNumber - numberOnScreen
                //驗證該答案數字是不是有小數
                makeOKNumberString(from: numberOnScreen)
            case .multiply:
                numberOnScreen = previousNumber * numberOnScreen
                //驗證該答案數字是不是有小數
                makeOKNumberString(from: numberOnScreen)
            case .divide:
                numberOnScreen = previousNumber / numberOnScreen
                //驗證該答案數字是不是有小數
                makeOKNumberString(from: numberOnScreen)
            case .none:
                label.text = "0"
            }
            performingMath = false
            startNew = true
        }
    }
    
    //按到任一數字的方法
    @IBAction func numbers(_ sender: UIButton) {
        //判斷選到的數字 要-1因為先前有在按鍵Tag設定多1
        let inputnumber = sender.tag - 1
        //設定讓數字留下
        if label.text != nil{
            if startNew == true{
                label.text = "\(inputnumber)"
                startNew = false
            }else{
                //如果是0 讓他顯示0
                if label.text == "0" || label.text == "+" || label.text == "-" || label.text == "x" || label.text == "/"{
                    label.text = "\(inputnumber)"
                }else{
                    //如果是0以外的數 就按出後再加上其他的數字 label.text因為確定有值所以加上!
                    label.text = label.text! + "\(inputnumber)"
                }
            }
            //將label.text!轉型成Double這就是目前的數字存進numberOnScreen 如果轉型失敗就把0存存進numberOnScreen裡
            numberOnScreen = Double(label.text!) ?? 0
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

