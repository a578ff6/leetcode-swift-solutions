# LeetCode #1 - Two Sum（Swift 解法）

## 📂 題目分類

- 題型：Array 操作、Hash Table
- 難度：Easy
- 練習重點：
  - 練習雙層迴圈暴力解法的基本邏輯
  - 學會使用 Dictionary（HashMap）提升搜尋效率
  - 理解補數（complement）與查表思維的應用

---

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

## 💡 解法一：暴力解法（Brute Force）

### 1-1 解法思路

1. 用兩層 for 迴圈檢查所有組合 `(i, j)`
2. 如果 `nums[i] + nums[j] == target`，就回傳 `[i, j]`
3. 題目保證有解，所以可以直接 return

---

### 1-2 Swift 程式碼

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

---

### 1-3 Swift 語法複習

- `for i in 0..<nums.count`：基本的 for loop ，從 0 走到 nums 最後一個 index
- `for j in i+1..<nums.count`：從下一個開始，避免重複配對或選到同一個元素
- `return [i, j]`：可以直接回傳一個整數陣列

---

## 💡 解法二：使用 Dictionary 優化（HashMap）

### 2-1 為什麼使用 Dictionary？

- 暴力解法的問題：每次都得重新檢查是否有另一個數字加起來等於 target，相對耗時
- Dictionary 的優勢：邊走陣列邊記錄數值，讓我們只要「查表」就能知道答案是否存在。

📌 如果我能記住我走過的數字，我是不是只需要一層迴圈就能解決問題？這就是 HashMap 解法的核心。

---

### 2-2 解法思路

1. 建立一個空的 `dict: [Int: Int]`  
2. 用 `enumerated()` 走訪陣列，取得 `(i, num)`
3. 每次計算 `target - num = complement`
4. 查 Dictionary 裡有沒有 complement：  
   - 有 → 回傳 `[dict[complement]!, i]`
   - 沒有 → 將 `num: i` 加進 dict，繼續走

---

### 2-3 Swift 程式碼

```swift
func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    var dict = [Int: Int]()

    for (i, num) in nums.enumerated() {
        let complement = target - num

        if let j = dict[complement] {
            return [j, i]
        }
        dict[num] = i
    }
    return []
}
```

---

### 2-4 Swift 語法複習

- `enumerated()`：取得陣列中每個元素的 index 與值
- `dict[complement]`：查 Dictionary 是否有目標值
- `dict[num] = i`：記錄目前數字與其 index，方便下一次查找

---

📂 回到主目錄：[返回 LeetCode 題解總表](../README.md)
