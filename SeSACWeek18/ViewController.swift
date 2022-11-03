//
//  ViewController.swift
//  SeSACWeek18
//
//  Created by 이병현 on 2022/11/02.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    let viewModel = ProfileViewModel()
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.profile // <Single>, Syntax Sugar
            .withUnretained(self)
            .subscribe { (vc, value) in
                
                vc.label.text = value.user.email
                
            } onError: { error in
                print(error.localizedDescription)
            }
            .disposed(by: disposeBag)
        
        // subscribe, bind, drive
        
        // driver vs signal
        
        viewModel.getProfile()
        checkCOW()
        
        let phone = Phone()
        print(phone[2])
    }
    
    //값 참조 타입 8회차
    func checkCOW() {
        
        var test = "Cody"
        
        address(&test)
        
        var test2 = test
        address(&test2)
        
        test2 = "SeSAC"
        address(&test)
        address(&test2)
        
        var array = Array(repeating: "A", count: 100) //Array, Dictionary, Set == Collection Type일 때만 일어남!!
        print("🍎🍎🍎array")
        address(&array)

        var newArray = array // 실제로 복사 안함! 원본을 공유하고 있음.
        print("🍏🍏🍏newArray")
        address(&newArray)
        
        newArray[0] = "B" // 이때 값을 수정할 때 복사가 일어남!!
        print("=================배열 값 변경함===================")
        print("🍎🍎🍎array")
        address(&array)
        print("🍏🍏🍏newArray")
        address(&newArray)

        var list = (1,2,3,"hi")
        print("🍎🍎🍎tuple")
        address(&list)
        var newList = list
        print("🍏🍏🍏newTuple")
        address(&newList)

        list.0 = 3
        print("튜플 값 변경함===================")
        print("🍎🍎🍎tuple")
        address(&list)
        print("🍏🍏🍏newTuple")
        address(&newList)

    }
    
    func address(_ value: UnsafeRawPointer) {
        let adress = String(format: "%p", Int(bitPattern: value))
        print(adress)
    }
    
    
}

