SRCS= Book.cpp Date.cpp

OBJS=$(SRCS:%.cpp=%.o)
CXXFLAGS+= -I/opt/local/include
LDLIBS+= -lboost_unit_test_framework-mt
LDFLAGS+= -L/opt/local/lib

PROGS= hello date book

all: ${PROGS}

hello : test_hello.o
	c++ ${CXXFLAGS} -c test_hello.cpp
	c++ ${CXXFLAGS} $(LDFLAGS) -o hello $< $(LDLIBS)
	./$@

date : test_date.o Date.o
	c++ ${CXXFLAGS} $(LDFLAGS) -o $@ $^ $(LDLIBS)
	./$@

book : test_book.o $(OBJS)
	c++ ${CXXFLAGS} $(LDFLAGS) -o $@ $^ $(LDLIBS)
	./$@

%.o: %.cpp %.h
	c++ ${CXXFLAGS} -c $<

clean : 
	rm -f ${PROGS} *.o
