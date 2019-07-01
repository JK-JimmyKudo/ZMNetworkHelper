//
//  HHHViewController.swift
//  ZMNetworkHelper
//
//  Created by power on 2019/6/21.
//  Copyright © 2019 Henan XinKangqiao. All rights reserved.
//

import UIKit

class HHHViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let nums:[Int] = [3,2,3,8]
        let targer = 6
        
        let arr = twoSum(nums , targer)
        
        print(arr)
        
    }
    
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
       
        
        var number:[Int] = []
        for i in 0..<nums.count - 1 {

            for j in 0..<nums.count {
                print(nums[i],nums[j],nums[i]+nums[j],i,j)
                if (nums[i] + nums[j] == target) {
                    number = [i, j]
                }
            }
        }
        
//        for(let i = 0; i < nums.length - 1; i++){
//            for(let j = i + 1; j < nums.length; j++){
//                if(nums[i] + nums[j] == target){
//                    number = [i, j]
//                }
//            }
//        }
        return number
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
