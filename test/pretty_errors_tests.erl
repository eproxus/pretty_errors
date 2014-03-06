-module(pretty_errors_tests).

-include_lib("eunit/include/eunit.hrl").

%--- Tests --------------------------------------------------------------------

stacktrace_test() ->
    ?assert(is_iodata(pe:st(stacktrace()))).

%--- Internal Functions -------------------------------------------------------

stacktrace() ->
    try error(expected) catch _:_ -> erlang:get_stacktrace() end.

% http://erlang.org/pipermail/erlang-questions/2009-May/044073.html
is_iodata(B) when is_binary(B) -> true;
is_iodata(L) -> is_iolist(L).

is_iolist([]) -> true;
is_iolist([X|Xs]) when is_integer(X), X >= 0, X =< 255 ->
     is_iodata(Xs);
is_iolist([X|Xs]) ->
     case is_iodata(X) of
       true ->  is_iodata(Xs);
       false -> false
     end;
is_iolist(_) -> false.