# LeetCode 題解筆記 #704：Binary Search（二分搜尋法）

---

## 📂 題目分類

- 題型：Binary Search（二分搜尋）
- 難度：Easy
- 練習重點：
    - 熟悉 折半搜尋邏輯
    - 理解 left / right / mid 的更新方式
    - 避免常見錯誤（例如無限迴圈或 off-by-one）

---

📚 延伸閱讀

「插入點」的進階應用，也可以參考：

 - [LeetCode 題解筆記 #35：Search Insert Position（Swift）](../SearchInsertPosition/README.md)

---

## 📝 題目連結  

[https://leetcode.com/problems/binary-search](https://leetcode.com/problems/binary-search)

---

## ❓ 題目說明

給定一個 **已排序（升序）** 的整數陣列 `nums`，和一個目標值 `target`，  
請使用「二分搜尋法（Binary Search）」來找出 `target` 的 index。  

- 如果 `target` 存在於陣列中，回傳對應的 index  
- 如果 `target` 不存在，回傳 `-1`

---

## ✅ 範例

```swift
Input: nums = [-1,0,3,5,9,12], target = 9
Output: 4

Input: nums = [-1,0,3,5,9,12], target = 2
Output: -1
```

---

## 💡 解法一：Binary Search（二分搜尋法）

### 1–1 解法思路

這題陣列已經排序，可以直接使用 Binary Search：

1. 設定左右邊界 left = 0、right = nums.count - 1
2. 每次取中間 index mid = (left + right) / 2
3. 判斷 nums[mid] 與 target 的關係：
    - 如果相等 → 回傳 mid
    - 如果小於 → 左界往右移：left = mid + 1
    - 如果大於 → 右界往左移：right = mid - 1
4. 若整個搜尋區間都比完，仍找不到 → 回傳 -1

--- 

### 1–2 程式碼

```swift
// MARK: - 解法一：Binary Search（二分搜尋法）
/// 在已排序的整數陣列中搜尋 target，找到就回傳 index，否則回傳 -1
func search(_ nums: [Int], _ target: Int) -> Int {
    
    // 初始化左右邊界
    var left = 0
    var right = nums.count - 1
    
    // 當搜尋範圍還有效（left 沒有超過 right）
    while left <= right {
        
        // 每次都從目前區間的中間值開始比對
        let mid = (left + right) / 2

        // 若中間的值剛好等於 target，直接回傳該 index
        if nums[mid] == target {
            return mid
        }
        // 若中間的值小於 target，表示答案在右邊 → 更新左界
        else if nums[mid] < target {
            left = mid + 1
        }
        // 若中間的值大於 target，表示答案在左邊 → 更新右界
        else {
            right = mid - 1
        }
    }
    
    // 如果全部比完都沒找到，代表 target 不存在 → 回傳 -1
    return -1
}
```

---

### 1–3 測試範例

```swift
let solution = Solution()

print(solution.search([-1, 0, 3, 5, 9, 12], 9))   // ➜ 4
print(solution.search([-1, 0, 3, 5, 9, 12], 2))   // ➜ -1
print(solution.search([1], 1))                   // ➜ 0
print(solution.search([1], 0))                   // ➜ -1
```

---

### 1–4 Swift 語法複習

- `var left = 0、var right = nums.count - 1`： 初始化二分搜尋的左右界線
- `while left <= right`： 只要搜尋區間還有效（沒有錯開），就持續搜尋
- `let mid = (left + right) / 2`： 每次取中間值來做比較
- `nums[mid] == target`： 找到了目標，直接回傳 mid
- `nums[mid] < target`： 代表目標在右邊 → 左界往右移
- `nums[mid] > target`： 代表目標在左邊 → 右界往左移
- `return -1`： 若整個區間都比完還是沒找到，回傳 -1

---

### 1–5 圖解流程範例

🔢 範例一：nums = [-1,0,3,5,9,12]，target = 9

| 步驟 | left | right | mid | nums[mid] | 判斷邏輯     | 動作                 |
|------|------|--------|-----|-----------|--------------|----------------------|
| 1    | 0    | 5      | 2   | 3         | 3 < 9        | left = mid + 1 → 3   |
| 2    | 3    | 5      | 4   | 9         | ✅ 找到目標   | 回傳 4               |

- 回傳結果：4

---

🔢 範例二：nums = [-1,0,3,5,9,12]，target = 2

| 步驟 | left | right | mid | nums[mid] | 判斷邏輯     | 動作                 |
|------|------|--------|-----|-----------|--------------|----------------------|
| 1    | 0    | 5      | 2   | 3         | 3 > 2        | right = mid - 1 → 1  |
| 2    | 0    | 1      | 0   | -1        | -1 < 2       | left = mid + 1 → 1   |
| 3    | 1    | 1      | 1   | 0         | 0 < 2        | left = mid + 1 → 2   |

- left = 2、right = 1 → 搜尋結束 → 回傳 -1

---

🔢 範例三：nums = [-1,0,3,5,9,12]，target = 13

| 步驟 | left | right | mid | nums[mid] | 判斷邏輯     | 動作                 |
|------|------|--------|-----|-----------|--------------|----------------------|
| 1    | 0    | 5      | 2   | 3         | 3 < 13       | left = mid + 1 → 3   |
| 2    | 3    | 5      | 4   | 9         | 9 < 13       | left = mid + 1 → 5   |
| 3    | 5    | 5      | 5   | 12        | 12 < 13      | left = mid + 1 → 6   |

- left = 6、right = 5 → 搜尋結束 → 回傳 -1

---

### 1–6 Binary Search 是什麼？

✅ Binary Search（二分搜尋法）是一種效率極高的搜尋方法，前提是資料已經「排序過」。

🔍 運作邏輯：

1. 每次從目前搜尋範圍中間切一半
2. 比較中間值 nums[mid] 與 target
3. 根據結果縮小搜尋範圍：
    - nums[mid] == target → ✅ 找到，直接回傳
    - nums[mid] < target → 🎯 往右找 → left = mid + 1
    - nums[mid] > target → 🎯 往左找 → right = mid - 1
4. 如果找不到，最終 left > right，就結束搜尋

📦 Binary Search 特性:

| 特性         | 說明                                 |
|--------------|--------------------------------------|
| 時間複雜度   | O(log n)，每次都把搜尋範圍砍半，速度超快 |
| 適用場景     | 資料已排序，需重複搜尋或找插入點         |

---

📂 回到主目錄：[返回 LeetCode 題解總表](../README.md)