SSH
=====

# Generate Keys [1](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
`ssh-keygen -t rsa -b 4096 -C "<YOUR@EMAIL.COM>" -N "" -f <TARGET_FILE>`
This generate a key without a password `-N ""` and with the email as a label.

# Add target URL/machine to known_hosts
- Remove the machine if already in known_hosts `ssh-keygen -R <URL>`
- Add the new machine `ssh-keyscan -t rsa <URL> >> ~/.ssh/known_hosts`

# Get public key from private one
`ssh-keygen -y -f <PRIVATE_KEY>`

# Get fingerprint from key [1](http://stackoverflow.com/questions/9607295/how-do-i-find-my-rsa-key-fingerprint)

* For SHA print
`ssh-keygen -lf ~/.ssh/id_rsa.pub` 

* For MD5 print
`ssh-keygen -E md5 -lf ~/.ssh/id_rsa.pub`

*Hint* AWS keys are not fingerprinted as expected and use a different method see [1](http://serverfault.com/questions/603982/why-does-my-openssh-key-fingerprint-not-match-the-aws-ec2-console-keypair-finger).

# Test connection
`ssh -T -o 'StrictHostKeyChecking=no' -o 'ConnectionAttempts=1' -vvv ec2-user@<URL> -i <KEY_FILE>`

