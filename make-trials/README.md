# README

Experiments for `make`

# Step By Step

[step1](./steps/step1) : 通过shell脚本, 按步骤编译项目

[step2](./steps/step2) : 通过shell脚本, 整体编译项目

[step3](./steps/step3) : make的简单规则

[step4](./steps/step4) : make的自定义变量 预定义变量 模式匹配

[step5](./steps/step5) : make的搜索路径

[step6](./steps/step6) : make的自动推导规则

[step7](./steps/step7) : make递归

# Features

[GNU make](https://www.gnu.org/software/make/manual/html_node/index.html#toc-An-Introduction-to-Makefiles)

[Unix Makefile Tutorial](https://www.tutorialspoint.com/makefile/)

[Make Tutorials](https://makefiletutorial.com/)

## 规则

```make
target [target...] : [dependent ....]
[ command ...]
```



| 规则中的元素 | 含义                           |
| ------------ | ------------------------------ |
| target       | 规则所定义的目标               |
| dependent    | 执行此规则所必须的依赖条件     |
| command      | 规则所执行的命令，即规则的动作 |



| 规则元素          | 含义                                                         |
| --------------- | ------------------------------------------------------------ |
| **目标**         | 目标可以是具体的文件，也可以是某个动作                       |
| **依赖项**       | 依赖项是目标生成所必须满足的条件，即依赖项的动作必须在TARGET的命令之前执行。<br/>依赖项之间的顺序按照自左向右的顺序检查或者执行 |
| **命令**         | 命令行必须以Tab键开始，make程序把出现在一条规则之后的所有连续的以Tab键开始的行都作为命令行处理 |
| **反斜杠(\\)**   | 用反斜杠(\\)将较长的行分解为多行。                           |
| **规则的嵌套**    | 规则之间是可以嵌套的，通常通过依赖项实现                     |
| **文件的时间戳**  | make命令执行的时候会根据文件的时间戳判定是否执行相关的命令，并且执行依赖于此项的规则。 |
| **模式匹配**     | %符号   *符号                                                |


## 预定义变量

| 变量     | 含义                        | 默认值   |
| -------- | --------------------------- | -------- |
| AR       | 生成静态库库文件的程序名称    | ar       |
| AS       | 汇编编译器的名称            | as       |
| CC       | C语言编译器名称             | cc       |
| CPP      | C语言预编译器的名称          | ${CC} -E |
| CXX      | C++语言编译器名称           | g++      |
| FC       | FORTRAN语言编译器的名称     | f77      |
| RM       | 删除程序文件的名称          | rm -f    |
| ARFLAGS  | 生成静态库库文件程序的选项   | 无默认值 |
| ASFLAGS  | 汇编语言编译器的编译选项     | 无默认值 |
| CFLAGS   | C语言编译器的编译选项       | 无默认值 |
| CPPFLAGS | C语言预编译的编译选项       | 无默认值 |
| CXXFLAGS | C++语言编译器的编译选项     | 无默认值 |
| FFLAGS   | FORTRAN语言编译器的编译选项 | 无默认值 |


## 自动变量


| 变量 | 含义                                                         |
| ---- | ------------------------------------------------------------ |
| $*   | 表示目标文件的名称，不包含目标文件的扩展名                   |
| $+   | 表示所有的依赖条件，这些依赖条件直接以**空格**分开，按照出现的先后为**顺序**,其中可能包含重复的依赖条件 |
| $<   | 表示依赖项中第一个依赖文件的名称                             |
| $?   | 依赖项中，所有目标文件时间戳晚的依赖文件，依赖文件之间以空格分开 |
| $@   | 目标项中目标文件的名称                                       |
| $^   | 依赖项中，所有不重复的依赖条件，这些文件之间以空格分开       |



## 模式匹配

```makefile
targets ...: target-pattern: prereq-patterns ...
   commands
```


The essence is that the given target is matched by the target-pattern (via a `%` wildcard). Whatever was matched is called the *stem*. The stem is then substituted into the prereq-pattern, to generate the target's prereqs.

演示:

```makefile
objects = foo.o bar.o all.o
all: $(objects)

# These files compile via implicit rules
# Syntax - targets ...: target-pattern: prereq-patterns ...
# In the case of the first target, foo.o, the target-pattern matches foo.o and sets the "stem" to be "foo".
# It then replaces the '%' in prereq-patterns with that stem
$(objects): %.o: %.c

all.c:
    echo "int main() { return 0; }" > all.c

%.c:
    touch $@

clean:
    rm -f *.c *.o all
```



## 搜索路径

```makefile
vpath <pattern> <directories, space/colon separated>
```

或者

```makefile
vpath = path1:path2:.
```


## 自动推导规则


Perhaps the most confusing part of make is the magic rules and variables that are made. Here's a list of implicit rules:

- Compiling a C program: `n.o` is made automatically from `n.c` with a command of the form `$(CC) -c $(CPPFLAGS) $(CFLAGS)`
- Compiling a C++ program: `n.o` is made automatically from `n.cc` or `n.cpp` with a command of the form `$(CXX) -c $(CPPFLAGS) $(CXXFLAGS)`
- Linking a single object file: `n` is made automatically from `n.o` by running the command `$(CC) $(LDFLAGS) n.o $(LOADLIBES) $(LDLIBS)`



the important variables used by implicit rules are:

- `CC`: Program for compiling C programs; default cc
- `CXX`: Program for compiling C++ programs; default G++
- `CFLAGS`: Extra flags to give to the C compiler
- `CXXFLAGS`: Extra flags to give to the C++ compiler
- `CPPFLAGS`: Extra flags to give to the C preprocessor
- `LDFLAGS`: Extra flags to give to compilers when they are supposed to invoke the linker



演示:

```makefile
CC = gcc # Flag for implicit rules
CFLAGS = -g # Flag for implicit rules. Turn on debug info

# Implicit rule #1: blah is built via the C linker implicit rule
# Implicit rule #2: blah.o is built via the C compilation implicit rule, because blah.c exists
blah: blah.o

blah.c:
    echo "int main() { return 0; }" > blah.c

clean:
    rm -f blah*
```




## 递归

To recursively call a makefile, use the special `$(MAKE)` instead of `make` because it will pass the make flags for you and won't itself be affected by them.

The export directive takes a variable and makes it accessible to sub-make commands.


## 函数

获取匹配模式的文件名
```makefile
$(wilcard PATTERN)
```

模式替换
```makefile
$(patsubst pattern,replacement,text)
```


循环函数
```makefile
$(foreach VAR,LIST,TEXT)
```

# Cases

[case1](./cases/case1) : test

case2 : beginner example

case3 : variables

case4 : variables

case5 : the all target

case6 : multiple targets

case7 : Wildcard *

case8 : Wildcard %

case9 : Automatic Variables

case10: Static Pattern Rules

case11: Static Pattern Rules and Filter

case12: Implicit Rules

case13: Pattern Rules

case14: Double-Colon Rules

case15: Command Echoing/Silencing

case16: Command Execution

case17: Default Shell

case18: Error handling with -k, -i, and -

case19: Interrupting or killing make

case20: Recursive use of make

case21: Use export for recursive make

case22: Use export for recursive make

case23: Use export for recursive make

case24: Arguments to make

case25:

case26:

case27:

case28:

case29:

# Practice

[redis makefile](https://github.com/redis/redis/blob/6.0/Makefile)







