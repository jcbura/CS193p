# Lecture 05 Video Notes

### Link to the [Video Lecture](https://www.youtube.com/watch?v=F1x-H8kEwo8).

___

**enum**

Another variety of data structure in addition to `struct` and `class`.<br>
It can only have discrete states ...
```Swift
enum FastFoodMenuItem {
    case hamburger
    case fries
    case drink
    case cookie
}
```
An `enum` is a value type (like `struct`), so it is coped as it is passed around.

Associated Data<br>
Each state can (but doesn't have to) have its own "associated data" ...
```Swift
enum FastFoodMenuItem {
    case hamburger(numberOfPatties: Int)
    case fries(size: FryOrderSize)
    case drink(String, ounces: Int) // the unnamed String is the brand, e.g., "Coke"
    case cookie
}
```
Note that the drink case has 2 pieces of associated data (one of them "unnamed").<br>
In the example above, FryOrderSize would also probably be an `enum` ...
```Swift
enum FryOrderSize {
    case large
    case small
}
```

Setting the value of an `enum`<br>
Just use the name of the type along with the case you want, separated by dot ...
```Swift
let menuItem: FastFoodMenuItem = FastFoodMenuItem.hamburger(patties: 2)
let otherItem: FastFoodMenuItem = FastFoodMenuItem.cookie
```

Swift can infer one side or the other of an '=' but not both sides.
```Swift
let menuItem = FastFoodMenuItem.hamburger(patties: 2) // this is ok
let menuItem: FastFoodMenuItem = .cookie // this is ok
let otherItem = .cookie // this is not ok
```

Checking an `enum`s state<br>
Use a `switch` statement ...
```Swift
var menuItem = FastFoodMenuItem.hamburger(patties: 2)
switch menuItem {
    case FastFoodMenuItem.hamburger: print("burger")
    case FastFoodMenuItem.fries: print("fries")
    case FastFoodMenuItem.drink: print("drink")
    case FastFoodMenuItem.cookie: print("cookie")
}
// This code would print "burger" on the console
```
Note that we're ignoring the "associated data" above ... so far ...

This is also allowed since Switft can infer ...
```Swift
var menuItem = FastFoodMenuItem.hamburger(patties: 2)
switch menuItem {
    case .hamburger: print("burger")
    case .fries: print("fries")
    case .drink: print("drink")
    case .cookie: print("cookie")
}
```

`default` and `break`<br>
A `switch` must handle all possible cases (`default` the uninteresting cases) and if you don't want to do anything in a given case, use `break` ...
```Swift
var menuItem = FastFoodMenuItem.cookie
switch menuItem {
    case .hamburger: break
    case .fries: print("fries")
    default: print("other")
}
```

Multiple lines are allowed.<br>
Each `case` in a `switch` can be multiple lines and does NOT fall through to the next case ...
```Swift
var menuItem = FastFoodMenuItem.fries(size: FryOrderSize.large)
switch menuItem {
    case .hamburger: print("burger")
    case .fries:
        print("yummy")
        print("fries")
    case .drink:
        print("drink")
    case .cookie: print("cookie")
}
```

What about the associated data?<br>
Associated data is accesed through a `switch` statement using this `let` syntax ...
```Swift
var menuItem = FastFoodMenuItem.drink("Coke", ounces: 32)
switch menuItem {
    case .hamburger(let pattyCount): print("a burger with \(pattyCount) patties!")
    case .fries(let size): print("a \(size) order of fries")
    case .drink(let brand, let ounces): print("a \(ounces)oz \(brand)")
    case .cookie: print("a cookie")
}
// This code would print "a 32oz coke" on the console
```

Methods yes, (stored) Properties no.<br>
An `enum` can have methods (and computed properties) but no stored properties ...
```Swift
enum FastFoodMenuItem {
    case hamburger(numberOfPatties: Int)
    case fries(size: FryOrderSize)
    case drink(String, ounces: Int)
    case cookie

    fun isIncludedInSpecialOrder(number: Int) -> Bool { }
    var calories: Int { /* switch on self and calculate caloric value here */ }
}
```

```Swift
enum FastFoodMenuItem {
    ...
    func isIncludedInSpecialOrder(number: Int) -> Bool {
        switch self {
            case .hamburger(let pattyCount): return pattyCount == number
            case .fries, .cookie: return true // a drink and cookie in every special order
            case .drink(_, let ounces): return ounces == 16 // & 16oz drink of any kind
        }
    }
}
```

Getting all the cases of an enumeration.
```Swift
enum TeslaModel: CaseIterable {
    case X
    case S
    case Three
    case Y
}
```
Now this `enum` will have a `static` var `allCases` that you can iterate over.
```Swift
for model in TeslaModel.allCases {
    reportSalesNumbers(for: model)
}
func reportSalesNumbers(for model: TeslaModel) {
    switch model { ... }
}
```

--- 

**Optionals**

An optional is just an `enum`.<br>
It essentially looks like this ...
```Swift
enum Optional<T> { // a generic type, like Array<Element> or MemoryGame<CardContent>
    case none
    case some(T) // the some case has associated value of type T
}
```
You can see that is can only have two values: is set (`some`) or not set (`none`).<br>
In the is set case, it can have some associated value tagging along (of "don't care type" T).

Where do we use Optionals?<br>
Any time we have a value that can sometimes be "not set" or "unspecified" or "undetermined".<br>
This happens quite often.<br>
That's why Swift introduces a lot of "syntactic sugar" to make it easy to use Optionals ...

Declaring something of type `Optional<T`> can be done with the syntax `T?`<br>
You can then assign it the value `nil` (`Optional.none`).<br>
Or you can assign it something of the type `T` (`Optional.some` with asociated vaue = that value).<br>
Note that Optionals always start out with an implicit `= nil`.

You can access the associated value either by force (with `!`) ...
```Swift
let hello: String? = ...
print(hello!) // force unwrapping
```
Or "safely" using `if let` and then using the safely-gotten associated value `{ }` (`else` allowed too).
```Swift
if let safehello = hello {
    print(safehello)
} else {
    // do something
}
```

There's also `??` which does "Optional defaulting", it's called the "nil-coalescing operator".
```Swift
let x: String? = ...
let y = x ?? "foo"
```