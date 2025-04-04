# LeetCode 題解筆記 #35：Search Insert Position（Swift）

---

## 📂 題目分類

- 題型：Array 操作、搜尋類（Search）
- 難度：Easy
- 練習重點：
  - 練習用 for loop 找插入點（線性搜尋）
  - 練習 Binary Search（二分搜尋法）縮小搜尋範圍
  - 理解「插入排序邏輯」與 index 對應

---

## 📝 題目連結  
[https://leetcode.com/problems/search-insert-position](https://leetcode.com/problems/search-insert-position)

---

## ❓ 題目說明

給定一個 **升序排列的整數陣列 `nums`**，與一個整數 `target`，  
請找出 `target` 應該插入的位置，使得陣列仍保持有序。

- 如果 `target` 已經存在，回傳它的 index
- 如果不存在，回傳它應該插入的位置 index

---

## ✅ 範例

```swift
Input: nums = [1,3,5,6], target = 5
Output: 2  // 5 已存在，位於 index 2

Input: nums = [1,3,5,6], target = 2
Output: 1  // 2 不存在，應插入在 index 1

Input: nums = [1,3,5,6], target = 7
Output: 4  // 7 不存在，應插入在末尾 index 4
```

---

## 💡 解法一：暴力法（線性走訪）

### 1–1 解法思路

1. 從頭走訪 nums 陣列，逐一檢查每個數字
2. 找到第一個「大於等於 target」的元素
3. 這個元素的 index 就是 target 應插入的位置

---

### 1–2 解法核心流程

- 找到第一個 >= target 的數字 → 回傳它的位置；若都找不到，就放最後一格。

| 步驟 | 說明 |
|------|------|
| 1️⃣ | 逐一走訪 `nums` 陣列 |
| 2️⃣ | 找到第一個 `nums[i] >= target` |
| 3️⃣ | 回傳這個 `i`，即為插入點 |
| 4️⃣ | 若找不到代表 `target` 最大 → 回傳 `nums.count` |

--- 

### 1-3 程式碼

```swift
// MARK: - 解法一：暴力法（線性走訪）
// 逐一走訪陣列，找到第一個大於等於 target 的位置

/// 給定已排序陣列 nums 與一個 target，回傳 target 應該插入在 nums 中的 index
func searchInsert(_ nums: [Int], _ target: Int) -> Int {
    
    // 逐一檢查 nums 中的元素
    for i in 0..<nums.count {
        
        // 如果找到第一個 >= target 的值，代表這個位置就是插入點
        if nums[i] >= target {
            return i
        }
    }
    
    // 如果走完整個陣列都沒遇到更大的數字
    // 代表 target 比所有數字都大 → 插在最後一位
    return nums.count
}
```

---

### 1-4 Swift 語法複習

- `for i in 0..<nums.count`： 走訪陣列的每一個 index（從 0 到 count - 1）

- `nums[i] >= target`： 判斷目前數字是否大於或等於 target

- `return nums.count`： 如果整個陣列都比 target 小，target 應插入在最後一個位置（陣列長度即為新 index）

---

### 1–5 圖解拆解：為什麼回傳 index？為什麼可能是 nums.count？

目標是找到一個位置 `i`，讓 `target` 插入後，`nums` 陣列仍然保持遞增順序。

#### 🔢 範例一：target 存在於陣列中

```swift
nums = [1, 3, 5, 6]
target = 5
```

| index | 值 | 判斷條件         |
|-------|----|------------------|
| 0     | 1  | 1 < 5 → 繼續     |
| 1     | 3  | 3 < 5 → 繼續     |
| 2     | 5  | ✅ 找到了，return 2 |

- 回傳 2，因為 5 已存在於陣列，位於 index 2。

---

#### 🔢 範例二：target 不存在，但應插入在中間

```swift
nums = [1, 3, 5, 6]
target = 2
```

| index | 值 | 判斷條件                |
|-------|----|-------------------------|
| 0     | 1  | 1 < 2 → 繼續            |
| 1     | 3  | ✅ 3 >= 2 → 回傳 index 1 |

- 回傳 1，因為 2 應插在 index 1 的位置
- 這樣才會保持陣列有序 → [1, **2**, 3, 5, 6]

---

#### 🔢 範例三：target 比所有元素都大 → 插在最後

```swift
nums = [1, 3, 5, 6]
target = 7
```

| index | 值 | 判斷條件         |
|-------|----|------------------|
| 0     | 1  | 1 < 7 → 繼續     |
| 1     | 3  | 3 < 7 → 繼續     |
| 2     | 5  | 5 < 7 → 繼續     |
| 3     | 6  | 6 < 7 → 繼續     |
| →     | 7  | ❌ 都比它小       |

- 因為都沒遇到比 7 大的，代表 它應插入在最後面
- 所以回傳 nums.count = 4，插入後會變成 [1, 3, 5, 6, **7**]

---

## ✅ Binary Search 是什麼？

在一個 **已排序** 的陣列中，**每次都從中間一分為二**，逐步縮小搜尋範圍。

---

### 👀 運作方式：

假設在一個升序陣列中找 `target = 5`：

```swift
nums = [1, 3, 5, 6]
```
---

#### Binary Search 步驟說明

| 步驟 | 說明 |
|------|------|
| 1️⃣  | 設定兩個指標 `left = 0`、`right = nums.count - 1`（代表搜尋範圍） |
| 2️⃣  | 每次取中間 `mid = (left + right) / 2` |
| 3️⃣  | 比較 `nums[mid]` 和 `target`，依情況調整搜尋範圍 |

---

#### Binary Search 判斷邏輯對照表

| 情況               | 動作                              |
|--------------------|-----------------------------------|
| `nums[mid] == target` | ✅ 找到了 → 回傳 `mid`             |
| `nums[mid] < target`  | ➡️ 目標在右邊 → `left = mid + 1`   |
| `nums[mid] > target`  | ⬅️ 目標在左邊 → `right = mid - 1`  |

---

### 📦 為什麼這麼快？

因為 每次都把搜尋範圍「砍半」，速度提升非常明顯。

- 時間複雜度：O(log n)
- 比起線性搜尋的 O(n) 快得多，特別適合資料量大的情況！

---

### 🎯 適合用在哪裡？

- 在「已排序陣列」中尋找特定值的位置
- 或者像這一題一樣，找 應該插入的位置
- 常用來找「符合條件的第一個位置」

---

## 💡 解法二：Binary Search（二分搜尋法）

### 2–1 解法思路

這題的陣列是「升序排序」，因此可以使用 Binary Search（又稱二分搜尋法）

1. 設定左右邊界 `left = 0`、`right = nums.count - 1`

2. 每次取中間值 mid，判斷 nums[mid] 和 target 的大小關係：
    - 若 `nums[mid] == target` → 回傳 mid
    - 若 `nums[mid] < target` → 繼續往右邊找：left = mid + 1
    - 若 `nums[mid] > target` → 往左邊找：right = mid - 1

3. 如果整個搜尋結束仍找不到 target，left 就會落在「應該插入的位置」

---

### 2-2 程式碼

```swift
// MARK: - 解法二：Binary Search（二分搜尋法）
// 利用已排序陣列特性，每次折半查找，提高效率

/// 給定已排序陣列 nums 與一個 target，回傳 target 應該插入在 nums 中的 index
func searchInsert(_ nums: [Int], _ target: Int) -> Int {
    
    // 初始化左右邊界
    var left = 0
    var right = nums.count - 1
    
    // 當 left <= right，表示搜尋範圍還有效，持續折半查找
    while left <= right {
        
        // 每次都從中間開始比對（折半）
        var mid = (left + right) / 2
        
        // 如果剛好找到 target，就直接回傳中間位置
        // 找到 target，直接回傳位置
        if nums[mid] == target {
            return mid
        }
        // 如果中間數小於目標，代表答案在右邊，左界往右移動
        // target 在右邊 → 縮小範圍
        else if nums[mid] < target {
            left = mid + 1
        }
        // 如果中間數大於目標，代表答案在左邊 → 右界往左移動
        // target 在左邊 → 縮小範圍
        else {
            right = mid - 1
        }
    }
    
    // 沒找到 target，left 就是「應插入的位置」
    return left
}
```

---

### 2-3 語法複習

- `var left = 0`、`var right = nums.count - 1`： 初始化搜尋範圍
- `(left + right) / 2`： 取得中間索引位置，進行比較
- `nums[mid] == target`： 找到目標值，直接回傳
- `nums[mid] < target`： 目標值在右邊 → 調整 left = mid + 1
- `nums[mid] > target`： 目標值在左邊 → 調整 right = mid - 1
- `while left <= right`： 只要範圍內還有可能性，就繼續搜尋
- `return left`： 最終沒找到時，left 是目標值應插入的位置

---

### 2–4 圖解流程範例

#### 🔢 範例一：target 存在於陣列中

```swift
nums = [1, 3, 5, 6]
target = 5
```

| 步驟 | `left` | `right` | `mid` | `nums[mid]` | 比較 `nums[mid]` vs `target` | 動作              |
|------|--------|---------|-------|-------------|-------------------------------|-------------------|
| 1    | 0      | 3       | 1     | 3           | 3 < 5                         | `left = mid + 1` → 2 |
| 2    | 2      | 3       | 2     | 5           | 5 == 5                        | ✅ 找到了 → 回傳 2 |

- 回傳結果：2

---

#### 🔢 範例二：target 不存在，但應插入在中間

```swift
nums = [1, 3, 5, 6]
target = 2
```

| 步驟 | `left` | `right` | `mid` | `nums[mid]` | 比較 `nums[mid]` vs `target` | 動作                |
|------|--------|---------|-------|-------------|-------------------------------|---------------------|
| 1    | 0      | 3       | 1     | 3           | 3 > 2                         | `right = mid - 1` → 0 |
| 2    | 0      | 0       | 0     | 1           | 1 < 2                         | `left = mid + 1` → 1 |

- left = 1、right = 0 → 搜尋結束
- 回傳結果：1（應插入在 index 1）

---

#### 🔢 範例三：target 比所有元素都大 → 插在最後

```swift
nums = [1, 3, 5, 6]
target = 7
```

| 步驟 | `left` | `right` | `mid` | `nums[mid]` | 比較 `nums[mid]` vs `target` | 動作              |
|------|--------|---------|-------|-------------|-------------------------------|-------------------|
| 1    | 0      | 3       | 1     | 3           | 3 < 7                         | `left = mid + 1` → 2 |
| 2    | 2      | 3       | 2     | 5           | 5 < 7                         | `left = mid + 1` → 3 |
| 3    | 3      | 3       | 3     | 6           | 6 < 7                         | `left = mid + 1` → 4 |

- left = 4、right = 3 → 搜尋結束
- 回傳結果：4（應插入在陣列尾端）

---

📂 回到主目錄：[返回 LeetCode 題解總表](../README.md)
