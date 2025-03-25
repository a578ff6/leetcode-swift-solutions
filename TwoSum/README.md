# LeetCode #1 - Two Sum（Swift 解法）

## 📝 題目連結

[https://leetcode.com/problems/two-sum](https://leetcode.com/problems/two-sum)

---

## ❓ 題目說明

給一個整數陣列 `nums` 和一個整數目標值 `target`，  
找出陣列中兩個數字，使它們相加等於 `target`，  
然後回傳它們的 **index**。

- 每筆輸入保證一定會有解  
- 不可以使用同一個元素兩次  
- 回傳任意一組答案即可（不要求順序）

---

## 💡 解法一：

### ✅ 思路整理

1. 用兩層 for 迴圈檢查所有組合 `(i, j)`
2. 如果 `nums[i] + nums[j] == target`，就回傳 `[i, j]`
3. 題目保證有解，所以可以直接 return

---

### 🔧 Swift 程式碼

```swift
func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    for i in 0..<nums.count {
        for j in i+1..<nums.count {
            if nums[i] + nums[j] == target {
                return [i, j]
            }
        }
    }
    return []
}
```

## 📚 Swift 語法複習：

- for i in 0..<nums.count：基本的 for loop ，從 0 走到 nums 最後一個 index
- for j in i+1..<nums.count：從下一個開始，避免重複配對或選到同一個元素
- return [i, j]：可以直接回傳一個整數陣列