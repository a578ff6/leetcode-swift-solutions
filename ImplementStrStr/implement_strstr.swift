// LeetCode #28 - Implement strStr()

// MARK: - 解法一：使用 Swift 的內建 range(of:)
class SolutionOne {
    
    /// 回傳 needle 在 haystack 中第一次出現的 index，如果找不到回傳 -1
    func strStr(_ haystack: String, _ needle: String) -> Int {
        
        // 如果 needle 是空字串，根據題目要求要回傳 0
        if needle.isEmpty { return 0 }
        
        // 如果找不到，就回傳 -1
        guard let range = haystack.range(of: needle) else {
            return -1
        }
        
        // 成功找到範圍，將 String.Index 轉換為 Int 型別的 index
        let index = haystack.distance(from: haystack.startIndex, to: range.lowerBound)
        return index
    }
}

// MARK: - 測試（一）
let solutionOne = SolutionOne()

print(solutionOne.strStr("hello", "ll"))         // → 2
print(solutionOne.strStr("leetcode", "leeto"))   // → -1
print(solutionOne.strStr("abc", ""))             // → 0
print(solutionOne.strStr("abc", "c"))            // → 2


// MARK: - 解法二：逐格比對（手動滑窗）
// 不使用 Swift 內建函式，自己一格一格地手動滑動比對 needle
class SolutionTwo {
    
    /// 回傳 needle 在 haystack 中第一次出現的 index，如果找不到回傳 -1
    func strStr(_ haystack: String, _ needle: String) -> Int {
        
        // 如果 needle 是空字串，根據題目要求要回傳 0
        if needle.isEmpty { return 0 }
        
        // 先把字串轉成 [Character] 陣列，好處是可以用 index 直接存取
        let haystackArray = Array(haystack)
        let needleArray = Array(needle)
        
        // 外層迴圈：從 haystack 開始逐格滑動，每次檢查 needle 長度的區段
        for i in 0...(haystackArray.count - needleArray.count) {
            
            var match = true
            
            // 內層迴圈：比對目前區段內的每個字元
            for j in 0..<needleArray.count {
                
                // 每次都比對 haystack 從 i 開始的子字元與 needle 對應位置
                // i + j：代表目前在 haystack 要比對的實際位置
                // j：代表在 needle 中的位置
                // 如果這兩個字元不同，代表這一段不是目標
                if haystackArray[i + j] != needleArray[j] {
                    match = false
                    break
                }
            }
            
            // 如果整段都相符，就回傳目前起點 i
            if match { return i }
        }
        
        // 走完都沒找到 → 回傳 -1
        return -1
    }
    
}

// MARK: - 測試

let solutionTwo = SolutionTwo()

print(solutionTwo.strStr("hello", "ll"))         // → 2
print(solutionTwo.strStr("leetcode", "leeto"))   // → -1
print(solutionTwo.strStr("abc", ""))             // → 0
print(solutionTwo.strStr("abc", "c"))            // → 2