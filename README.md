# CSwift

A small converter that converts Swift code to C++.

It is still in progress of development, so it only supports few statements now.

# Usage

## Set up

**Requires swift compiler installment before executing ./release.sh**

```
$ git clone git@github.com:tishii2479/CSwift.git
$ ./release.sh
```

## Use

1. Edit your base swift file(in this case, `test.swift`).

2. Convert it using command `cswift {filename}`. The output would be named `out.cpp` for default.

```
$ cswift test.swift

$ g++ out.cpp
$ ./a.out
```

# Example

### Input Swift Code

```swift
var n = 0
input(n)
print(n)
```

### Output C++ Code

```cpp
#include <bits/stdc++.h>
using namespace std;
int main() {
    int n;
    cin >> n;
    cout << n << endl;
}
```

# TODO

Since the development is still in progress, there are many syntax that can't be parsed.
Below is a list of syntax that needs to add implementation to parse.

- String literal: `"Hello world!"`
- Multiple variable declration: `var a, b: Int`
- Float variable: `3.2`
- Array: `[1, 2, 4, 5]`
- for: `for i in 0..<10`
- while: `while i < 10`
