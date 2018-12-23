
# CPU_experiments
这是武汉大学计算机弘毅班开设的“计算机组成与设计”专业课对应的实验部分。此仓库保存了本人独立完成的实验源码。
计组实验跨越了两个学期。大二上完成了的在Modelsim上编写、仿真、测试的任务有：
> - [x]  单周期CPU（文件夹为./Single Cycle Processor)
> - [x]  多周期CPU（文件夹为./Multicycle Processor)
> - [x]  流水线CPU [五级流水线，支持Forwarding，Hazard detection]
（文件夹为./Pipeline Processor)

（注：每个文件夹下均有一个work文件夹，创建项目时由Modelsim自动生成。为了使仓库轻量，work文件夹均未跟踪。读者需自己创建项目，把源码复制到项目中即可）

大二下完成了“下板子”工作，将代码下载到FPGA板子中（SOC：system on chip)。为了能在板子上运转，在上学期的项目的基础上进行了删改：更改了端口的名称（为了与板子现有模块匹配）、删减了部分模块（eg.Memory为外置模块，不需要CPU提供）。具体的工作有：
> - [x]  单周期CPU（文件夹为./SCPU_experiment)
> - [x]  多周期CPU（文件夹为./MCPU_experiment)
> - [x]  流水线CPU [五级流水线，支持Forwarding，Hazard detection]
（文件夹为./PCPU_experiment)
> - [ ]  流水线CPU基础上的中断(INT)、异常实现(syscall)实现
[五级流水线，支持Forwarding，Hazard detection]（文件夹为./PCPU_INT)

（注1：先在Modelsim上仿真，没问题后再在实物上操作）
（注2：中断异常实验要求自己写测试文件.asm，最终也没有做完，投入了大量的时间和精力，但是实在找不到bug在哪里/(ㄒoㄒ)/~~跑不出应有的效果，已尽力，只能放下啦……）

祝好！
　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　**by Tina**