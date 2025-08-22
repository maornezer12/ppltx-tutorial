# Manage Repository on VM
# [Git commands](https://git-scm.com/docs)


[Add ssh key on VM](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
```dtd
ssh-keygen -t ed25519 -C "your_email@example.com"
```
response
```
Generating public/private ed25519 key pair.
Enter file in which to save the key (/home/user_name/.ssh/id_ed25519): 
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /home/user_name/.ssh/id_ed25519
Your public key has been saved in /home/user_name/.ssh/id_ed25519.pub
```
add the key to the ssh
```dtd
eval "$(ssh-agent -s)"
```
```dtd
ssh-add ~/.ssh/id_ed25519
```
Identity added: /home/user_name/.ssh/id_ed25519 (your_email@example.com)


copy and paste the ssh pub key
add it to [SSH](https://github.com/settings/ssh/new)
```dtd
cat ~/.ssh/id_ed25519.pub
```
copy the key to ssh
```dtd
pbcopy < ~/.ssh/id_ed25519.pub
```

## on pc / vm
nano /home/data_liad/.ssh/config 
```dtd
Host github.com
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_ed25519
```
git clone 
```dtd
git clone git@github.com:liadppltx/bidev.git
```
Response
```dtd
Cloning into 'ppltx-tutorial'...
The authenticity of host 'github.com (140.82.112.3)' can't be established.
ED25519 key fingerprint is SHA256:+DiY3wvvV6TuJJhbpZisF/zLDA0zPMSvHdkr4UvCOqU.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'github.com' (ED25519) to the list of known hosts.
remote: Enumerating objects: 118, done.
remote: Counting objects: 100% (118/118), done.
remote: Compressing objects: 100% (86/86), done.
remote: Total 118 (delta 36), reused 101 (delta 21), pack-reused 0 (from 0)
Receiving objects: 100% (118/118), 345.47 KiB | 4.21 MiB/s, done.
Resolving deltas: 100% (36/36), done.
```


git test connection
```dtd
ssh -T git@github.com
```

[How to use multi repositories on singe pc](https://gist.github.com/rahularity/86da20fe3858e6b311de068201d279e3)

create ssh-key
```dtd
cd ~/.ssh
ssh-keygen -t ed25519 -C "student.ppltx@gmail.com" -f "ppltx_class"
```
add to 
```dtd
ssh-add --apple-use-keychain ~/.ssh/ppltx_class
```
copy the key to ssh
```dtd
pbcopy < ~/.ssh/ppltx_class.pub
```
