
.TL
.gcolor blue
Function templates

and

Function overloads
.gcolor
.LP
.ce 1
Week 3
.SS Overview
.IT You have \fBalready\fR read sections 19.3, 19.4, 19.5 and 5.6 of the text
.IT Generic programming
.IT Function overloads
.IT Function templates
.SS Generic programming
.IT C provides only 2 ways to write \fIpolymorphic\fR code
.i1 Pointers and macros
.IT C++ provides more tools for writing reusable, polymorphic code
.IT Today we look at two of them
.i1 Function overloading
.i1 Function templates
.IT These two language features form the basis for 
.I
generic
.br
programming
.R 
in C++
.i1 When we get into classes, we will cover some more
.SS Function overloads
.IT In C++, two different functions can have the same name 
.i1 If their parameters are different 
.i2 Either because they have a different number of parameters, 
.i2 Or their parameters are of a different type. 
.i1s
For example
.CW
  #include <iostream>
  int operate (int a, int b) {
    return (a*b);
  }
  double operate (double a, double b) {
    return (a/b);
  }

  int main () {
    int x=5,y=2;
    double n=5.0,m=2.0;
    std::cout << operate (x,y) << '\\n';
    std::cout << operate (n,m) << '\\n';
  }
.R
.i1e
.IT This is a huge advantage over C
.i1 Where (nearly) every function is global
.i1 And every function name must be unique
.IT For example
.i1 7 different functions just for absolute value 
.i2 abs, llabs, fabs, fabsf, etc.
.i1 13 different functions for different types of division operation

.IT \fBNOTE\fR 
.i1 The return type is \fBnot\fR part of the overload
.i1 Two functions in the same namespace that differ only in return type will not compile
.SS Overload anti-patterns
.IT How many parameters are too many?
.i1s
For example
.CW
  int operate (float a, int b, long c, double d) { ...
.R
.i1e
.i1 More parameters = more complexity
.i2 Limit the number of parameters you need in a given method, 
.i2 Or use a struct to combine parameters
.IT Be wary of overloads with the same number of parameters and different types
.i1s
For example
.CW
  int operate (double a, int b) { ...
  int operate (int a, double b) { ...
.R
.i1e
.i1 I \fIguarantee\fR you will invoke the wrong version on occasion

.SS Function templates
.IT Overloads help avoid writing many similar functions
.IT But there is still duplication to eliminate
.i1s
What if our functions do basically the same thing?
.CW
  #include <iostream>

  int sum (int a, int b) {
    return a+b;
  }

  double sum (double a, double b) {
    return a+b;
  }

  int main () {
    std::cout << sum (10,20) << '\\n';
    std::cout << sum (1.0,1.5) << '\\n';
  }
.R
.i1e
.bp
.IT In C++, we can define a \fItemplate\fR for a function
.i1 The template defines a function generating recipe 
.i1 Using a \fIgeneric type\fR as a placeholder
.IT New keyword: \*[c]template\*[r]
.i1 Followed by template parameters in angle brackets <>
.i1s
For example
.CW
  template <template-parameters> function-declaration 
.R
.i1e
.i1s
Then our previous sum functions collapse down to
.CW
  template <class T> T sum (T a, T b) {  
    return a+b;
  }
.R
.i1e
.IT The identifier 'T' is traditional
.i1 But any valid variable name could be used
.i2 In beginner tutorials \fCAnyType\fR is not uncommon
.IT Templates are completely specified in header files normally
.SS Using templated functions
.IT Not very different from a non-templated function
.i1s
You can explicitly provide the type
.CW
  int main () {
    std::cout << sum<int> (10,20) << '\\n';
    std::cout << sum<double> (1.0,1.5) << '\\n';

    \m[green]// or let the compiler deduce the type\m[]
    std::cout << sum (10,20) << '\\n';
    std::cout << sum (1.0,1.5) << '\\n';
  }
.R
.i1e
.SS Multiple template parameters
.IT More than just 'T' is possible, of course!
\s-4
.CW
  #include <iostream>

  template <class T, class U>
  bool are_equal (T a, U b) {
    return (a==b);
  }
  int main () {
    if (are_equal(10,10.0)) {
      std::cout << "x and y are equal\\n";
    } else {
      std::cout << "x and y are not equal\\n";
    }
  }
.R
\s+4
.SS Non-type template parameters
.IT Not every template parameter has to be a class or a typedef
\s-4
.CW
  #include <iostream>

  template <class T, int N> T multiply (T val);

  int main() {
    std::cout << multiply<int,2>(10) << '\\n';
    std::cout << multiply<int,3>(10) << '\\n';
  }

  \m[green]// note the definition includes ALL of the declaration
  // including the template information \m[]
  template <class T, int N> T multiply (T val) {
    return val * N;
  }
.R
\s-4

.SS Summary
.IT Templates and overloads are the basis for writing generic functions
.IT Valid overloads require different parameter lists
.IT New keyword: \*[c]template\*[r]
.IT Template type can be used like any other type
.i1 Return value
.i1 Type of local variable
.i1 Argument to another function
.IT Non-template arguments behave like function parameters
.IT Templates must be implemented in the include file

