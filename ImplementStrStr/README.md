# LeetCode 題解筆記 #28：Implement strStr()（Swift）

---

## 📂 題目分類

- 題型：String 操作、子字串搜尋
- 難度：Easy
- 練習重點：
  - 使用 Swift 的 `range(of:)` 找子字串出現位置
  - 練習逐格比對（Sliding Window + Nested Loop）
  - 處理邊界情況（空字串、長度不符）

---

## 📝 題目連結  

[https://leetcode.com/problems/implement-strstr](https://leetcode.com/problems/implement-strstr)

---

## ❓ 題目說明

實作 `strStr(haystack, needle)` 函式：  

- 回傳 `needle` 在 `haystack` 中「**第一次出現的位置 index**」，  
- 如果沒有出現過，回傳 `-1`。  
- 根據題目規定，若 `needle` 為空字串，**回傳 `0`**

---

### ✅ 範例

```swift
Input: haystack = "hello", needle = "ll"
Output: 2

Input: haystack = "leetcode", needle = "leeto"
Output: -1

Input: haystack = "abc", needle = ""
Output: 0
```

---

## 💡 解法一：使用 Swift 的內建 range(of:)

### 1–1 解法思路

- 使用 Swift 中 String 的方法 `range(of:)`，可以找到`子字串`在`母字串`中第一次出現的區間`（Range<String.Index>）`
- 接著使用 `distance(from:to:)` 來將 Swift 的 `String.Index` 轉換為整數型別
- 如果找不到範圍，表示沒有出現過，回傳 -1

---

### 1-2 總結

- 透過 range(of:) 找出子字串第一次出現的位置，搭配 distance(from:to:) 轉換成 Int index，若找不到就回傳 -1。

| 步驟 | 說明 |
|------|------|
| 1️⃣ 檢查 `needle` 是否為空 | 是的話直接回傳 `0`（題目規定） |
| 2️⃣ 使用 `range(of:)` 查找 | 嘗試找出 `needle` 在 `haystack` 中的區間 |
| 3️⃣ 找不到 → 回傳 `-1` | 如果找不到，代表子字串不存在 |
| 4️⃣ 找到 → 轉換 index | 使用 `distance(from:to:)` 將位置轉換為 `Int`，回傳結果 |

--- 

### 1–2 程式碼

```swift
// MARK: - 解法一：使用 Swift 的內建 range(of:)
/// 回傳 needle 在 haystack 中第一次出現的 index，如果找不到回傳 -1
func strStr(_ haystack: String, _ needle: String) -> Int {
    
    // 如果 needle 是空字串，根據題目要求要回傳 0
    if needle.isEmpty { return 0 }
    
    // 如果找不到，就回傳 -1
    guard let range = haystack.range(of: needle) else {
        return -1
    }
    
    // 成功找到範圍，將 String.Index 轉換為 Int 型別的 index
    let index = haystack.distance(from: haystack.startIndex, to: range.lowerBound)
    return index
}
```

---

### 1-3 語法補充

- `range(of:)`：回傳 Range<String.Index>?，表示子字串在母字串中出現的位置
- `distance(from:to:)`：將字串的 Index 轉成 Int 整數值
- `needle.isEmpty`：題目要求若 needle 為空，需回傳 0

---

## 💡 解法二：暴力法（手動比對）

### 2–1 解法思路

- 將 haystack 和 needle 各轉成 [Character]
- 外層用 i 滑動 haystack，逐格嘗試從該位置比對 needle
- 內層用 j 比對 needle 與 haystack 子字串是否一樣
- 若 haystack[i + j] 與 needle[j] 都一致，代表成功找到匹配 → 回傳 i
- 否則比對失敗就繼續下一格滑動

---

### 2–2 總結（逐格比對）

- 用 `i` 在 haystack 中滑動起點，搭配 `j` 每次逐一比對 needle，  
- 找到完整對應時回傳起點 `i`，否則繼續滑動直到比完為止。

| 步驟 | 說明 |
|------|------|
| 0️⃣ | 若 needle 長度 > haystack，直接回傳 -1（提前防止 crash） |
| 1️⃣ | 把 `haystack`、`needle` 各轉為陣列 |
| 2️⃣ | 使用 `i` 遍歷 `haystack`，最多到 `haystack.count - needle.count` |
| 3️⃣ | 每次嘗試比對 `haystack[i + j]` 與 `needle[j]` |
| 4️⃣ | 若完全一致 → 回傳 `i`；若失敗 → 繼續往下一格滑動 |
| 5️⃣ | 都沒成功找到 → 回傳 `-1` |

---

### 2–3 程式碼

```swift
// MARK: - 解法二：逐格比對（手動滑窗）
/// 回傳 needle 在 haystack 中第一次出現的 index，如果找不到回傳 -1
func strStr(_ haystack: String, _ needle: String) -> Int {
    
    // 如果 needle 是空字串，根據題目要求要回傳 0
    if needle.isEmpty { return 0 }
    
    // 將字串轉換為 [Character] 陣列，方便使用索引進行比對
    let haystackArray = Array(haystack)
    let needleArray = Array(needle)
    
    // 防呆檢查：如果 needle 比 haystack 還長，一定無法匹配 → 回傳 -1
    if needleArray.count > haystackArray.count { return -1 }
    
    // 外層迴圈：用 i 當作 haystack 的起始比對位置，從 haystack 開始逐格滑動，每次檢查 needle 長度的區段
    // 只需要走到 haystack.count - needle.count 為止
    for i in 0..<(haystackArray.count - needleArray.count + 1) {
        
        var match = true
        
        // 內層迴圈：用 j 去比對 needle 目前區段內的每一個字元
        for j in 0..<needleArray.count {
            
            // 每次都比對 haystack 從 i 開始的子字元與 needle 對應位置
            // i + j：代表目前在 haystack 要比對的實際位置
            // j：代表在 needle 中的位置
            // 如果這兩個字元不同，代表這一段不是目標
            if haystackArray[i + j] != needleArray[j] {
                match = false
                break
            }
        }
        
        // 如果整段都相符，就回傳目前起點 i
        if match { return i }
    }
    
    // 走完都沒找到 → 回傳 -1
    return -1
}
```

---

### 2–4 語法補充

- `Array(haystack)`：將字串轉成 [Character] 陣列
- `i + j`：
    - `i`：目前比對的起點（外層滑動）
    - `j`：目前 needle 的 index（內層比對）
    - 所以 `haystack[i + j]` 對應到 `needle[j]`，一個個比
- 若全都相等，代表有完整 match → 回傳起始位置 i

---

### 2–5 補充：為什麼要比對 haystack[i + j] 與 needle[j]？

這是一種「滑動視窗 + 內部比對」的技巧，想像 needle 貼到 haystack 上比對的過程：

- i 是目前滑動到的起始位置
- j 是 needle 的每個字元位置
- 每次比對 haystack[i + j] 對應 needle[j]，看是否整段完全符合

---

### 📊 圖解範例：haystack = `"hello"`、needle = `"ll"`

這段過程就像：

- `i + j` 是為了讓 needle 的第 j 個字元，對應到 haystack 從第 i 格開始的子字串位置。
- 比對過程中，只要出現一個不符，就立即中止這一輪比對，直接進入下一個起點。

```swift
for i in 0..<(haystackArray.count - needleArray.count + 1) {
    for j in 0..<needleArray.count {
        if haystackArray[i + j] != needleArray[j] {
            break // 只要有一個字元不相等，就不比了
        }
    }
}
```

---

| `i` 值 | 比對過程 | 結果 |
|--------|-----------|--------|
| 0 | `"he"` ← `haystack[0+0] = h`, `needle[0] = l` ❌ 不符 | 繼續滑動 |
| 1 | `"el"` ← `haystack[1+0] = e`, `needle[0] = l` ❌ 不符 | 繼續滑動 |
| 2 | `"ll"` ← `haystack[2+0] = l`, `needle[0] = l` ✅<br>`haystack[2+1] = l`, `needle[1] = l` ✅ | ✅ 完整比對 → 回傳 2 |

---

### ⚠️ 2–6 Crash 原因與修正方式

- 在部分邊界測資（如 `haystack = "a"`、`needle = "ab"`）中，
- 若沒有加入「`needle.count > haystack.count`」的條件判斷，就會導致越界存取（runtime error）。

因此補上這段防呆邏輯

```swift
if needleArray.count > haystackArray.count { return -1 }
```

---

📂 回到主目錄：[返回 LeetCode 題解總表](../README.md)