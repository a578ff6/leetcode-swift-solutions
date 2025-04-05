# LeetCode 題解筆記 #4：Valid Palindrome（Swift）

---

## 📂 題目分類

- 題型：字串處理（String）、雙指標（Two Pointers）
- 難度：Easy
- 練習重點：
  - 練習字串清洗（保留英數字元、轉小寫）
  - 使用雙指標比對字元是否對稱
  - 理解回文（Palindrome）的定義與變形題邏輯

---

## 📝 題目連結

[https://leetcode.com/problems/valid-palindrome](https://leetcode.com/problems/valid-palindrome)

---

## ❓ 題目說明

給定一個字串 `s`，判斷它是否為「**回文（Palindrome）**」。

但這題的回文定義比較嚴格：

- **忽略大小寫**（A == a）
- **忽略非英數字元**（只保留字母與數字）

回文的意思是：從前讀和從後讀都一樣的字串。

---

### ✅ 範例

```swift
Input:  "A man, a plan, a canal: Panama"
Output: true
// 清洗後變成 "amanaplanacanalpanama"

Input:  "race a car"
Output: false
// 清洗後變成 "raceacar"

Input:  " "
Output: true
// 空字串也視為回文
```

---

## 💡 解法一：雙指標 + 字元過濾

### 1–1 解法思路

這題的重點有兩個：

1. 清洗字串：只保留英文字母與數字，並全部轉成小寫  
2. 使用雙指標：從兩端往中間比對，只要遇到不一樣就 return false

---

👉 核心判斷邏輯：

| 狀況                     | 要做的動作           |
|--------------------------|----------------------|
| 不是字母也不是數字       | 跳過、繼續靠攏        |
| 是字母或數字但不相等     | 直接 return false    |
| 是字母或數字且相等       | 繼續往中間走          |

---

🧠 **總結：**  

- 只要遇到非字母數字就跳過，遇到有效字元就比對。  
- 若有不同就直接 return false，全部都一樣才是回文。

---

### 1-2 Swift 程式碼

```swift
// MARK: - 解法一：雙指標 + 字元過濾
func isPalindrome(_ s: String) -> Bool {
    
    // Step 1：將字串轉成小寫字元陣列，方便比對
    let chars = Array(s.lowercased())
    var left = 0
    var right = chars.count - 1
    
    // Step 2：使用雙指標從兩端往中間掃描
    while left < right {
        
        // 忽略左邊不是英數的字元
        if !chars[left].isLetter && !chars[left].isNumber {
            left += 1
            continue
        }
        
        // 忽略右邊不是英數的字元
        if !chars[right].isLetter && !chars[right].isNumber {
            right -= 1
            continue
        }
        
        // 若左右字元不同，代表不是回文
        if chars[left] != chars[right] {
            return false
        }
        
        // 字元相同，繼續往中間靠攏
        left += 1
        right -= 1
    }
    
    // 所有字元都配對成功，代表是回文
    return true
}
```

---

### 1-3 Swift 語法補充

- `.lowercased()`：把整段字串轉成小寫，方便統一比對
- `.isLetter、.isNumber`：判斷字元是否為字母 / 數字
- `Array(s)`：把字串轉成可用 index 存取的字元陣列
- `while + continue`：跳過不需要比對的字元

---

📂 回到主目錄：[返回 LeetCode 題解總表](../README.md)