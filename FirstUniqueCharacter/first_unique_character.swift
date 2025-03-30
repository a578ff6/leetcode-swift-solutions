// LeetCode #387 - First Unique Character in a String

// MARK: - 解法一：兩次遍歷法
class Solution {
    
    /// 第一次統計字母出現次數，第二次找第一個只出現一次的字元
    func firstUniqChar(_ s: String) -> Int {
        
        // 建立一個字典，用來統計每個字元出現的次數
        var counter = [Character: Int]()
        
        // 第一次走訪：統計字母出現次數
        for char in s {
            counter[char, default: 0] += 1
        }
        
        // 第二次走訪：找第一個只出現一次的字元
        for (index, char) in s.enumerated() {
            if counter[char] == 1 {
                return index        // 找到了！回傳位置
            }
        }
        
        return -1                   // 如果沒有只出現一次的字元，回傳 -1
    }
}

// MARK: - 測試
let solution = Solution()

let string1 = "leetcode"
let string2 = "loveleetcode"
let string3 = "aabb"

print(solution.firstUniqChar(string1))   // ➝ 0
print(solution.firstUniqChar(string2))   // ➝ 2
print(solution.firstUniqChar(string3))   // ➝ -1