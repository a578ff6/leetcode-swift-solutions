# LeetCode 題解筆記 #2：Valid Anagram（Swift）

---

## 📝 題目連結

[https://leetcode.com/problems/valid-anagram](https://leetcode.com/problems/valid-anagram)

---

## ❓ 題目說明

給定兩個字串 `s` 和 `t`，判斷 `t` 是否是 `s` 的 anagram（異位詞）。  
Anagram 指的是：由**相同字母、數量也一致**，只是順序不同。

---

## 💡 解法一：排序法

### 1-1 解法思路

1. 如果長度不同，一定不是 anagram，直接 return false
2. 把 s 和 t 分別轉成陣列並排序
3. 比較排序後的結果是否完全一致

---

### 1-2 Swift 程式碼

```swift
class Solution {
    func isAnagram(_ s: String, _ t: String) -> Bool {
        if s.count != t.count {
            return false
        }
        
        let sortedS = s.sorted()
        let sortedT = t.sorted()
        
        return sortedS == sortedT
    }
}
```

### 1-3 Swift 語法複習

- .sorted()：可以直接對字串使用，回傳排序後的字元陣列 [Character]
- ==：可以用來比較兩個陣列是否完全一致
- s.count != t.count：長度不同可以提早 return，避免多餘運算

---

## 💡 解法二：使用 Dictionary 統計字母出現次數

### 2-1 解法思路

這個方法的核心想法是：**如果兩個字串是 Anagram，它們每個字母出現的次數一定完全相同。**

1. 首先檢查兩個字串長度是否相同，長度不同就直接 return false
2. 使用一個 Dictionary 來記錄第一個字串 `s` 中每個字母出現的次數
3. 然後走訪第二個字串 `t`，對每個字母做 "減去次數" 的動作
   - 如果這個字母在 dict 中沒有出現 → return false
   - 如果這個字母剩下次數為負 → 表示 `t` 多出字母 → return false
4. 所有字母都能剛好扣完，就代表兩字串的字母構成完全一致 → return true

這種寫法效率更高，使用 `guard` 來提前處理錯誤狀況。

---

### 2-2 Swift 程式碼（使用 guard 寫法）

```swift
class Solution {
    func isAnagram(_ s: String, _ t: String) -> Bool {
        if s.count != t.count {
            return false
        }
        
        var dict = [Character: Int]()
        
        for char in s {
            dict[char, default: 0] += 1
        }
        
        for char in t {
            guard let count = dict[char] else {
                return false    // 沒有這個字母
            }
            
            guard count > 0 else {
                return false    // 已經扣到底了
            }
            
            dict[char] = count - 1  // 字母存在，扣除一次
        }
        
        return true
    }
}
```

### 2-3 Swift 語法複習

- `dict[char, default: 0] += 1`：是 Swift 中統計字母數量的簡便寫法
- `guard let` / `guard count > 0`：提早處理錯誤條件，讓邏輯更平坦
- `for-in`：遍歷字串中每個字元

---

📂 回到主目錄：[返回 LeetCode 題解總表](../README.md)
