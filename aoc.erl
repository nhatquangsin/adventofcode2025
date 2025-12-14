-module(aoc).

-export([main/0]).

main() ->
    io:format("Hello, world!~n"),

    % day1:day1(),

    % io:format("~p~n", [day2:min_half(110)]),
    % io:format("~p~n", [day2:full_from_half(0)]),
    % Start = 998,
    % End = 1012,
    % io:format("~p~n", [day2:find_repeated(0, min(day2:min_half(Start), day2:min_half(End)), Start, End)]).
    day2:day2().
