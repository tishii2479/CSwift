cswift test.swift -o out.cpp

echo "Input file"
echo "----------------------------------"
cat test.swift
echo "----------------------------------"

echo "Compling out.cpp..."
g++ out.cpp -std=c++17

echo "Finished compile."

echo "Output file"
echo "----------------------------------"
cat out.cpp
echo "----------------------------------"

./a.out
