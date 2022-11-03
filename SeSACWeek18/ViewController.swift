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
        
        var test = "jack"
        address(&test) // in out 매개변수
        
        print(test[2])
        print(test[200])
        
        var test2 = test
        address(&test2)
        
        test2 = "sesac"
        address(&test)
        address(&test2)
        
        var array = Array(repeating: "A", count: 100) //Array, Dictionary, Set == Collection Type일 때만 일어남!!
        print("array")
        address(&array)
        
        print(array[safe: 99])
        print(array[safe: 199])
        
        var newArray = array // 실제로 복사 안함! 원본을 공유하고 있음.
        print("newArray")
        address(&newArray)
        
        newArray[0] = "B" // 이때 값을 수정할 때 복사가 일어남!!
        print("array")
        address(&array)
        print("newArray")
        address(&newArray)

        
    }
    
    func address(_ value: UnsafeRawPointer) {
        let adress = String(format: "%p", Int(bitPattern: value))
        print(adress)
    }
    
    
}

