erl_proc_dot
=====

I wanted a way to be able to generate a visual snapshot of the Erlang
supervision tree.

This looks through all the Erlang processes and creates a file that
can be processed by the `dot` https://www.graphviz.org/ program.

Build
-----

    $ rebar3 compile

Run
---

    > erl_proc_dot:run().
    ok


    $ dot erlang_processes.dot -Tpng -o erlang_processes.png

