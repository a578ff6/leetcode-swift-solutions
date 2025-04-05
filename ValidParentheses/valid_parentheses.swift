// LeetCode #20 - Valid Parentheses

// MARK: - 解法：使用 Stack 配對括號
class Solution {
    
    /// 判斷字串 s 是否為有效的括號組合
    func isValid(_ s: String) -> Bool {
        
        // 建立一個對照表：每個「閉括號」對應的「開括號」
        let pair: [Character: Character] = [
            ")": "(",
            "]": "[",
            "}": "{"
        ]
        
        // 用一個 Stack 來追蹤「尚未被配對的開括號」
        var stack: [Character] = []
        
        // 逐一讀取字串中的每個字元
        for char in s {
            
            // 如果目前是「閉括號」，才會出現在 pair 中
            if let match = pair[char] {
                
                // 檢查 Stack 最上層是否為「對應的開括號」
                if stack.last == match {
                    // 成功配對，移除最上層開括號
                    stack.removeLast()
                } else {
                    // 配對錯誤（順序不對或沒東西可配）→ 提早結束
                    return false
                }
            } else {
                // 如果是「開括號」→ 放進 Stack，等之後來配對
                stack.append(char)
            }
        }
        
        // 所有配對都成功，Stack 會被清空 → 回傳 true
        // 若還有殘留 → 有未配對的開括號 → 回傳 false
        return stack.isEmpty
    }
    
}


// MARK: - 測試

let solution = Solution()

print(solution.isValid("()"))        // true
print(solution.isValid("()[]{}"))    // true
print(solution.isValid("(]"))        // false
print(solution.isValid("([)]"))      // false
print(solution.isValid("{[]}"))      // true
print(solution.isValid("["))         // false
print(solution.isValid(""))          // true