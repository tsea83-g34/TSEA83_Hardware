
add wave -divider PIPE

add wave -radix hex \
{sim:/pipecpu_tb/uut/pipe_ir1 } \
{sim:/pipecpu_tb/uut/pipe_ir2 } \
{sim:/pipecpu_tb/uut/pipe_ir3 } \
{sim:/pipecpu_tb/uut/pipe_ir4 }

add wave -divider CONTROL_UNIT

add wave \
{sim:/pipecpu_tb/uut/u_control_unit/ir1_op } \
{sim:/pipecpu_tb/uut/u_control_unit/ir2_op } \
{sim:/pipecpu_tb/uut/u_control_unit/ir3_op } \
{sim:/pipecpu_tb/uut/u_control_unit/ir4_op } 

add wave -divider ALU

add wave \
{sim:/pipecpu_tb/uut/u_alu/data_size_control_signal } \
{sim:/pipecpu_tb/uut/u_alu/alu_op_control_signal }

add wave \
{sim:/pipecpu_tb/uut/u_alu/alu_a } \
{sim:/pipecpu_tb/uut/u_alu/alu_b } \
{sim:/pipecpu_tb/uut/u_alu/alu_res }

add wave \
{sim:/pipecpu_tb/uut/u_alu/z_flag } \
{sim:/pipecpu_tb/uut/u_alu/n_flag } \
{sim:/pipecpu_tb/uut/u_alu/o_flag } \
{sim:/pipecpu_tb/uut/u_alu/c_flag } 

add wave -divider REGISTERS

add wave -radix hex \
{sim:/pipecpu_tb/uut/u_rf/write_data_d } \
{sim:/pipecpu_tb/uut/u_rf/out_a2 } \
{sim:/pipecpu_tb/uut/u_rf/out_b2 } \
{sim:/pipecpu_tb/uut/u_rf/registers }

add wave -radix unsigned \
{sim:/pipecpu_tb/uut/u_rf/read_addr_a } \
{sim:/pipecpu_tb/uut/u_rf/read_addr_b } \
{sim:/pipecpu_tb/uut/u_rf/read_addr_d } \
{sim:/pipecpu_tb/uut/u_rf/write_addr_d } 

add wave -divider LED

add wave -radix hex \
{sim:/pipecpu_tb/uut/led/value }

add wave -divider P_MEM

add wave -radix unsigned \
{sim:/pipecpu_tb/uut/u_pm/pm_counter }

add wave -radix hex \
{sim:/pipecpu_tb/uut/u_pm/pm_write_data } \
{sim:/pipecpu_tb/uut/u_pm/pm_write_address } \
{sim:/pipecpu_tb/uut/u_pm/pm_out } \
{sim:/pipecpu_tb/uut/u_pm/memory } 

add wave \
{sim:/pipecpu_tb/uut/u_pm/pm_write_enable } 

add wave -divider D_MEM

add wave -radix hex \
{sim:/pipecpu_tb/uut/u_dm/address } \
{sim:/pipecpu_tb/uut/u_dm/write_data } \
{sim:/pipecpu_tb/uut/u_dm/read_data } \
{sim:/pipecpu_tb/uut/u_dm/mem_chunk0 } \
{sim:/pipecpu_tb/uut/u_dm/mem_chunk1 } \
{sim:/pipecpu_tb/uut/u_dm/mem_chunk2 } \
{sim:/pipecpu_tb/uut/u_dm/mem_chunk3 } 

add wave \
{sim:/pipecpu_tb/uut/u_dm/write_or_read } \
{sim:/pipecpu_tb/uut/u_dm/size_mode }

add wave -divider V_MEM

add wave -radix hex \
{sim:/pipecpu_tb/uut/u_vmem/write_address } \
{sim:/pipecpu_tb/uut/u_vmem/write_data } \
{sim:/pipecpu_tb/uut/u_vmem/write_enable } \
{sim:/pipecpu_tb/uut/u_vmem/read_address } \
{sim:/pipecpu_tb/uut/u_vmem/v_mem } \
{sim:/pipecpu_tb/uut/u_vmem/fg_p_mem } \
{sim:/pipecpu_tb/uut/u_vmem/bg_p_mem }

add wave -divider DATA_FORWARDING

add wave -radix hex \
{sim:/pipecpu_tb/uut/u_df/a2 } \
{sim:/pipecpu_tb/uut/u_df/b2 } \
{sim:/pipecpu_tb/uut/u_df/d3 } \
{sim:/pipecpu_tb/uut/u_df/d4 } \
{sim:/pipecpu_tb/uut/u_df/imm2 } \
{sim:/pipecpu_tb/uut/u_df/alu_a_out } \
{sim:/pipecpu_tb/uut/u_df/alu_b_out } \
{sim:/pipecpu_tb/uut/u_df/ar3_out } \
{sim:/pipecpu_tb/uut/u_df/dataforwarding_b } \
{sim:/pipecpu_tb/uut/u_df/ar_argument } \
{sim:/pipecpu_tb/uut/u_df/ar3 } \
{sim:/pipecpu_tb/uut/u_df/imm2_sign_ext } 

add wave \
{sim:/pipecpu_tb/uut/u_df/df_a_select } \
{sim:/pipecpu_tb/uut/u_df/df_b_select } \
{sim:/pipecpu_tb/uut/u_df/df_alu_imm_or_b } \
{sim:/pipecpu_tb/uut/u_df/df_ar_a_or_b } 

add wave -divider END
