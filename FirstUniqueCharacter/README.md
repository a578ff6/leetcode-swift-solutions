# LeetCode 題解筆記 #7：First Unique Character in a String（Swift）

---

## 📝 題目連結  
[https://leetcode.com/problems/first-unique-character-in-a-string](https://leetcode.com/problems/first-unique-character-in-a-string)

---

## ❓ 題目說明

給定一個字串 `s`，找出「**第一個只出現一次的字元**」，並回傳它的 **index**。

- 如果沒有只出現一次的字元，回傳 `-1`

---

### ✅ 範例

```swift
Input:  s = "leetcode"
Output: 0  // 'l' 是第一個只出現一次的字元

Input:  s = "loveleetcode"
Output: 2  // 'v' 是第一個只出現一次的字元

Input:  s = "aabb"
Output: -1  // 沒有只出現一次的字元
```

---

## 💡 解法一：兩次走訪字串

### 1–1 解法思路

- 「先統計每個字元出現的次數，再找出第一個只出現一次的字元」

---

### 1-2 解法流程

| 步驟 | 說明 |
|------|------|
| 1.建立一個字典 | 用來記錄每個字元出現的次數 |
| 2.第一次走訪字串 | 用 `for char in s` 一個個讀出字元，將它們丟進字典中累加 |
| 3.第二次走訪字串 | 使用 `for (index, char) in s.enumerated()` 逐一檢查，找第一個出現次數為 1 的字元，回傳 index |
| 4.若沒找到 | 回傳 `-1` |

---

### 1-3 總結

- 「兩次走訪，一次統計、一次尋找，記得第二次需要拿到 index」

| 行為                     | 原因                                                   |
|--------------------------|--------------------------------------------------------|
| 用兩次走訪字串            | 因為「只出現一次的字元」是要先統計後才能判斷               |
| 第二次用 `enumerated()` | 因為題目要回傳的是 index，不只是字元                       |
| 為什麼不能只走一次？       | 因為走第一次時不知道一個字元後續會不會重複，需先統計全字串 |

---

### 1-4 程式碼

```swift
// MARK: - 解法一：兩次遍歷法
// 第一次統計字母出現次數，第二次找第一個只出現一次的字元
func firstUniqChar(_ s: String) -> Int {
    
    // 建立字典：統計每個字元出現次數
    var counter = [Character: Int]()

    // 第一次走訪：統計字母出現次數
    for char in s {
        counter[char, default: 0] += 1
    }

    // 第二次走訪：找第一個只出現一次的字元，並回傳位置
    for (index, char) in s.enumerated() {
        if counter[char] == 1 {
            return index
        }
    }

    // 如果沒有只出現一次的字元，回傳 -1
    return -1
}    
```

---

### 1-5 語法補充

- `enumerated()`：可以同時取得 index 與字元
- `dict[char, default: 0] += 1`：常見的統計字元技巧
- `回傳 -1` 符合題目要求的預設值（沒有唯一字元時）

---

📂 回到主目錄：[返回 LeetCode 題解總表](../README.md)