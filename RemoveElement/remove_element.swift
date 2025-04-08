// LeetCode #27 - Remove Element

// MARK: - 解法一（Two Pointers）
class SolutionOne {
    
    /// 從陣列 `nums` 中移除所有等於 `val` 的元素（原地處理），並回傳新長度
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        
        /// k 用來表示「保留區」的起點位置
        /// - 意思是：我們會把不等於 val 的值，依序塞進 nums[0...k]
        var k = 0
        
        /// 使用 i 指標，逐一掃描整個 nums 陣列
        for i in 0..<nums.count {
            
            /// 如果目前元素不是 `val`，代表是要保留的數字
            if nums[i] != val {
                
                /// 將這個元素複製到 nums[k]（保留區的下一格）
                nums[k] = nums[i]
                
                /// 保留區右移一格，準備放下個有效元素
                k += 1
            }
            /// 若 `nums[i] == val`，代表要移除 → 什麼都不做，自動跳過
        }
        
        /// 回傳有效元素的個數，也就是保留區的長度
        return k
    }
}


// MARK: - 測試一

let solutionOne = SolutionOne()

var numsOne = [3, 2, 2, 3]

let valOne = 3

let result = solutionOne.removeElement(&numsOne, valOne)

print("新長度：\(result)")       // ➜ 2
print("移除後陣列：\(Array(numsOne.prefix(result)))") // ➜ [2, 2]


// MARK: - 測試二

var numsTwo = [0,1,2,2,3,0,4,2]

let valTwo = 2

let resultTwo = solutionOne.removeElement(&numsTwo, valTwo)

print("新長度：\(resultTwo)")       // ➜ 5
print("移除後陣列：\(Array(numsTwo.prefix(resultTwo)))") // ➜ [0, 1, 3, 0, 4]