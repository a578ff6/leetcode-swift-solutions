# LeetCode 題解筆記 #5：Contains Duplicate（Swift）

---

## 📝 題目連結

[https://leetcode.com/problems/contains-duplicate](https://leetcode.com/problems/contains-duplicate)

---

## ❓ 題目說明

給定一個整數陣列 `nums`，判斷裡面是否有 **重複的數字**。

- 只要有任意一個數字在陣列中出現超過一次，就回傳 `true`；  
- 如果每個數字都只出現一次，則回傳 `false`。

---

### ✅ 範例

```swift
Input: [1, 2, 3, 1]
Output: true

Input: [1, 2, 3, 4]
Output: false

Input: [1,1,1,3,3,4,3,2,4,2]
Output: true
```

---

## 💡 解法一：使用 Set 判斷是否重複

### 1–1 解法思路

這題的關鍵在於「如何快速知道某個數字是否已經出現過」。

可以利用 Set（集合）這種資料結構的特性：

1. 建立一個空的 Set
2. 每走訪一個數字，就去檢查是否已經存在於 Set 中
    - 如果存在 → 表示重複 → 回傳 true
    - 否則就把這個數字記錄進去
3. 全部檢查完都沒出現過 → 回傳 false

---

👉 **核心判斷邏輯：**

| 狀況             | 要做的動作              |
|------------------|-------------------------|
| 數字已存在 Set    | 回傳 true（有重複）       |
| 數字不在 Set     | 加進 Set，繼續走         |

---

🧠 **總結：**  

- 利用 Set 具備「不允許重複」的特性，讓我們能夠快速檢查是否有數字出現過。

---

### 1-2 Swift 程式碼

```swift
// MARK: - 解法一：使用 Set 判斷是否重複
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
```

---

### 1-3 Swift 語法補充

- `Set<Int>()`：用來儲存不重複的整數
- `.contains()`：檢查 Set 中是否已有該元素
- `.insert()`：加入元素到 Set 中（不會加入重複的值）

---

📂 回到主目錄：[返回 LeetCode 題解總表](../README.md)