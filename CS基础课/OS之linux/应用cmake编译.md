# 0\. linux用vscode编译调试C++ https://www.cnblogs.com/zhxilin/p/5881080.html

# 1\. makefiel&cmake

从事linux的开发工作，不可避免的需要进行编译构建的工作，直接编辑Makefile，不仅需要熟悉Makefile的语法，还需要知道依赖和推导规则，比较麻烦。
而c***make工具，只需要开发者提供头文件路径、库路径、编译参数等基本参数***，就能快速生成Makefile，语法简单，能够快速上手，另外cmake工具能够满足跨平台的要求，因此应用比较广泛。

# 2\. **编译的具体步骤**

### 使用gcc把C文件编译成可执行文件可分为四步：预编译、编译、汇编、连接。

1、预编译（生成.i文件）

预编译器cpp把源文件和相关的头文件（如实例代码中的头文件stdio.h）预编译成一个.i的文件。

执行的命令：gcc -E hello.c -o hello.i

预编译的作用：

a、处理所有的“#include”预编译指令

b、处理所有的"#define"指令，将代码中所有的"#define"删除，并展开所有的宏定义

c、处理所有的条件预编译指令，如#if #elif #else #ifdef #ifnodef #endif等

d、删除所有的注释

e、添加行号和文件名标识，以便产生错误时给出提示信息

2、编译（生成.s文件）

编译器gcc把预处理后的文件进行语法分析、语义分析以及优化后生成汇编代码文件。

执行的命令：gcc -S hello.i -o hello.s

3、汇编(生成.o文件)

汇编器把汇编代码文件转换成中间目标文件

执行的命令：gcc -c hello.s -o hello.o (注意：这里是小写的-c，而不是大写的-C，本人在此处踩坑，出现异常)

4、链接(生成可执行文件)

链接器ld把目标文件与所需要的所有的附加的目标文件(如静态链接库、动态链接库)链接起来成为可执行的文件

执行的命令：gcc hello.o -o hello

# 3\. 在linux平台下使用cmake生成Makefile并编译的通常流程有下面几步。

1、编写cmake配置文件CMakeLists.txt。
通常CMakeLists.txt放在项目顶层目录，根据需要也可在子目录放置。
2、在CMakeLists.txt文件所在目录创建一个build文件夹，然后进入目录。
不建目录理论上是可行的，但是生成的中间文件不易清理，另外build目录名词也是可以自定义的。
3、执行cmake …/ 生成makefile。
4、执行make和make install进行编译和安装。
3\. #指定使用该CMakeList.txt文件需要的cmake最低版本
cmake\_minimum\_required(VERSION 3.5)
#指定项目信息
project(calculator)

#设置安装目录
set(INSTALL\_DIR ${CMAKE\_SOURCE_DIR}/install)

#指定生成目标
add_executable(calculator main.cpp)

*if 安装目标太多，*

```
*aux_source_directory(.ALU_SRCS)*
//找到当前目录下所有变量，save names as ALU_SRCS

*add_executable(calculator ${ALU_SRCS})*
//将所有变量生成为其相应目标 
```

## *其他链接方式*

*add\_library(div STATIC ${MUL\_SRCS})*

*add\_library(div SHARED ${DIV\_SRCS})*

#安装到安装目录
INSTALL(TARGETS calculator DESTINATION ${INSTALL_DIR}/usr/bin)

mul目录下的CMakeLists.txt文件：

# mul

#查找当前目录下的所有源文件
#并将名称保存到MUL_SRCS变量
aux\_source\_directory(. MUL_SRCS)

#生成静态链接库
add\_library(mul STATIC ${MUL\_SRCS})

#安装到安装目录
INSTALL(TARGETS mul DESTINATION ${INSTALL_DIR}/usr/lib)

# 顶层目录下的CMakeLists.txt文件

#指定使用该CMakeList.txt文件需要的cmake最低版本
cmake\_minimum\_required(VERSION 3.5)
#指定项目信息
project(calculator)

#设置安装目录
set(INSTALL\_DIR ${CMAKE\_SOURCE_DIR}/install)

#添加子目录
add_subdirectory(mul)
add_subdirectory(div)

#包含头文件目录
include_directories(${CMAKE_SOURCE_DIR}/mul) include_directories(${CMAKE\_SOURCE\_DIR}/div)

#查找当前目录下的所有源文件(包括MUL\_SRCS,DIV\_SRCS)
#并将名称保存到ALL_SRCS变量
aux\_source\_directory(. ALL_SRCS)

#指定生成目标
add\_executable(calculator ${ALL\_SRCS})

#添加链接库
**target\_link\_libraries(calculator mul)
target\_link\_libraries(calculator div)**

#安装到安装目录
INSTALL(TARGETS calculator DESTINATION ${INSTALL_DIR}/usr/bin)

*其中，add\_subdirectory命令表示本项目包含一个子目录，include\_directories命令表示将指定目录添加到编译器的头文件搜索路径之下，target\_link\_libraries命令表示可执行文件calculator需要连接一个名为 mul/div的链接库。*
