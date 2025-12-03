-module(aoc).

-export([main/0]).

main() ->
    io:format("Hello, world!~n"),

    day1().

day1() ->
    io:format("Start day 1~n"),
    case file_utils:read_file_lines("./inputs/day1.txt") of
        {ok, List} ->
            % io:format("~p~n", [List]),
            Nums = [parse_line(Item) || Item <- List],
            % io:format("~p~n", [Nums]),
            Result = sum_and_count(50, Nums),
            io:format("~p~n", [Result]);
        {err, Reason} ->
            io:format("Error ~s~n", Reason)
    end.

parse_line(Line) ->
    [Dir | NumChars] = string:trim(Line),
    Number = list_to_integer(NumChars),
    case Dir of
        $R -> Number;
        $L -> -Number
    end.

sum_and_count(A, Nums) ->
    lists:foldl(
        fun(Item, {AccA, Count}) ->
            NewA = AccA + Item,
            NewCount =
                case NewA rem 100 of
                    0 -> Count + 1;
                    _ -> Count
                end,
            io:format("sum ~p, count ~p~n", [NewA, NewCount]),
            {NewA, NewCount}
        end,
        {A, 0},
        Nums
    ).
