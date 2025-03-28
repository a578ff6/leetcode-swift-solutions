// LeetCode #125 - Valid Palindrome

// MARK: - 解法一：雙指標 + 字元過濾
class Solution {
    
    func isPalindrome(_ s: String) -> Bool {
        
        // Step 1：將字串轉成小寫字元陣列，方便比對
        let chars = Array(s.lowercased())
        var left = 0
        var right = chars.count - 1
        
        // Step 2：使用雙指標從兩端往中間掃描
        while left < right {
            
            // 忽略左邊不是英數的字元
            if !chars[left].isLetter && !chars[left].isNumber {
                left += 1
                continue
            }
            
            // 忽略右邊不是英數的字元
            if !chars[right].isLetter && !chars[right].isNumber {
                right -= 1
                continue
            }
            
            // 若左右字元不同，代表不是回文
            if chars[left] != chars[right] {
                return false
            }
            
            // 字元相同，繼續往中間靠攏
            left += 1
            right -= 1
        }
        
        // 所有字元都配對成功，代表是回文
        return true
    }
}

// MARK: - 測試
let solution = Solution()

print(solution.isPalindrome("A man, a plan, a canal: Panama"))  // true
print(solution.isPalindrome("race a car"))                      // false
print(solution.isPalindrome("  "))                              // true
