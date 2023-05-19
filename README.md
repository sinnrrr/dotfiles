# Hands-off computer setup

![desktop pic](https://i.imgur.com/HDuGa52.jpeg)

## Info
This pc setup is managed by `ansible`. Also `stow` plugin is used to symlink dotfiles.
Currently only macos is fully supported

## Local Installation

```bash
curl -fsSL https://raw.githubusercontent.com/Keep-Simple/.dotfiles/macos/setup.sh | sh -s
```

## Remote Installation
After installing locally,
You can use this playbook to manage other Macs as well; the playbook doesn't even need to be run from a Mac at all! If you want to manage a remote Mac, either another Mac on your network, or a hosted Mac like the ones from [MacStadium](https://www.macstadium.com), you just need to make sure you can connect to it with SSH:

  1. (On the Mac you want to connect to:) Go to System Preferences > Sharing.
  2. Enable 'Remote Login'.

> You can also enable remote login on the command line:
>
>     sudo systemsetup -setremotelogin on

Then edit the `inventory` file in this repo (standard ansible connection info under `remote_servers`)

```
[ip address or hostname of mac]  ansible_user=[mac ssh username]
```
Finally, run `ansible.sh` script with `run_remote` and optional ansible-playbook args
