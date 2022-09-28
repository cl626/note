```
0. 编译基槽
1. g++与launch&tasks.json
2. cmake applied in makefile
```

### mingw64/bin

1.  gcc/g++预处理(.i)-编译为x64(.s)-编译为二进制(.o)-链接为可执行(.exe)
2.  gdb for debug
3.  **.\\filename.exe** 来command execute;

* * *

## g++编译

```
g++ -E hello.c -o hello.i
g++ -S helllo.i -o hello.s
g++ -S hello.s -o hello.o
g++ hello.o hellp.o -o target
g++ -g hello.c hello.c -o target
g++ -g hello.c hello.o -o suprise

```

![](C:\Users\c1826\Pictures\Camera Roll\suprise_g++_g.png)

* * *

## launch&task.json的填写(vscode下用g++)

[关键字说明](https://code.visualstudio.com/docs/editor/variables-reference)
[总结](https://blog.csdn.net/qq_43964318/article/details/124612782?ops_request_misc=%257B%2522request%255Fid%2522%253A%2522165925627016780366520065%2522%252C%2522scm%2522%253A%252220140713.130102334.pc%255Fall.%2522%257D&request_id=165925627016780366520065&biz_id=0&utm_medium=distribute.pc_search_result.none-task-blog-2~all~first_rank_ecpm_v1~pc_rank_34-3-124612782-null-null.142%5Ev35%5Epc_rank_34&utm_term=launch.json%20program&spm=1018.2226.3001.4187)

fileDirname=.vscode路径
workspaceFolder=compile路径
**这个也相当于是手动g++,提高效率还是看cmake**

## 用tasks.json编译多层目录

![img](https://img-blog.csdnimg.cn/20200531225730449.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L0JhaVJ1aWNoYW5n,size_16,color_FFFFFF,t_70)

对于这样的多单层，可以使用将g++的源文件参数

```json
"tasks": [
    {
        "type": "shell",                       //任务执行的是shell命令
        "label": "g++.exe build active file", //和launch.josn 中的 preLaunchTask 必须一样
        "command": "C:\\Program Files\\mingw64\\bin\\g++.exe", //命令是g++，也可以直接写g++
        "args": [
            "-g",    //生成和调试有关的信息
            "-Wall", // 开启额外警告 
            "${workspaceFolder}\\source\\*.cpp",  //当前工作空间下文件夹source目录名下的所有cpp文件。 source对应工程目录下的source文件夹名字，可自行修改   
            "-I","${workspaceFolder}\\include",      // 参数-I 和工程路径 指明了项目中要引用的非标准头文件的位置。 include对应工程目录下的include文件夹名字，可自行修改                   
            "-o",                      
            "${workspaceFolder}\\out\\${fileBasenameNoExtension}.exe", //指定输出的文件名为out，默认a.exe。out对应工程目录下的out文件夹名字，可自行修改 
            "-std=c++17",                                      //使用c++17标准编译
            "-finput-charset=UTF-8",                           //输入编译器默认文本编码 默认为utf-8
            "-fexec-charset=GB18030",                          //输出exe文件编码 
        ],
        // 所以以上部分，就是在shell中执行（假设文件名为main.cpp）  等同在shell中执行  g++ main.cpp -o filename.exe 等命令
        "options": {
            "cwd": "C:\\Program Files\\mingw64\\bin"
        }
    }
],
"version": "2.0.0"
```
进一步，对于如下目录：



![](C:\Users\c1826\Pictures\Camera Roll\multi_content_tasks.json.png)

试填写tasks.json:

```json
{
    "tasks": [
        {
            "type": "shell",                       //任务执行的是shell命令
            "label": "g++.exe build active file", //和launch.josn 中的 preLaunchTask 必须一样
            "command": "C:\\Program Files\\mingw64\\bin\\g++.exe", //命令是g++，也可以直接写g++
            "args": [
                "-g",    //生成和调试有关的信息
                "-Wall", // 开启额外警告 
                "${workspaceFolder}\\source\\*.cpp",  //当前工作空间下文件夹source目录名下的所有cpp文件。 source对应工程目录下的source文件夹名字，可自行修改   
                "-I","${workspaceFolder}\\include",      // 参数-I 和工程路径 指明了项目中要引用的非标准头文件的位置。 include对应工程目录下的include文件夹名字，可自行修改                   
                "-o",                      
                "${workspaceFolder}\\out\\${fileBasenameNoExtension}.exe", //指定输出的文件名为out，默认a.exe。out对应工程目录下的out文件夹名字，可自行修改 
                "-std=c++17",                                      //使用c++17标准编译
                "-finput-charset=UTF-8",                           //输入编译器默认文本编码 默认为utf-8
                "-fexec-charset=GB18030",                          //输出exe文件编码 
            ],
            // 所以以上部分，就是在shell中执行（假设文件名为main.cpp）  等同在shell中执行  g++ main.cpp -o filename.exe 等命令
            "options": {
                "cwd": "C:\\Program Files\\mingw64\\bin"
            }
        }
    ],
    "version": "2.0.0"
}
```

## cmake编译——generate executive file,可launch(效率稻草）

根据CMakeLists.txt生成执行所需文件，

1. cmake ..\src
2. cmake -G "MinGW Makefiles" ..\src

据此生成可执行文件

1. cmake --build .
2. make(.../mingw64/bin/make.exe(original name=mingw32-make.exe))
   **编译时路径名需要为英文**

CMakeLists.txt书写

1. Project()执行项目名称与语言
2. Set(Var file,file,...)
3. add_executable(target_name ${Var})
4. message(PROJECT/Var_SOURCE/BINARY_DIR)
5. add_subdirectory(source_dir ???)

launch.json是为了调试