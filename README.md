
( This is a work in progress! )


## Getting Started

- `./bin/create-keys.sh` - Create our SSH keys.


## Development

- `./bin/clean.sh` - Kill all containers (or an existing container, if specified), remove them, (re)build them, and start them back up.
- `./bin/attach.sh` - Attach to any running container.
- `./bin/clean-and-attach.sh` - Nice wrapper script for the previous two commands. :-)
- `./bin/logs.sh` - Display logs from all containers, or a single container if specified.


## External Links

- <a href="https://engineering.fb.com/security/scalable-and-secure-access-with-ssh/">Scalable and secure access with SSH</a> - The original article from Facebook's engineering blog which got me started down this path.
- <a href="https://smallstep.com/blog/use-ssh-certificates/">If you’re not using SSH certificates you’re doing SSH wrong</a>
- <a href="https://github.com/vedetta-com/vedetta/blob/master/src/usr/local/share/doc/vedetta/OpenSSH_Principals.md">OpenSSH Principals</a>

## Credits

- <a href="https://github.com/panubo/docker-sshd">SSHD Container for Docker</a> - It used in this package, and I've found it to be quite handy!

## Contact

My email is doug.muth@gmail.com.  I am also <a href="http://twitter.com/dmuth">@dmuth on Twitter</a> 
and <a href="http://facebook.com/dmuth">Facebook</a>!


