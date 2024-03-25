# Lecture 04 Video Notes

### Link to the [Video Lecture](https://www.youtube.com/watch?v=4CkEVfdqjLw).

___

**Access Control** 

`private var model: MemoryGame<String>` makes it so that 'model' is only accessible within the 'EmojiMemoryGame' class.<br>
`private(set) ...` setting the variable is private but looking is allowed.<br>
Usually lean on the side of private unless you decide you need otherwise.

--- 

**static vars and funcs**

`static` makes something global but namespaces it inside of the class.<br>
Tend to put 'statics' together at the top or bottom of the class.<br>

---

**mutating**

Swift won't let you mutate your own `struct` without putting `mutating` there.