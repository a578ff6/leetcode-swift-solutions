# LeetCode 題解筆記 #2：Valid Anagram（Swift）

---

## 📝 題目連結

[https://leetcode.com/problems/valid-anagram](https://leetcode.com/problems/valid-anagram)

---

## ❓ 題目說明

給定兩個字串 `s` 和 `t`，判斷 `t` 是否是 `s` 的 anagram（異位詞）。  
Anagram 指的是：由**相同字母、數量也一致**，只是順序不同。

---

## 1️⃣ 解法一：排序法

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


