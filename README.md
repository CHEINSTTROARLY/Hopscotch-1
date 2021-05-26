# Hopscotch-1
So A Clone of Hopscotch

Tried to add as many features as I could. I will very soon implement my `exec` function that I created.

Projects are not runnable yet. That's the easy part, though. The hard part was making this UI. Users can actually mutate the text surrounded by white. That was most tricky to make.

Features:
- run small programs (i.e. print)
- simple data types: bool, int, float, string, arrays\<T>, dictionary<T,U>, range\<T>, set\<T>
- variables
- if, else, elif
- for loops, while loops, repeat n times
- continue, break
- fuctions, parameters, return types
- structs, classes, enums, enum cases
- attributes, static variables, static functions, initializers
- persisting variables: use "store" instead of "var"

---

Now the porgram is runnable! Blocks that work:
- run, var, if, elif, else, for, while, repeat, break, continue
- func, return, parameters for funcs~

More TODOs:
- implement parsing for Array, Set, Dict, Tuple, etc. `[1,2,3].arrayInt` or `[1,2,3].as([int])`
___

![Example 1](https://github.com/CHEINSTTROARLY/Hopscotch-1/blob/main/Example1.png)
![Example 2](https://github.com/CHEINSTTROARLY/Hopscotch-1/blob/main/Example2.png)
![Example 3](https://github.com/CHEINSTTROARLY/Hopscotch-1/blob/main/Example3.png)


---

Here's the program as a string, so that it can be saved:

```swift
var textual =
"""
run|foo += 1|_ind(0)
if|true|_ind(0)
run|print(Hello World!)|_ind(1)
else|true|_ind(0)
run|print(Goodbye Cruel World?)|_ind(1)

if|foo == 1|_ind(0)
if|(5 + 5 + 5) == true|_ind(1)
if|(5 + 5 + 5) == true|_ind(2)
break|_ind(3)
if|(5 + 5 + 5) == true|_ind(3)
if|(5 + 10 + 5) == true|_ind(4)
var|foobar|=|10|_ind(0)
var|foobar|=|10|_ind(0)
for|i|in|7|_ind(0)
var|doThis|=|1101000|_ind(1)
if|Bool.random()|_ind(1)
continue|_ind(2)
run|print(Hello World!)|_ind(1)

struct|Foo|_ind(0)
func|doThis|(int, int, int)|_ind(1)
run|foo += 1|_ind(2)
return|true|_ind(2)
class|Foo|_ind(0)
enum|Foo|_ind(0)
case|foo|_ind(1)
case|bar|_ind(1)
"""
```


---

# Fibonacci

```swift
var textual =
"""
var|one|=|0.bigint|_ind(0)
var|two|=|1.bigint|_ind(0)
while|true|_ind(0)
var|sum|=|$one.add($two)|_ind(1)
run|print($sum)|_ind(1)
var|one|=|$two|_ind(1)
var|two|=|$sum|_ind(1)
"""
```

[Click here to see the results of the program below](https://github.com/CHEINSTTROARLY/Hopscotch-1/blob/main/Proof1Fibonacci.md)

![Fibs](https://github.com/CHEINSTTROARLY/Hopscotch-1/blob/main/Fibonacci.png)



