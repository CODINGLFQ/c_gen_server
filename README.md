cserver使用gen_server实现。用rebar构建工具。使用simple_one_for_one多次创建子进程。设置定时器正常匹配后进程挂掉然后重启进程。
麻雀虽小五脏俱全。

1> application:load(cserver).
2> application:load(cserver).
3> supervisor:start_child(cserver_sup, []).
4> cserver_server:calculate({1,'+',1}).

3> supervisor:start_child(cserver_sup, []). //多次启动子进程后不会报错
4>cserver_server:calculate(pid(0,42,0), {1, '+', 2}).

stop停止重启：
> cserver_server:stop(pid(0,49,0)).
cast stop{state,undefined}
cserver_server stopping !
ok
this is P's pid: abc312
> cserver_server starting!
this is a testx

