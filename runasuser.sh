#!/bin/bash

this_program="$0"


function usage_message()
{
    cat <<EOF
${this_program}: usage:
    $0 [-h | --help] [options] [program [args]]

    Create a user/group and run program as that user.
    If no user is specified, run as the calling user (assumed to be root).
    If no program is specified, run /bin/bash.

    options:
       -h        --help          help
       -U USER   --user          username to create (default: root)
       -u UID    --uid           uid for user
       -G GROUP  --group         group name for user
       -g GID    --gid           gid for user
       -s G1,G2  --supplemental  supplemental groups (comma separated)
                              
    program                      program to start (default: /bin/bash)
    args                         arguments of program to start

EOF
}

function usage()
{
    usage_message >&2
    exit 1
}


user=""
uid=""
group=""
gid=""
supplemental=""
default_program="/bin/bash"

while [ "$#" -gt 0 ]; do
    case "$1" in
        -h|--help)
            usage
            ;;
        -U|--user)
            if [ "$#" -gt 1 ]; then
                user="$2"
                shift
            else
                echo "$this_program: missing user argument" >&2
                usage
            fi
            ;;
        -u|--uid)
            if [ "$#" -gt 1 ]; then
                uid="$2"
                shift
            else
                echo "$this_program: missing uid argument" >&2
                usage
            fi
            ;;
        -G|--group)
            if [ "$#" -gt 1 ]; then
                group="$2"
                shift
            else
                echo "$this_program: missing group argument" >&2
                usage
            fi
            ;;
        -g|--gid)
            if [ "$#" -gt 1 ]; then
                gid="$2"
                shift
            else
                echo "$this_program: missing gid argument" >&2
                usage
            fi
            ;;
        -S|--supplemental)
            if [ "$#" -gt 1 ]; then
                supplemental="$2"
                shift
            else
                echo "$this_program: missing supplemental argument" >&2
                usage
            fi
            ;;
        --)
            shift
            break
            ;;
        -?*)
            echo "$this_program: unknown option $1" >&2
            usage
            ;;
        *)
            break
            ;;
    esac
    
    shift
done


#echo "user $user"
#echo "uid $uid"
#echo "group $group"
#echo "gid $gid"
#echo "supplemental $supplemental"
#echo "program -$@-"


if [ -n "$user" ]; then
    if [ -z "$uid" ]; then
        echo "$this_program: missing uid" >&2
        usage
    elif [ -z "$group" ]; then
        echo "$this_program: missing group" >&2
        usage
    elif [ -z "$gid" ]; then
        echo "$this_program: missing gid" >&2
        usage
    fi

    sup_g=""
    if [ -n "$supplemental" ]; then
        sup_g="-G $supplemental"
    fi

    groupadd -g "$gid" "$group"
    if [ $? -ne 0 ]; then
        echo "$this_program: error adding group: $?" >&2
        exit 1
    fi

    useradd -M -g "$group" $sup_g -u "$uid" "$user"
    if [ $? -ne 0 ]; then
        echo "$this_program: error adding user: $?" >&2
        exit 1
    fi
fi


# cases
#  no user, no program
#     exec /bin/bash
#  no user, program
#     exec program
#  user, no program
#     exec su -c /bin/bash $user
#  user, program
#     exec su -c "$@" $user
#  

if [ -n "$user" ]; then
    # specified user
    if [ -n "$1" ]; then
        exec su -c "$(printf "%q " "$@")" -s /bin/bash "$user"
    else
        exec su -s /bin/bash "$user"
    fi
else
    # use default user (assumed root)

    eff_uid="$(id -u)"
    if [ "$eff_uid" != "0" ]; then
        echo "$this_program: warning: command running as uid $eff_uid instead of 0" >&2
    fi

    if [ -n "$1" ]; then
        exec "$@"
    else
        exec /bin/bash
    fi
fi


