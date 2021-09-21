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
input(n, k)
print(n, k)
```

### Output C++ Code

```cpp
#include <bits/stdc++.h>
using namespace std;
int main() {
int n, k;
cin >> n >> k;
cout << n << k << endl;
}
```
