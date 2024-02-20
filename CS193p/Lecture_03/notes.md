# Lecture 03 Video Notes

### Link to the [Video Lecture](https://www.youtube.com/watch?v=W1ymVx6dmvc).

---

**Separating "Logic and Data" from "UI"**<br>
We call this logic and data our "Model"<br>
It could be a struct or an SQL database or any combination of such things.<br>
The UI is basically a "parameterizable" shell that the Model feeds and brings to life.<br>
Think of the UI as a visual manifestation of the Model.<br>
The Model is where things like isFaceUp and cardCount would live (not in '@State' in the UI).<br>

---

**Model and UI**<br>
Connecting the Model to the UI<br>
1. The Model could just be an @State in a View (minimal to no separation).
2. The Model might only be accessible via a gatekeeper "View Model" class (full separation).
3. There is a View Model class, but the Model is still directly accessible (partial separatio).

How do we know which of these to do?<br>
A Model that is made up of SQL + struct(s) + something else will almost always be number 2.<br>
A Model that is a simple piece of data and little to no logic would likely opt for number 1.<br>
Something in-between might be interested in option number 3.<br>
Option 3 does not have a flexible growth system.

We're going to talk about number 2 (full separation).
We call the architecture that connects the Model to the UI in this way **MVVM**<br>
**Model-View-ViewModel**<br>
This is the primary architecture for any reasonably complex SwiftUI application.

The Model is UI independent, we won't even 'import SwiftUI'.<br>
The Model includes Data and Logic.<br>
The Model is "The Truth".

The View reflects the Model.<br>
The View is stateless.<br>
The View is declared.<br>
The View is reactive.

The ViewModel binds the View to the Model.<br>
The ViewModel is the interpreter.<br>
The ViewModel is a gatekeeper.<br>
It controls the flow between the Model and the View.<br>

Notices changes -> publishes "something changed" -> automatically observes publications, pulls data and rebuilds.

What about the other direction (View -> Model)?<br>
The ViewModel processes Intent.<br>
Calls Intent function -> modifies the Model.

---

**Architecture**<br>
Varieties of Types<br>
* `struct`
* `class`
* "don't care" type (`generics`)
* `protocol` (part one)
* `func`tions

---

**struct and class**

