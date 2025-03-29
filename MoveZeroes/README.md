# LeetCode 題解筆記 #6：Move Zeroes（Swift）

---

## 📝 題目連結

[https://leetcode.com/problems/move-zeroes](https://leetcode.com/problems/move-zeroes)

---

## ❓ 題目說明

給一個整數陣列 `nums`，將：

- 把 所有的 0 移到陣列最後面
- 非 0 元素的相對順序要保持不變
- 必須「**in-place 原地操作**」，不可以使用額外陣列  

---

### ✅ 範例

```swift
Input:  [0, 1, 0, 3, 12]
Output: [1, 3, 12, 0, 0]

Input:  [0]
Output: [0]
```

---

## 💡 解法一：使用 Two Pointers 將非零元素往前搬

### 1–1 解法思路

- 用「雙指標」的方式，把非 0 元素依序搬到前面，剩下的位置再補 0。

---

### 1-2 解法流程

| 步驟 | 說明 |
|------|------|
| 1   | 用指標 `lastNonZeroIndex` 記錄非零元素要放的位置 |
| 2   | 用 `for` 走訪陣列：如果遇到非 0，就搬到 `lastNonZeroIndex` 的位置 |
| 3   | 搬完後，再從 `lastNonZeroIndex` 開始，把剩下的位置補上 0 |

---

### 1-3 總結

「先把非 0 元素往前搬，剩下的位置補成 0，過程中不開新陣列，就是 in-place 解法！」

---

### 1-4 Swift 程式碼

```swift
// MARK: - 解法一：使用 Two Pointers 將非零元素往前搬
func moveZeroes(_ nums: inout [Int]) {

    // 指標：記錄下個非零元素應該放的位置
    var lastNonZeroIndex = 0

    // 第一步：把所有非 0 元素搬到前面，並更新下一個非零元素應該放的位置
    for i in 0..<nums.count {
        if nums[i] != 0 {
            nums[lastNonZeroIndex] = nums[i]
            lastNonZeroIndex += 1
        }
    }

    // 第二步：剩下的位置補成 0
    for i in lastNonZeroIndex..<nums.count {
        nums[i] = 0
    }
}
```

---

### 1-5 語法補充

- `inout`：表示傳入的 nums 陣列會被原地修改
- `nums[i] != 0`：比對是否為非零元素
- `.count`：陣列長度，用來控制迴圈範圍

---

📂 回到主目錄：[返回 LeetCode 題解總表](../README.md)