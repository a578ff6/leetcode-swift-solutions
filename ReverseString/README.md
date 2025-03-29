# LeetCode 題解筆記 #3：Reverse String（Swift）

---

## 📝 題目連結

[https://leetcode.com/problems/reverse-string](https://leetcode.com/problems/reverse-string)

---

## ❓ 題目說明

給定一個字元陣列 `s`，將陣列中的字元順序 **原地反轉**。  
也就是說，**不能額外建立一個新的陣列**，而是要直接修改輸入陣列 `s` 本身。

---

### ✅ 題目範例：

```swift
Input:  s = ["h","e","l","l","o"]
Output: ["o","l","l","e","h"]

Input:  s = ["H","a","n","n","a","h"]
Output: ["h","a","n","n","a","H"]
```

---

### 🔍 題目關鍵限制：in-place + O(1) 空間

- **in-place（原地修改）**：代表必須直接修改傳入的陣列，而不是建立一個新的結果陣列  
- **O(1) 空間複雜度**：代表只能使用常數額外記憶體（不能用其他陣列或資料結構）

這是這題的核心要求，不能用 `.reversed()` 或 `s = s.reversed()` 這類方法取巧。

---

## 💡 解法一：雙指標交換法（Two Pointers）

### 1-1 解法思路

1. 使用兩個指標 left 與 right，分別指向陣列的開頭與結尾

2. 不斷交換左右兩側的字元，直到中間相遇為止

3. 這樣就能在 O(1) 空間內完成 in-place 字元反轉

---

### 1-2 Swift 程式碼

```swift
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
```

---

### 1-3 Swift 語法複習

- `inout`：代表參數會被修改（直接作用在原陣列）
- `s.swapAt(i, j)`：Swift 提供的陣列元素交換方法
- `while left < right`：常見的 Two Pointers

---

📂 回到主目錄：[返回 LeetCode 題解總表](../README.md)