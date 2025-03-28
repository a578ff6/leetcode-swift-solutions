// LeetCode #217 - Contains Duplicate

// MARK: - 解法一：使用 Set 判斷是否重複
class Solution {
    
    /// 判斷陣列中是否有重複數字
    func containsDuplicate(_ nums: [Int]) -> Bool {
        
        // 建立一個空的 Set，用來記錄出現過的數字
        var seen = Set<Int>()
        
        // 逐一走訪陣列中的每個數字
        for num in nums {
            
            // 如果這個數字已經出現過，表示有重複 → 回傳 true
            if seen.contains(num) {
                return true
            }
            // 否則就記錄這個數字
            seen.insert(num)
        }
        
        // 全部檢查完都沒有重複 → 回傳 false
        return false
    }
    
}

// MARK: - 測試一
let solution = Solution()

let test1 = [1, 2, 3, 1]
let test2 = [1, 2, 3, 4]

print(solution.containsDuplicate(test1)) // true
print(solution.containsDuplicate(test2)) // false