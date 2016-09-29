SSH
=====

# Generate Keys
`ssh-keygen -t rsa -b 4096 -C "<YOUR@EMAIL.COM>" -N "" -f <TARGET_FILE>`
This generate a key without a password `-N ""` and with the email as a label.

Source: https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/

# Add target URL/machine to known_hosts
- Remove the machine if already in known_hosts `ssh-keygen -R <URL>`
- Add the new machine `ssh-keyscan -t rsa <URL> >> ~/.ssh/known_hosts`

# Get public key from private one
`ssh-keygen -y -f <PRIVATE_KEY>`

# Test connection
`ssh -T -o 'StrictHostKeyChecking=no' -o 'ConnectionAttempts=1' -vvv ec2-user@<URL> -i <KEY_FILE>`

