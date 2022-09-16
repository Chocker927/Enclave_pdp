# 简介

[toc]

## 参考

该实验代码参考了[Ahmad1234567/provable-data-possession](https://github.com/Ahmad1234567/provable-data-possession.git)的方案,简单的将其代码进行了更改.

## 说明

这是一个PDP方案的测试.如果想要使用,你需要先修改makefile文件,设置sdk和ssl的相关位置,之后运行source命令和make命令,最后会产生一个TestApp文件,即为最终pdp程序.

## 参数更改

使用测试代码进行测试速度时，需要将`app/pdp/pdp.h`中的`#define DEBUG_MODE`取消注释,这样就不需要每次输入密码,可以更加精确的计算时间.
