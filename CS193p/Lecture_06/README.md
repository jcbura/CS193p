# Lecture 06 Video Notes

### Link to the [Video Lecture](https://www.youtube.com/watch?v=fYlMD9llu7w).

___

**Layout**

How is the space on-screen apportioned to the Views?<br>
1. Container Views "offer" some or all of the space offered to them to the Views inside them.
2. Views then choose what size they want to be (they are the only ones who can do so).
3. Container Views then position the Views inside of them.

**HStack and VStack**<br>
Stacks divide up the space that is offered to them and then offer that to the Views inside.<br>
IT offers space to its "least flexible" (with respect to sizing) subviews first ...<br>
Example of an "inflexible" View: Image (wants to be a fixed size)<br>
Example of a "slightly flexible" View: Text (always wants to size to exactly fit its text).<br>
Example of a "very flexible" View: RoundedRectangle (always uses any space offered).

After an offered View(s) takes what it wants, its size is removed the space availale.<br>
Then the stack moves onto the next "least flexible" Views.<br>
View flexible views will share evenly (mostly).<br>
Rinse and repeat.

After the Views inside the stack choose their own sizes, the stack sizes itself to fit them.<br>
If any of the Views in the stack are "very flexible", then the stack will also be "very flexible".

There are a couple of really valuable Views for layout that are commonly put in stacks ...

`Spacer(minLength: CGFloat)`<br>
Always takes all the space offered to it.<br>
Draws nothing.<br>
The `minLength` defaults to the most likely spacing you'd want on a given platform.

`Divider()`<br>
Draws a dividing line cross-wise to the way the stack is laying out.<br>
For example, in an HStack, Divider draws a vertical line.<br>
Takes the minimum space needed to fit the line in the direction the stack is going.<br>
Takes all the space offered to it in the other (cross-wise) direction.

