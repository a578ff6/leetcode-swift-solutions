// LeetCode #242 - Valid Anagram

// MARK: - 解法一：排序法
class Solution {
    
    func isAnagram(_ s: String, _ t: String) -> Bool {
        
        // 長度不同，直接 return false（提早結束）
        if s.count != t.count { return false }
        
        let sortedS = s.sorted()
        let sortedT = t.sorted()
        
        return sortedS == sortedT
    }
}

// MARK: - 測試一
let solutionOne = SolutionOne()

print(solutionOne.isAnagram("anagram", "nagaram"))     // true
print(solutionOne.isAnagram("rat", "car"))         // false


// MARK: - 解法二：使用 Dictionary 統計字母次數
class SolutionTwo {
    
    func isAnagram(_ s: String, _ t: String) -> Bool {
        
        // 長度不同，直接 return false（提早結束）
        if s.count != t.count { return false }
        
        // 建立一個字典，用來記錄 s 中每個字母的出現次數
        var dict = [Character: Int]()
        for char in s {
            dict[char, default: 0] += 1
        }
        
        // 遍歷 t，每遇到一個字母就從 dict 裡扣除
        for char in t {
            // 若該字母不存在，或已經扣到底（< 0），代表不是 anagram
            guard let count = dict[char], count > 0 else {
                return false
            }
            
            // 字母存在，扣除一次
            dict[char] = count - 1
        }
        
        return true
    }
}

// MARK: - 測試二
let solutionTwo = SolutionTwo()

print(solutionTwo.isAnagram("anagram", "nagaram"))     // true
print(solutionTwo.isAnagram("rat", "car"))         // false
