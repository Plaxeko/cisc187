.ds CH Lab #11b: Class inheritance II
.so headings.ms
.TL
\*[CH]

.bp
.NH
Boats: 100 points, 60 minutes \fImaximum\fR
.time_box
.QP
Use the following code snippets and place them in the provided classes where there are underscores in the code.

You may use a snippet more than once.

You may not need all the snippets.

The goal is to make a working program that generates the following output:
.RS
.CW
   drift  drift  hoist sail
.R
.RE

Choose from the following code snippets:
.CW

  RowBoat            SailBoat           Boat
  subclasses         extends            return
  const              continue           break
  int                static             private
  private:           public             public:
  string             void               virtual
  override           b1                 b2
  b3                 len                len{0}
  length             int b1             int b2
  int b3             int len            int length
  drift              row row            hoist sail
  move               rowTheBoat         std::cout
.R

Prefer keeping interfaces and implementations separate.

Hand in only the final source code, not this lab sheet, 
if you choose to fill in the blanks before typing it out.

.bp
.CW
  #include <iostream>

  class ________ { 
    ________
      Boat() : ________
      {}
      ________ ~________(){}

      void ________(int length) {
        ________ = ________;
      }

      int ________() { 
        return len;
      }

      virtual void move () const {
        std::cout << " drift ";
      }
      ________
      int len;

  };

  class SailBoat : ________ Boat {
    public:
      virtual ~________(){}
        ________ move() ________ ________ {
        ________ << " ________ ";
      }
  };

  class RowBoat : ________ ________ {
    public:
      virtual ~________(){}
      void row() ________ {
        std::cout << " row row ";
      }
  };

  int main() {
      Boat b1;
      ________ b2;
      RowBoat ________;

      b2.length(32);
      b1.________();
      b3.________();
      ________.move();
      std::cout << std::endl;
  }
.R

