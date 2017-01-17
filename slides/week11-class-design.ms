
.TL
.gcolor blue
Class Design
.gcolor
.LP
.ce 1
Week 11
.SS Overview
.IT The \fIIS-A\fR relationship
.IT Object composition
.i1 The \fIHAS-A\fR relationship
.IT Multiple Inheritance
.IT Design Considerations
.SS Ensure inheritance models \fIIS-A\fP
.IT Effective C++ #35: Make sure public inheritance models "IS-A"
.IT If you only get one thing out of this week, let it be this
.i1s 
Consider the following
\s-4
.CW
  class Bird {
    public:
      virtual void fly();
  };
  class Penguin: public Bird {
      ...
  };
.R
\s+4
.br
We have a problem
.i1e
.i2 Because we have asserted that penguins can fly
.IT Consider the \fCShape\fR inheritance tree from the text
.i1 Also consider the Rectangle / Square inheritance example
.i1 Public inheritance asserts that \fIeverything\fR applicable to base a class is also applicable to derived classes
.IT It turns out this is a fairly restrictive assertion
.PS
boxht = .5
boxwid = 1.5
arrowhead = 7

S: box "Shape"
I: box "Image" with .e at S.w + (-2,-.5)
L: box "Line" with .w at S.e + (1,-.5)
R: box "Rectangle" wid 1.75 with .n at S.s + (2,-1)

OP: box "Open_polyline" wid 2.5 with .n at S.s+ (-1,-1)
MP: box "Marked_polyline" wid 2.5 with .n at OP.s+ (-2,-.5)
CP: box "Closed_polyline" wid 2.5 with .n at OP.s+ (2,-.5)
P:  box "Polygon" with .n at CP.s + (0.75,-.5)
Ms:  box "Marks" with .n at MP.s + (-0.75,-.5)
M:  box "Mark" with .n at Ms.s + (-0.75,-.5)



arrow to S.w from I.e
arrow to S.e from L.w
arrow to S.s from R.n
arrow to S.s from OP.n
arrow to OP.s from MP.n
arrow to OP.s from CP.n
arrow to CP.s from P.n
arrow to MP.s from Ms.n
arrow to Ms.s from M.n
.PE
.IT What is wrong with this hierarchy?
.i1 From the book, page 505
.SS \s-8Never redefine inherited non-virtual functions\s+8
.IT Effective C++ #37
.IT One of my very few 'never's
.i1s 
Given:
.CW
  class B {
    public:
    void foo();
  };
  class D: public B { ... };
.R
.i1e
.IT If \fCclass D\fR implements it's own version of \fCfoo()\fR
.IT This is \fInot\fR an override
.i1 This is called \fIshadowing\fR a function and is a common source of error.
.i1 Most good compilers will warn you...

.SS Model \fIHAS-A\fP using Composition
.IT Effective C++ #40: 
.i1 Scott Meyers uses the term \fIlayering\fR as a synonymn for composition
.IT Composition
.i1 A class \fIhas an\fR instance of another class
.i2 The child object life cycle depends on the parent instance life cycle. 
.i2 In other words, when the parent dies, the child dies.
.IT Consider \fCclass Car\fR and \fCclass Engine\fR. 
.i1 When a Car is created, it comes with an Engine. 
.i1 The Engine can exist only as long as the Car exists. 
.i1 The Engine exists solely for the benefit of the Car that contains the Engine
.i2 No other car can use this engine. 
.i1 When the Car is destroyed, the Engine is destroyed. 
.SS Use multiple inheritance judiciously
.IT C++ allows for a single class to inherit capabilities from more than 1 class
.i1 \fIMultiple inheritance\fR
.IT It's easy to go from here:
.PS
boxht = .5
boxwid = .5
arrowhead = 7

X: box invis ""

B: box "B" with .e at X.w+ (-1,0)
A: box "A" with .e at B.w + (-1,0)
C: box "C" with .n at A.s + (0.75,-.5)

arrow to A.s from C.n
arrow to B.s from C.n

