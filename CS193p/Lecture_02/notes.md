# Lecture 02 Video Notes

### Link to the [Video Lecture](https://www.youtube.com/watch?v=sXiD-2XrkKQ).

---

**`let` vs `var`**<br>
`let` is a constant and `var` varies.<br>
Inside a ViewBuilder you would always be using `let` because nothing can change, it's read only.

---

**Type Inference**<br>
Swift knows `let base = RoundedRectangle(cornerRadius: 12)` has been set to a `RoundedRectangle`, so it will infer that the type must be a `RoundedRectangle`.<br>

---

**Views are immutable**<br>

---

**`@State`**<br>
Creates a pointer to `isFaceUp`.<br>
The pointer never changes but the thing it points to does.

---

**Alternate Array Notation**<br>
`Array<String>` vs `[String]` are indetical.

---

'**ForEach**'<br>
Essentially how to use a `for` loop within a `View`.

---

**Implicit Return**<br>
If there is only one line of code, their is an implicit return.

---

**Internal vs External Parameter Names**<br>
The first label is the one callers use.<br>
The second label is the one we use in our function.

---

**Opacity vs if-else in @ViewBuilder**<br>
Good way to switch between two states when you need sizing for all of them.
