-module(file_utils).

-export([read_file_lines/1]).

read_file_lines(FilePath) ->
    case file:open(FilePath, [read]) of
        {ok, IoDevice} ->
            Lines = read_lines(IoDevice, []),
            file:close(IoDevice),
            {ok, lists:reverse(Lines)};
        {error, Reason} ->
            {error, Reason}
    end.

read_lines(IoDevice, Acc) ->
    case io:get_line(IoDevice, "") of
        eof ->
            Acc;
        Line ->
            read_lines(IoDevice, [Line | Acc])
    end.
