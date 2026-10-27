#compdef my-app

autoload -U is-at-least

_my-app() {
    typeset -A opt_args
    typeset -a _arguments_options
    local ret=1

    if is-at-least 5.2; then
        _arguments_options=(-s -S -C)
    else
        _arguments_options=(-s -C)
    fi

    local context curcontext="$curcontext" state line
    _arguments "${_arguments_options[@]}" : \
'*-c[some config file]' \
'*-C[some config file]' \
'*--config[some config file]' \
'*--conf[some config file]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
'::file -- some input file:_files' \
'::choice:(first second)' \
":: :_my-app_commands" \
"*::: :->my-app" \
&& ret=0
    case $state in
    (my-app)
        words=($line[3] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:my-app-command-$line[3]:"
        case $line[3] in
            (test)
_arguments "${_arguments_options[@]}" : \
'--case=[the case to test]: :_default' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
&& ret=0
;;
(some_cmd)
_arguments "${_arguments_options[@]}" : \
'--config=[the other case to test]: :_default' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
'*::path:_default' \
&& ret=0
;;
(some-cmd-with-hyphens)
_arguments "${_arguments_options[@]}" : \
'--verbose[]' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
'::mode:(fast slow)' \
":: :_my-app__subcmd__some-cmd-with-hyphens_commands" \
"*::: :->some-cmd-with-hyphens" \
&& ret=0

    case $state in
    (some-cmd-with-hyphens)
        words=($line[2] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:my-app-some-cmd-with-hyphens-command-$line[2]:"
        case $line[2] in
            (some-nested-hidden-cmd)
_arguments "${_arguments_options[@]}" : \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_my-app__subcmd__some-cmd-with-hyphens__subcmd__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:my-app-some-cmd-with-hyphens-help-command-$line[1]:"
        case $line[1] in
            (some-nested-hidden-cmd)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
;;
(some-hidden-cmd)
_arguments "${_arguments_options[@]}" : \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_my-app__subcmd__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:my-app-help-command-$line[1]:"
        case $line[1] in
            (test)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(some_cmd)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(some-cmd-with-hyphens)
_arguments "${_arguments_options[@]}" : \
":: :_my-app__subcmd__help__subcmd__some-cmd-with-hyphens_commands" \
"*::: :->some-cmd-with-hyphens" \
&& ret=0

    case $state in
    (some-cmd-with-hyphens)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:my-app-help-some-cmd-with-hyphens-command-$line[1]:"
        case $line[1] in
            (some-nested-hidden-cmd)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
(some-hidden-cmd)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
}

(( $+functions[_my-app_commands] )) ||
_my-app_commands() {
    local commands; commands=(
'test:tests things' \
'some_cmd:tests other things' \
'some-cmd-with-hyphens:' \
'some-hidden-cmd:' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'my-app commands' commands "$@"
}
(( $+functions[_my-app__subcmd__help_commands] )) ||
_my-app__subcmd__help_commands() {
    local commands; commands=(
'test:tests things' \
'some_cmd:tests other things' \
'some-cmd-with-hyphens:' \
'some-hidden-cmd:' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'my-app help commands' commands "$@"
}
(( $+functions[_my-app__subcmd__help__subcmd__help_commands] )) ||
_my-app__subcmd__help__subcmd__help_commands() {
    local commands; commands=()
    _describe -t commands 'my-app help help commands' commands "$@"
}
(( $+functions[_my-app__subcmd__help__subcmd__some-cmd-with-hyphens_commands] )) ||
_my-app__subcmd__help__subcmd__some-cmd-with-hyphens_commands() {
    local commands; commands=(
'some-nested-hidden-cmd:' \
    )
    _describe -t commands 'my-app help some-cmd-with-hyphens commands' commands "$@"
}
(( $+functions[_my-app__subcmd__help__subcmd__some-cmd-with-hyphens__subcmd__some-nested-hidden-cmd_commands] )) ||
_my-app__subcmd__help__subcmd__some-cmd-with-hyphens__subcmd__some-nested-hidden-cmd_commands() {
    local commands; commands=()
    _describe -t commands 'my-app help some-cmd-with-hyphens some-nested-hidden-cmd commands' commands "$@"
}
(( $+functions[_my-app__subcmd__help__subcmd__some-hidden-cmd_commands] )) ||
_my-app__subcmd__help__subcmd__some-hidden-cmd_commands() {
    local commands; commands=()
    _describe -t commands 'my-app help some-hidden-cmd commands' commands "$@"
}
(( $+functions[_my-app__subcmd__help__subcmd__some_cmd_commands] )) ||
_my-app__subcmd__help__subcmd__some_cmd_commands() {
    local commands; commands=()
    _describe -t commands 'my-app help some_cmd commands' commands "$@"
}
(( $+functions[_my-app__subcmd__help__subcmd__test_commands] )) ||
_my-app__subcmd__help__subcmd__test_commands() {
    local commands; commands=()
    _describe -t commands 'my-app help test commands' commands "$@"
}
(( $+functions[_my-app__subcmd__some-cmd-with-hyphens_commands] )) ||
_my-app__subcmd__some-cmd-with-hyphens_commands() {
    local commands; commands=(
'some-nested-hidden-cmd:' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'my-app some-cmd-with-hyphens commands' commands "$@"
}
(( $+functions[_my-app__subcmd__some-cmd-with-hyphens__subcmd__help_commands] )) ||
_my-app__subcmd__some-cmd-with-hyphens__subcmd__help_commands() {
    local commands; commands=(
'some-nested-hidden-cmd:' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'my-app some-cmd-with-hyphens help commands' commands "$@"
}
(( $+functions[_my-app__subcmd__some-cmd-with-hyphens__subcmd__help__subcmd__help_commands] )) ||
_my-app__subcmd__some-cmd-with-hyphens__subcmd__help__subcmd__help_commands() {
    local commands; commands=()
    _describe -t commands 'my-app some-cmd-with-hyphens help help commands' commands "$@"
}
(( $+functions[_my-app__subcmd__some-cmd-with-hyphens__subcmd__help__subcmd__some-nested-hidden-cmd_commands] )) ||
_my-app__subcmd__some-cmd-with-hyphens__subcmd__help__subcmd__some-nested-hidden-cmd_commands() {
    local commands; commands=()
    _describe -t commands 'my-app some-cmd-with-hyphens help some-nested-hidden-cmd commands' commands "$@"
}
(( $+functions[_my-app__subcmd__some-cmd-with-hyphens__subcmd__some-nested-hidden-cmd_commands] )) ||
_my-app__subcmd__some-cmd-with-hyphens__subcmd__some-nested-hidden-cmd_commands() {
    local commands; commands=()
    _describe -t commands 'my-app some-cmd-with-hyphens some-nested-hidden-cmd commands' commands "$@"
}
(( $+functions[_my-app__subcmd__some-hidden-cmd_commands] )) ||
_my-app__subcmd__some-hidden-cmd_commands() {
    local commands; commands=()
    _describe -t commands 'my-app some-hidden-cmd commands' commands "$@"
}
(( $+functions[_my-app__subcmd__some_cmd_commands] )) ||
_my-app__subcmd__some_cmd_commands() {
    local commands; commands=()
    _describe -t commands 'my-app some_cmd commands' commands "$@"
}
(( $+functions[_my-app__subcmd__test_commands] )) ||
_my-app__subcmd__test_commands() {
    local commands; commands=()
    _describe -t commands 'my-app test commands' commands "$@"
}

if [ "$funcstack[1]" = "_my-app" ]; then
    _my-app "$@"
else
    compdef _my-app my-app
fi
