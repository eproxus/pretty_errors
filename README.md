pretty_errors
=============

Error and stack trace pretty printers for Erlang

## Stacktraces

Normal:

```erl
1> try error(expected) catch _:_ -> erlang:get_stacktrace() end.
[{erl_eval,do_apply,6,[{file,"erl_eval.erl"},{line,573}]},
 {erl_eval,try_clauses,8,[{file,"erl_eval.erl"},{line,764}]},
 {shell,exprs,7,[{file,"shell.erl"},{line,674}]},
 {shell,eval_exprs,7,[{file,"shell.erl"},{line,629}]},
 {shell,eval_loop,3,[{file,"shell.erl"},{line,614}]}]
```

With pretty printing:
```erl
1> io:format(try error(expected) catch _:_ -> pe:st(erlang:get_stacktrace()) end).
    erl_eval:do_apply/6 (erl_eval.erl:573)
    erl_eval:try_clauses/8 (erl_eval.erl:764)
    erl_eval:expr_list/6 (erl_eval.erl:738)
    erl_eval:expr/5 (erl_eval.erl:330)
    shell:exprs/7 (shell.erl:674)
    shell:eval_exprs/7 (shell.erl:629)
    shell:eval_loop/3 (shell.erl:614)
ok
```

