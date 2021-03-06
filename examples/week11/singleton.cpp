#include <iostream>

// Declaration
class Singleton {
  public: 
    int value() {return value_;}
    void value(int value) { value_ = value;}

    static Singleton* instance();
  private:
    int value_;
    Singleton() : value_{0} {}
    static Singleton* _instance;
};

// Implementation 
Singleton* Singleton::_instance = nullptr;

Singleton* Singleton::instance() {
  if (_instance == nullptr) {
    _instance = new Singleton;
  }
  return _instance;
}

int main() {
  Singleton* s = Singleton::instance();
  std::cout << "s: " << s->value() << '\n';

  Singleton* x = Singleton::instance();
  x->value(3);
  std::cout << "s: " << s->value() << '\n';
  std::cout << "x: " << x->value() << '\n';
  Singleton* y = Singleton::instance();
  y->value(5);
  std::cout << "s: " << s->value() << '\n';
  std::cout << "x: " << x->value() << '\n';
  std::cout << "y: " << y->value() << '\n';

  std::cout << "addresses: " << '\n';
  std::cout << "s: " << &s << '\t';
  std::cout << "x: " << &x << '\t';
  std::cout << "y: " << &y << '\n';
  std::cout << "instances: " << '\n';
  std::cout << "s: " << &(*s) << '\t';
  std::cout << "x: " << &(*x) << '\t';
  std::cout << "y: " << &(*y) << '\n';
}

