# LeetCode 題解筆記 #232：Implement Queue using Stacks（Swift）

---

## 📂 題目分類

- 題型：資料結構模擬、Stack 模擬 Queue
- 難度：Easy
- 練習重點：
    - 使用兩個 Stack 模擬先進先出 `(FIFO)` 的 `Queue` 行為
    - 理解 Stack 與 Queue 的差異
    - 操作 Stack 的轉換技巧與時機控制

---

## 📝 題目連結

[https://leetcode.com/problems/implement-queue-using-stacks](https://leetcode.com/problems/implement-queue-using-stacks)

---

## ❓ 題目說明

設計一個「先進先出（FIFO）」的 Queue 結構，並只能使用 Stack 來實作。

- 需支援以下操作：

    - `push(x)`：將元素 x 推入 queue 的尾端
    - `pop()`：移除並回傳 queue 最前端的元素
    - `peek()`：回傳 queue 最前端的元素（不移除）
    - `empty()`：判斷 queue 是否為空

---

## ✅ 範例

```swift
輸入：
["MyQueue","push","push","peek","pop","empty"]
[[],[1],[2],[],[],[]]

輸出：
[null,null,null,1,1,false]
```

---

## 💡 解法：使用兩個 Stack 模擬 Queue

### 1–1 解法思路

1. `Queue` 是「先進先出」的結構，但 `Stack` 是「先進後出」，要怎麼模擬？

2. 我們可以透過兩個 Stack：

| Stack 名稱 | 用途說明                                     |
|------------|----------------------------------------------|
| inStack    | 專門處理 `push` 操作（先進元素放入這邊）        |
| outStack   | 專門處理 `pop` / `peek` 操作                     |

3. 轉換時機：

- 只有在 outStack 為空時，才會從 inStack 把元素整批轉過來 → 確保順序正確

---

### 1–2 操作時機說明

兩個 `Stack` 就能模擬出一個 `Queue`：一邊負責 `push`、一邊負責 `pop`，轉換時機要掌握得好！

| 操作      | 行為描述                                                                 |
|-----------|--------------------------------------------------------------------------|
| push(x)   | - 將 x 加入 `inStack`                                                      |
| pop()     | - 若 `outStack` 為空 → 把 `inStack` 所有元素反轉放入 `outStack`<br>- 再從 `outStack` pop |
| peek()    | - 若 `outStack` 為空 → 一樣先反轉 `inStack`<br>- 查看 `outStack` 最上層元素（即 queue 首項） |
| empty()   | - 判斷兩個 Stack 是否都為空即可                                           |

---

### 1-3 程式碼

```swift
// MARK: - 使用兩個 Stack 模擬 Queue 結構（先進先出 FIFO）
class MyQueue {

    /// 主 stack：接收 push 的元素（扮演 queue 的尾端）
    private var inStack: [Int] = []
    
    /// 輔助 stack：負責處理 pop / peek（扮演 queue 的前端）
    /// - 當需要取出元素時，會將 inStack 內容反轉搬進 outStack，以還原先進先出的順序
    private var outStack: [Int] = []
    
    /// 初始化 queue
    init() {}
    
    /// 將元素 x 加入 queue 尾端
    func push(_ x: Int) {
        inStack.append(x)
    }
    
    /// 移除並回傳 queue 最前端的元素
    func pop() -> Int {
        
        /// 當 outStack 為空，才從 inStack 將元素倒進來（反轉順序）
        ///
        ///  - 反轉搬移順序，讓 outStack 模擬 queue 的前端
        if outStack.isEmpty {
            
            while let val = inStack.popLast() {
                outStack.append(val)
            }
        }
        
        /// 回傳 outStack 最上層的元素（也就是 queue 的最前端）
        return outStack.popLast() ?? -1
    }
    
    /// 回傳 queue 最前端元素（不移除）
    func peek() -> Int {
        
        /// 反轉搬移順序，讓 outStack 模擬 queue 的前端
        ///
        ///  - 把 inStack 全部搬到 outStack，反轉順序
        if outStack.isEmpty {
            while let val = inStack.popLast() {
                outStack.append(val)
            }
        }
        
        /// 查看最前端的元素（不移除）
        return outStack.last ?? -1
    }
    
    /// 判斷 queue 是否為空
    func empty() -> Bool {
        return inStack.isEmpty && outStack.isEmpty
    }
    
}
```

---

### 1-4 測試一（LeetCode範例）

```swift
let queueOne = MyQueue()

queueOne.push(1)
queueOne.push(2)

print(queueOne.peek())   // ➜ 1：查看最前面的元素，不移除
print(queueOne.pop())    // ➜ 1：移除最前面的元素
print(queueOne.empty())  // ➜ false：還有 2 在 queue 裡
```

---

### 1-5 對應流程圖解

| 操作     | inStack   | outStack | 備註                                           |
|----------|-----------|----------|------------------------------------------------|
| push(1)  | [1]       | []       | 將 1 加入 `inStack`                             |
| push(2)  | [1, 2]    | []       | 將 2 加入 `inStack`                              |
| peek()   | []        | [2, 1]   | 將 `inStack` 反轉後放到 `outStack`，peek = 1       |
| pop()    | []        | [2]      | 移除 `outStack` 的 top (1)                       |
| empty()  | []        | [2]      | 還有元素 2 → false                             |

---

### 1-6 語法複習

| 語法                      | 說明                                                             |
|---------------------------|------------------------------------------------------------------|
| `stack.append(x)`         | 將元素推入陣列（模擬 Stack 推入）                                 |
| `stack.popLast()`         | 移除並回傳最後一個元素（模擬 Stack 彈出）                         |
| `stack.last`              | 查看陣列最後一項但不移除                                          |
| `while let val = ...`     | 持續 pop 元素直到 nil（空陣列）                                   |
| `guard let val = ... else`| 如果無值則提早 return，保護程式不崩潰                              |
| `private` 屬性            | 隱藏內部實作細節，外部無法直接存取，提升封裝性                    |

---

#### ✨ 額外補充：Stack 模擬 Queue 的轉換邏輯

這段程式碼會讓 inStack 的順序變成 queue 的順序（先進的會跑到 outStack 的後面）

```swift
// 若 outStack 是空的，就把 inStack 的東西全部「反轉」到 outStack 中
if outStack.isEmpty {
    while let val = inStack.popLast() {
        outStack.append(val)
    }
}
```

---

## 測試二（多次 pop 測試 queue 邏輯是否正確）

```swift
輸入：
 
 ["MyQueue", "push", "push", "push", "pop", "pop", "push", "pop", "peek", "empty", "pop", "empty"]

 [[], [10], [20], [30], [], [], [40], [], [], [], [], []]

 預期輸出：

 [null, null, null, 10, 20, null, 30, 40, false, 40, true]
```

---

### 2-1 延伸測試與圖解：重複最小值的情況

```swift
let queueTwo = MyQueue()

queueTwo.push(10)
queueTwo.push(20)
queueTwo.push(30)

print(queueTwo.pop())   // ➜ 10（最先進來）
print(queueTwo.pop())   // ➜ 20（次先進來）

queueTwo.push(40)

print(queueTwo.pop())   // ➜ 30（剩下的那個）
print(queueTwo.peek())  // ➜ 40（最新加入，但還沒被移除）
print(queueTwo.empty()) // ➜ false（還有一個元素）
print(queueTwo.pop())   // ➜ 40（最後一個）
print(queueTwo.empty()) // ➜ true（完全清空）
```

---

### 2-2 對應流程圖解

| 操作         | inStack       | outStack     | 備註說明                                                  |
|--------------|---------------|--------------|-----------------------------------------------------------|
| push(10)     | [10]          | []           | 初始推入 10，放在 inStack 中                              |
| push(20)     | [10, 20]      | []           | 繼續推入 20 → FIFO 的尾端                                 |
| push(30)     | [10, 20, 30]  | []           | 推入 30 → 還是在尾端                                       |
| pop() → 10   | []            | [30, 20]     | `outStack` 為空 → 將 `inStack` 反轉搬移後，從 `outStack` 移除並回傳               |
| pop() → 20   | []            | [30]         | 直接從 `outStack` 移除最上層元素並回傳  |
| push(40)     | [40]          | [30]         | 再次推入新值，暫存在 `inStack` 中                           |
| pop() → 30   | [40]          | []           | `outStack` 只剩一個，pop 完後為空                      |
| peek() → 40  | []            | [40]         | `outStack` 為空 → 反轉搬移 `inStack，查看最前元素`             |
| pop() → 40   | []            | []           | 移除最後一個元素，Queue 清空                   |
| empty() → ✅ | []            | []           | 雙 stack 都為空 → Queue 為空                              |

---

## 📦 補充概念：什麼是 FIFO（先進先出）？

`Queue`（佇列）是一種「先進先出」的資料結構，簡單來說：

```
誰先排進來，就先被處理！
```

---

### 🎯 舉個例子：

我們在買咖啡排隊 ☕️，場景如下：

```
排隊順序：A → B → C
```

- 那麼：

    - A 是第一個到的 → 也會是 第一個被處理
    - C 是最後一個到的 → 要等前面的人處理完

- 這就是：

    - 先進先出（FIFO：First In, First Out）

---

### 🆚 與 Stack 的差別？

| 概念       | Stack（堆疊）         | Queue（佇列）         |
|------------|------------------------|------------------------|
| 結構特性   | 後進先出（LIFO）       | 先進先出（FIFO）       |
| 像什麼？   | 疊盤子 🍽️              | 排隊買東西 🧋           |
| 行為       | 最後放進去的先拿        | 最先放進去的先拿        |

---

### 🧠 實作重點回顧

1. `Stack` 自然是 LIFO，要「模擬 FIFO」，就需要技巧
2. 使用兩個 Stack，來模擬出隊列的進出順序
3. 利用反轉順序達到「誰先進來、誰先出去」的行為

---

📂 回到主目錄：[返回 LeetCode 題解總表](../README.md)