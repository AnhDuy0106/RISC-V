Block diagram of RISC-V:

![image](https://github.com/AnhDuy0106/RISC-V/assets/126902854/98ba0c6f-751c-4f60-921b-63b1178f4493)
                              
TỔNG QUAN VỀ DỰ ÁN:

RISC-V (Reduced Instruction Set Architecture) là một kiến trúc tập lệnh tiêu chuẩn mở (ISA) dựa trên các nguyên tắc máy tính tập lệnh giảm (RISC) đã được thiết lập. Không giống như hầu hết các thiết kế ISA khác, RISC-V ISA được cung cấp theo giấy phép nguồn mở không yêu cầu phí sử dụng. Dự án này tập trung vào việc mô phỏng RISC-V bằng code Verilog, sử dụng phần mềm mô phỏng Modelsim.

RISC-V rất quan trọng vì nó sẽ cho phép các nhà sản xuất thiết bị nhỏ hơn xây dựng phần cứng mà không phải trả tiền bản quyền và cho phép các nhà phát triển và nhà nghiên cứu thiết kế và thử nghiệm kiến trúc tập lệnh đã được chứng minh và có sẵn miễn phí. RISC-V lý tưởng cho nhiều ứng dụng khác nhau từ IOT đến các hệ thống nhúng như đĩa, CPU, Máy tính, SOC, v.v.

ENG:

RISC-V(Reduced Instruction Set Architecture) is an open standard instruction set architecture (ISA) based on established reduced instruction set computer (RISC) principles. Unlike most other ISA designs, the RISC-V ISA is provided under open source licenses that do not require fees to use. This project focuses on making a RISC-V using code Verilog, and using software Modelsim to simulation.

RISC-V is significant because it will allow smaller device manufacturers to build hardware without paying royalties and allow developers and researchers to design and experiment with a proven and freely available instruction set architecture. RISC-V is ideal for a variety of applications from IOTs to Embedded systems such as disks, CPUs, Calculators, SOCs, etc.


1. Fetch
   
In this stage, the processor fetches the instruction from memory. Then, the
instruction is loaded into the instruction cache, which is used to store the
recently used instructions.
2. Decode

In this stage, the processor decodes the fetched instruction to determine the
operation it needs to perform. The instruction is analyzed to determine the
type of operation, registers, and the locations of any operands.

3. Execute

In this stage, the processor performs actual operation specified by the
instruction. This involves arithmetic or logical operations, such as addition
and subtraction. Besides, it also involves memory access or branching to a
different part of the program.

5. Memory
   
In this stage, the processor access memory to read or write the data obtained
from previous stage. However, this stage is optional. Some instruction such
as “add” does not involve memory access.

6. Writeback
   
In this stage, the results of the operation are written back to the appropriate
register in the register file. 

![image](https://github.com/AnhDuy0106/RISC-V/assets/126902854/e32975e6-51d5-4d0d-bb05-03b4470eac76)