A1: box invis "" with .n at X.n + (2,0)
B1: box invis "" with .n at A1.s + (-0.75,-.5)
C1: box invis "" with .n at A1.s+ (0.75,-.5)
D1: box invis "" with .n at B1.s + (0.75,-.5)
.PE

.SS Use multiple inheritance judiciously
.IT C++ allows for a single class to inherit capabilities from more than 1 class
.i1 \fIMultiple inheritance\fR
.IT It's easy to go from here:
.PS
boxht = .5
boxwid = .5
arrowhead = 7

X: box invis "to here:"

B: box "B" with .e at X.w+ (-1,0)
A: box "A" with .e at B.w + (-1,0)
C: box "C" with .n at A.s + (0.75,-.5)

arrow to A.s from C.n
arrow to B.s from C.n

A1: box "A" with .n at X.n + (2,0)
B1: box "B" with .n at A1.s + (-0.75,-.5)
C1: box "C" with .n at A1.s+ (0.75,-.5)
D1: box "D" with .n at B1.s + (0.75,-.5)

arrow to A1.s from B1.n
arrow to A1.s from  C1.n
arrow to B1.s from D1.n
arrow to C1.s from D1.n
.PE
.IT aka, the \fIDiamond of Death\fR
.SS The \fIDiamond of Death\fR
.IT Given
.PS
boxht = .5
boxwd = .5
arrowhead = 7

A: box "A"
B: box "B" with .n at A.s + (-0.75,-.5)
C: box "C" with .n at A.s+ (0.75,-.5)
D: box "D" with .n at B.s + (0.75,-.5)

arrow to A.s from B.n
arrow to A.s from  C.n
arrow to B.s from D.n
arrow to C.s from D.n
.PE
.IT If abstract \fCclass A\fR defines an interface implemented by \fIboth\fR \fCclass B\fR and \fCclass C\fR
.IT And \fCclass D\fR inherits from \fIboth\fR \fCclass B\fR and \fCclass C\fR 
.IT When \fCclass D\fR calls one of the interface functions from \fCclass A\fR
.i1 Which one is invoked??
.SS The \fIDiamond of Death\fR
.IT Who knows?
.i1 Technically, any version could be called
.i1 The standard doesn't specify anything in this situation
.i1 Most compilers will essentially bail and not call \fBany\fR of the functions

.IT Key Point:

.IT There is \fBno way\fR for the compiler to automatically know which overridden method to call
.IT It's not as bad as it sounds
.i1 But you have to explicitly specify which super class method to call
.i1 Which defeats the entire purpose of having runtime polymorphism
.SS Design Considerations
.IT Good class design is hard
.i1 Because designing good data types is hard.
.IT Good data types have a natural syntax and intuitve semantics
.IT C++ classes \fIare\fR data types
.IT Nearly every new class requires thinking about the following
.i1 Creation / Destruction 
.i2 How should objects be created and destroyed? 
.i2 How does object initialization differ from object assignment?
.i2 What are the constraints on legal values for the new type?
.i1 Functions
.i2 What kind of type conversions are allowed?
.i2 What operators and functions make sense for the new type?
.i2 What standard operators and functions should be explicitly disallowed?
.i2 Who should have access to the members of the new type?
.i1 Design
.i2 How general is the new type?
.i2 Does the new type fit into an inheritance graph?
.SS Summary
.IT Common base class means common traits. 
.i1 If \fCclass C\fR and \fCclass D\fR both declare \fCclass B\fR as a base 
.i1 Then \fCclass C\fR and \fCclass D\fR inherit common data members and/or common member functions from \fCclass B\fR
.IT Public inheritance means \fIIS-A\fR
.IT Composition means means \fIHAS-A\fR
.IT Use pure virtual functions to define \fIinterfaces\fR
.IT Use simple virtual functions to define \fIinterfaces\fR \fBand\fR a \fIdefault implementation\fR
.IT Bases classes with non-virtual functions are \fIdefining a mandatory implementation\fR