Stack's choice of who to offer space to next can be overridden with `.layoutPriority(Double)`.<br>
In other words, layoutPriority trumps "least flexible".<br>
```Swift
HStack {
    Text("Important").layoutPriority(100) // any floating point number is okay
    Image(systemName: "arrow.up") // the default layout priority is 0
    Text("Unimportant")
}
```
The Important text above will get the space it wants first.<br>
Then the Image would get its space (since it's less flexible than the Unimportant Text).<br>
Finally, Unimportant would have to try to fit itself into any remaining space.

Another crucial aspect of the way stacks lay out the Views they contain is alignment.

When a VStack lays Views out in a column, what if the Views are not all the same width?<br>
Does it "left align" them? Or center them? Or what?

This is specified via an argument to the stack ...<br>
`VStack(alignment: .leading) { ... }`

Text baselines can also be used to align (e.g. `HStack(alignment: .firstBaseLine) { }`).

**LazyHStack and LazyVStack**<br>
These "lazy" versions of the stack don't build any of their Views that are not visible.<br>
They don't take up all the space offered to them even if they have flexible views inside.<br>
You'd use these when you have a stack that is in a ScrollView.

**LazyHGrid and LazyVGrid**<br>
Sizes its Views based on info given to the Lazy*Grid (e.g. the columns: argument).<br>
The other direction can grow and shrink as more Views are added.<br>
Also does not take all the space offered to it if it doesn't need it all.

**Grid**<br>
Allocates space to its Views both horizontally and veritcally.<br>
Lots of alignment options across colums and rows (e.g. .grid*() modifiers).<br>
Often used as sort of a "spreadsheet" View or "table of data" View.

**ScrollView**<br>
ScrollView takes all the space offered to it.<br>
The views inside it are sized to fit along the axis you're scorlling on.<br>

**ViewThatFits**<br>
Takes a list of container Views (e.g. an HStack and a VStack) and chooses the one that fits.<br>
This is great when laying out for landscape vs portrait.<br>
Or when laying out with dynamic type sizes (things with large fonts which might not fit horizontally).

**Form and List and OutlineGroup and DisclosureGroup**<br>
There are sort of "really smart VStacks" (scrolling, selection, hierarchy, etc.)

**Custom implementations of the Layout protocol**<br>
You can do a customer "offer sapce, let Views choose their size, then position them" process.<br>
Implement a View that implements the Layout protocol (sizeThatFits, placeSubviews).

**ZStack**<br>
ZStack sizes itself to fit its children.<br>
If even one of its children is fully flexible, then the ZStack will be too.

**.background modifier**<br>
`Text("hello").background(Rectangle().foregroundColor(.red))`<br>
This is similar to making a ZStack of this Text and Rectangle (with the Text in front).<br>
However, there's a big difference in layout between this and using a ZStack to stack them.<br>
In this case, the resultant View will be sized to the Text (the Rectangle is not involved).<br>
In other words, the Text solely determines the layout of this "mini-ZStack of two things".

**.overlay modifer**<br>
Same layout rules as .background, but stacked the other way around.<br>
`Circle().overlay(Text("hello"), alignment: .center)`<br>
This will be sized to the Circle (i.e. it will be fully-flexible sized).<br>
The Text will be stacked on top of the Circle (with the specified alignment inside the Circle).

**Modifiers**<br>
Remember that View modifier functions (like .padding) themselves return a View.<br>
That View, conceptually anyway, "contains" the View it's modifying.<br>
Many of them just pass the size offered to them along (like .font or .foregroundColor).<br>
But it is possible for a modifier to be involved in the layout process itself.

**Views that take all the sapce offered to them**<br>
Most Views simply size themselves to take up all the sapce offered to them.<br>
For example, Shapes usually draw themselves to fir (like RoundedRectangle).<br>
Custom Views (like CardView) do this too whenever sensible.<br>
But they really should adapt themselves to any space offered to look as good as possible.<br>
For example, we made CardView scale its font size to one that make its emoji fill the space.

But what if a View needs to known how much space it was offered in order to adapt?<br>
e.g., what if we wanted to pick a card size so that our LazyVGrid would not need to scroll?<br>
Put the View inside a containter View called a GemoetryReader ...

**GeometryReader**<br>
You wrap this `GeometryReader` View around what would normally appear in your View's body ...
```Swift
var body: View {
    GeometryReader { geometry in // using a trailing closure syntax for content: parameter
        ...
    }
}
```
The `geometry` parameter is a `GeometryProxy`.
```Swift
struct GeometryProxy {
    var size: CGSize
    func frame(in: CoordinateSpace) -> CGRect
    var safeAreaInsets: EdgeInsets
}
```
The `size` var is the amount of space that is being "offered" to us by our container.<br>
Now we can, for example, pick a card size appropriate to that sized space.<br>
`GeometryReader` itself (it's just a View) always accepts all the space offered to it.

**SafeArea**<br>
Generally, when a View is offered space, that space does not include "safe areas".<br>
The most obvious "safe area" is the notch on an iPhone X and later.<br>
Surrounding Views might also introduce "safe areas" that Views inside shouldn't draw in.<br>
But it is posible to ignore this and draw in thos areas anyway on specified edges ...
`ZStack { ... }.edgesIgnoreSafeArea([.top]) // draw in "safe area" on top edge`

---

**`@ViewBuilder`**

Based on a mechanism in Swift to enhance a var to hae special functionality.<br>
It's a simple mechanism for supporting a more convenient syntax for lists of Views.

Developers can apply it to any of their functions that return something that conforms to View.<br>
If applied, the function still returns something that conforms to View.<br>
But it will do so by interpreting the contents as a list of Views and combines them into one.

That one View that it combines it into might be a TupleView (for two or more Views).<br>
Or it could be a _ConditionalContent View (when there's an if-else in there).<br>
Or it could even be an EmptyView (if there's nothign at all in there; weird, but allowed).<br>
And it could be any combination of the above (if's inside other if's, etc).

Note that some of this is not yet fully public API (like _ConditionalContent).<br>
But we don't actually care what View it creates for us when it combines the Views in the list.<br>
It's always just some View as far as we're concerned.

Any func or read-only computer var can be marked with `@ViewBuilder`.<br>
If so marked, the contents of that func or var will be interpreted as a list of Views.<br>

You can also use `@ViewBuilder` to mark a paramter of a function or an init.<br>
That argument's type must be a "function that returns a View".<br>
ZStack, HStack, VStack, ForEach, LazyVGrid, etc. all do this (their content: parameter).

Just to reiterate ...<br>
The contents of `@ViewBuilder` is just a list of Views.<br>
It's not arbitrary code.

`if-else` (or `switch` or `if let`) statements can be used to choose Views to include in the list.<br>
You can also have local lets.<br>
No other kinds of code is allowed (at least as of the time of this lecture).