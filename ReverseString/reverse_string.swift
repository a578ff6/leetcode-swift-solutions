// LeetCode #344 - Reverse String

// MARK: - 解法一：雙指標 Two Pointers（in-place + O(1) 空間）
class Solution {
    
    // 使用雙指標（Two Pointers）原地反轉字元陣列
    func reverseString(_ s: inout [Character]) {
        
        // 左右指標起始位置
        var left = 0
        var right = s.count - 1
        
        // 當左指標小於右指標時，持續交換
        while left < right {
            // 交換左右兩側的字元
            s.swapAt(left, right)
            
            // 左邊往右走，右邊往左走
            left += 1
            right -= 1
        }
    }
}

// MARK: - 測試一

let solution = Solution()
var s: [Character] = ["h", "e", "l", "l", "o"]
solution.reverseString(&s)
print(s) // ➜ ["o", "l", "l", "e", "h"]