Both `struct` and `class` have ...
* pretty much the same syntax
* store `var`s (the kind you're used to, i.e., stored in memory)
* computed `var`s (i.e. those whose values are the result of evaluating some code)
* constant `let`s (i.e. `var`s whose values never change)
* `func`tions
* `init`ializers (i.e. special functions that are called when creating a `struct` or `class`)

So what's the difference between `struct` and `class`?

`struct`
* Value type
* Copied when passed or assigned
* Copy on write
* Functional programming
* No inheritance
* "Free" `init` initializes ALL `var`s
* Mutabilitiy is explicit (`var` vs `let`)
* Your "go to" data structure

`class`
* Reference type
* Passed around via pointers
* Automatically reference counted
* Object-oriented programming
* Inheritance (single)
* "Free" `init` initializes NO `var`s
* Always mutable
* Used in specific circumstances

---

**Generics**<br>
Sometimes we just don't care.<br>
We don't know what type something is and we don't care.<br>
But Swift is a strongly-typed language, so we don't use variables and such that are "untyped".<br>
So how do we specifcy the type of something when we don't care what type it is?<br>
We use a "don't care" type (we call this feature "generics").

Example of a user of a "don't care" type: `Array`<br>
An `Array` contains a bunch of things and it doesn't care at all what type they are!<br>
But inside `Array`'s code, it has to have variables for the things it contains and they need types.<br>
And it needs types for the arguments to `Array` functions that do things like adding items to it.<br>

How `Array` uses a "don't care" type...
```Swift
struct Array<Element> {
    ...
    func append(_ element: Element) { ... }
}
```
The type of the argument to `append` is `Element`, a "don't care" type.<br>
`Array`'s implementation of `append` knows nothing about the argument and it does not care.<br>
`Element` is not any known `struct` or `class` or `protocol`, it's just a placeholder for a type.<br>
The code for using an `Array` looks something like this...
```Swift
var a = Array<Int>()
a.append(5)
a.append(22)
```
When someone uses `Array`, that's when `Element` gets determined (by `Array<Int>`).

**Type Parameter**<br>
It is illustrative to refer to these types like `Element` in `Array` as a "don't care" type (since if you ask `Array` what type its elements are, it will say "I don't care").<br>
But its actual name is **Type Parameter**.<br>

---

**protocol**<br>
A `protocol` is sort of a "stripped-down" `struct`/`class`.<br>
It has `func`tions and `var`s, but no implementation (or storage)!<br>
Declaring a `protocol` looks very similar to `struct` or `class` (just w/o implementation)...
```Swift
protocol Moveable {
    func move(by: Int)
    var hasMoved: Bool { get }
    var distanceFromStart: Int { get set }
}
```
See? No implementation.<br>
The `{ }` on the `var`s just say whether it's read only or a `var` whose value can also be set.<br>
Any type can now claim to implement `Moveable`...
```Swift
struct PortableThing: Moveable {
    // must implement move(by:), hasMoved, and distanceFromStart here
}
```
`PortableThing` now **conforms to** (aka "behaves like a") `Moveable`.<br>
... and this is also legal (this is called "protocol inheritance")...
```Swift
protocol Vehicle: Moveable {
    var passengerCount: Int { get set }
}
class Car: Vehicle {
    // must implement move(by:), hasMoved, distanceFromStart, and passengerCount here
}
```
... and you can claim to implement multiple protocols...
```Swift
class Car: Vehicle, Impoundable, Leasable {
    // must implement move(by:), hasMoved, distanceFromStart, and passengerCount here
    // and must implement any funcs/vars in Impoundable and Leasable too
}
```

What is a `protocol` used for?<br>
A `protocol` is a type.<br>
So (with certain restrictions), it can be used in the normal places you might see a type (especially with the addition of the keywords `some` and `any`).<br>
For example, it can be the type of a `var` or a return type (like `var` body's return type).

What is a `protocol` used for?<br>
Specifying the behavior of a `struct`, `class`, or `enum`.<br>
`struct ContentView: View`<br>
Just by doing this, `ContentView` became a very powerful `struct`!

We call this process "constrains and gains".<br>
A `protocol` can **constrain** another type (for example, a View has to implement var body).<br>
But a protocol can also supply huge gains (e.g. the 100's of functions a View gets for free).<br>
Examples: `Identifiable`, `Hashable`, `Equatable`, `CustomStringConvertible`.<br>
And more specialized ones like `Animatable`.

What is a `protocol` used for?<br>
Another use we'll see is turning "don't cares" into "somewhat cares".<br>
`struct Array<Element> where Element: Equatable`<br>
If `Array` were declared this way, the only things that are "equatable" could be put in arrays.<br>
This is at the heart of "protocol-oriented programming".<br>

Why `protocol`s?<br>
It is a way for types (`struct`s/`class`es/other `protocol`s) to say what they are capable of.<br>
And also for other code to demand certian behavior out of another type.<br>
But neither side has to reveal what sort of `struct` or `class` they are.<br>
It's also another way to add a lot of functionality (via **extension**) based on a `protocol`'s primitives.

---

**Functions as Types**<br>
Functions are types.<br>
You can declare a variable (or parameter to a `func` or whatever) to be of type "function".<br>
The syntax for this includes the types of the arguments and return value.<br>
You can do this anywhere any other type is allowed.<br>

Examples...
```Swift
(Int, Int) -> Bool  // takes two Ints and returns a Bool
(Double) -> Void    // takes a Double and returns nothing
() -> Array<String> // takes no arguments are returns an Array of Strings
() -> Void          // takes no arguments and returns nothing
```

Functions are types.<br>
`var operation: (Double) -> Double`<br>
This is a `var` called `operation`.<br>
It's type is "function that takes a Double and returns a Double".<br>

Here is a simple function that takes a Double and returns a Double...
```Swift
func square(operand: Double) -> Double {
    return operand * operand
}
operation = square // just assigning a value to the operation var, nothing more
let result1 = operation(4) // result1 would equal 16
```
Note that we do't use argument labels (e.g. `operand:`) when executing function types.
```Swift
operation = sqrt // sqrt is a built-in function which happens to take and return a Double
let result2 = operation(4) // result would be 2
```

**Closures**<br>
It's so common to pass functions around that are very often "inlining" them.<br>
We call such an inlined function a "closure" and there's special language support for it.

