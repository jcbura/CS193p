# Lecture 01 Video Notes

### Link to the [Video Lecture](https://www.youtube.com/watch?v=n1qabtjZ_jg).

___

We will not always `import SwiftUI`'.<br>
We're going to separate out the UI from the backend and the logic.

**struct** - `struct ContentView: View` means this is a structure.<br>
`struct`s can have variables and functions but it is NOT a class.

**ContentView** - `struct ContentView: View` is the name of the type.<br>
We'll rename it pretty soon to reflect what we're actually working on.

**View** - `struct ContentView: View` is probably them most important part of lecture 1.<br>
**"Behaves live a ..."**<br>
This struct called `ContentView` behaves like a `View`.

If you're going to behave like a `View`, you have to do the things a `View` does.<br>
For `View`, all you have to do is have `var body: some View` in your `struct`.<br>
If you satisfy this requirement, you get all the things a `View` knows how to do.

`View` is not a `struct`.<br>
`View` is a thing you can behave like called a `protocol`.

---

**Computed Protperty**<br>
There are properties within the struct.

**some** - `var body: some View`<br>
The type of this variable has to be any struct in the world as long as it behavies like a `View`.<br>
Which `View`?<br>
`some` tells Swift to execute the code, see what it returns, and use that.

---

**Creating Instances of structs**<br>
`Image(systemName: "globe").imageScale(.large).foregroundColor(.orange)`<br>
`Text("Hello CS193p!")`<br>
Are both examples of `struct`s that behave like a `View`.<br>

---

**Named Parameters**<br>
**systemName** - `Image(systemName: "globe").imgaeScale(.large).foregroundColor(.orage)`<br>
`systemName` is a named parameter.<br>
If it were `Image(named: "#")...` then it looks in the assets named the string you've provided.

---

**Parameter Defaults**<br>
There are other defaults you could specify here but you'll take the default.<br>
`VStack** {...}` is a `struct` that behaves like a `View` but it takes other "legos" and stacks them on top of eachother.<br>
It could have `VStack (alignment: leading, spacing: 20) {...}` but instead it uses the defaults.<br>
Generally, you have to have `VStack () {...}`.<br>
What's really happening is `VStack (content: { ... })` but it's not needed.

---

**ViewBuilder**<br>
The thing that turns the list into a tuple view is a ViewBuilder.

`Image(systemNme: "globe").imageScale(.large).foregroundColor(.orange)` are functions.<br>
These kinds of functions are called **View Modifiers**.<br>
View modifers scope matters.

`Rectangle()` behaves like a Shape.
