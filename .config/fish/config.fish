if status is-interactive
    # Commands to run in interactive sessions can go here
end
if status is-login
    exec bash -c "test -e /etc/profile && source /etc/profile;\
    exec fish"
end

