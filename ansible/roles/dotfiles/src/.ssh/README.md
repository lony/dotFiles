SSH
=====

# TOC

* [Setup](#setup)
* [Agent Support](#agent-support)
* [Agent Forwarding](#agent-forwarding)

----

# Setup

## Generate Keys 

`ssh-keygen -t rsa -b 4096 -C "<YOUR@EMAIL.COM>" -N "" -f <TARGET_FILE>`
This generate a key without a password `-N ""` and with the email as a label [1](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent).

## Add target URL/machine to known_hosts

- Remove the machine if already in known_hosts `ssh-keygen -R <URL>`
- Add the new machine `ssh-keyscan -t rsa <URL> >> ~/.ssh/known_hosts`

## Get public key from private one

`ssh-keygen -y -f <PRIVATE_KEY>`

## Get fingerprint from key

* For SHA print [1](http://stackoverflow.com/questions/9607295/how-do-i-find-my-rsa-key-fingerprint)
`ssh-keygen -lf ~/.ssh/id_rsa.pub` 

* For MD5 print
`ssh-keygen -E md5 -lf ~/.ssh/id_rsa.pub`

*Hint* AWS keys are not fingerprinted as expected and use a different method see [1](http://serverfault.com/questions/603982/why-does-my-openssh-key-fingerprint-not-match-the-aws-ec2-console-keypair-finger).

## Test connection

`ssh -T -o 'StrictHostKeyChecking=no' -o 'ConnectionAttempts=1' -vvv ec2-user@<URL> -i <KEY_FILE>`

# Agent Support

Keys are hard to handle, especially if they have a password. Thats were `ssh-agent` comes into play. Its a small tool which ones typed in, remembers your ssh keys password and lets you use the key without retyping the password over and over again.

## List keys

To list all keys which are managed by the agent type `ssh-add -L`

## Add key

To add a key to the agent use `ssh-add <PATH_TO_KEY>`

_Hint:_ On OSx you can also [move your key](http://www.stormacq.com/mac-os-x-makes-handling-ssh-keys-easier/) to the KeyChain of Mac.

# Agent Forwarding

If you have multiple host and want to jump from one to another without always copying you key to all the systems, which would be a security risk, you can use agent forwarding.

The principle is explained [here](http://unixwiz.net/techtips/ssh-agent-forwarding.html) in perfect detail, therefore only briefly explained: If you connect to another host and from there want to jump ones further, the key challenge is forwarded back to your client machine and if successfully propagated back to the target machine, instead of just using the keys available on the machine.

As perquisites agent forwarding needs `ssh-agent` on the client, which handles the key management. In your `~/.ssh/config` you have to allow `ForwardAgent yes` as also the server has to allow it.

_Hint:_ SSH agent forwarding is working nicely together with [Capistrano](http://capistranorb.com/documentation/getting-started/authentication-and-authorisation/) and can be setup like [1](http://blog.blenderbox.com/2013/02/20/ssh-agent-forwarding-with-github/) and [2](http://dchua.com/2013/08/29/properly-using-ssh-agent-forwarding-in-capistrano/).