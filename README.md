一个小的计算程序cserver使用gen_server实现，不足之处请指正。用rebar构建工具。使用simple_one_for_one多次创建子进程。用指定的子进程进行计算。设置定时器。进程正常匹配后进程挂掉然后重启进程。
麻雀虽小五脏俱全。

1>calculate ./rebar compile          
2>cd ebin/        
3>erl       

1> application:load(cserver).         
2> application:start(cserver).        
3> supervisor:start_child(cserver_sup, [ ]).       
4> cserver_server:calculate({1,'+',2}).      

3> supervisor:start_child(cserver_sup, [ ]). //多次启动子进程后不会报错                
4>cserver_server:calculate(pid(0,42,0), {1, '+', 2}).

stop and restart：             
14> cserver_server:stop(pid(0,49,0)).
cast stop{state,undefined}
cserver_server stopping !
ok
this is P's pid: abc312        
        
15> cserver_server starting!
this is a testx

