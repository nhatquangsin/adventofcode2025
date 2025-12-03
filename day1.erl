-module(day1).

-export([day1/0]).

day1() ->
    io:format("Start day 1~n"),
    case file_utils:read_file_lines("./inputs/day1.txt") of
        {ok, List} ->
            % io:format("~p~n", [List]),
            Nums = [parse_line(Item) || Item <- List],
            % io:format("~p~n", [Nums]),
            Result = sum_and_count_part_2(50, Nums),
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

sum_and_count_part_2(A, Nums) ->
    lists:foldl(
        fun(Item, {Raw, Count}) ->
            NewRaw = Raw + Item,

            Wraps = count_wraps(Raw, NewRaw),
            NewCount = Count + Wraps,

            Wrapped = ((NewRaw rem 100) + 100) rem 100,

            % io:format("raw ~p, wrapped ~p, count ~p (wrap ~p)~n",
            %     [NewRaw, Wrapped, NewCount, Wraps]),

            {NewRaw, NewCount}
        end,
        {A, 0},
        Nums
    ).

count_wraps(Old, New) ->
    Min = min(Old, New),
    Max = max(Old, New),

    From = ceil(Min / 100.0),
    To   = floor(Max / 100.0),

    RawCount = max(To - From + 1, 0),

    case Old rem 100 of
        0 -> RawCount - 1;
        _ -> RawCount
    end.

ceil(X) ->
    T = trunc(X),
    if X > T -> T + 1; true -> T end.

floor(X) ->
    T = trunc(X),
    if X < T -> T - 1; true -> T end.
