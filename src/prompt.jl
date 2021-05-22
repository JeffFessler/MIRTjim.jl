#=
prompt.jl
prompt user to hit a key to continue
=#

export prompt

import Plots # isplotnull, plot!
import REPL

prompt_state = :prompt # global prompt state


"""
    prompt( ; gui::Bool=true)

Prompt user to hit any key to continue, after `gui()`.
Some keys have special actions: `[q]uit [d]raw [n]odraw`.
Call `prompt(:prompt)` to revert to default.
"""
function prompt( ;
    gui::Bool=true,
    io_in::IO = stdin,
    kwargs...,
)

    global prompt_state

    prompt_state === :nodraw && return nothing

    gui && !Plots.isplotnull() && display(plot!()) # Plots.gui()

    (prompt_state === :draw) && return nothing

    # call wait_for_key only if interactive or testing
    if isinteractive() || io_in != stdin
        c = wait_for_key( ; io_in, kwargs...)
    else
        c = 'd'
    end

    (c == 'd') && (prompt_state = :draw)
    (c == 'n') && (prompt_state = :nodraw)
    (c == 'q') && throw("quit")

    return nothing
end


"""
    function wait_for_key( ; io_in = stdin, io_out = stdout, prompt=?)

From:
https://discourse.julialang.org/t/wait-for-a-keypress/20218
"""
function wait_for_key( ;
    io_in::IO = stdin,
    io_out::IO = stdout,
    prompt::String = "press any key [d]raw [n]odraw [q]uit : ",
)

    print(io_out, prompt)

    t = REPL.TerminalMenus.terminal
    REPL.Terminals.raw!(t, true)
    char = read(io_in, Char)
    REPL.Terminals.raw!(t, false)

    write(io_out, char)
    write(io_out, "\n")

    return char
end


"""
    prompt(key::symbol)

Set prompt state to one of:
- `:prompt` call `gui()` if possible, then prompt user.
- `:draw` call `gui()` if possible, then continue.
- `:nodraw` do not call `gui()`, just continue.

Use `prompt(:state)` to query current state.

Actually it calls `display(plot!())` instead of `gui()`
"""
function prompt(key::Symbol)
    global prompt_state

    if key === :state
        return prompt_state
    end

    key ∉ (:prompt, :draw, :nodraw) && throw("prompt $prompt")
    prompt_state = key
end
