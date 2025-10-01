### Corne


### Keyboard Corne
| key         | action                        |
[Software](https://vial.rocks/)

In Linux


Universal Vial udev rule [link info](https://get.vial.today/manual/linux-udev.html)

For a universal access rule for any device with Vial firmware, run this in your shell while logged in as your user (this will only work with sudo installed):

```shell
export USER_GID=`id -g`; sudo --preserve-env=USER_GID sh -c 'echo "KERNEL==\"hidraw*\", SUBSYSTEM==\"hidraw\", ATTRS{serial}==\"*vial:f64c2b3c*\", MODE=\"0660\", GROUP=\"$USER_GID\", TAG+=\"uaccess\", TAG+=\"udev-acl\"" > /etc/udev/rules.d/99-vial.rules && udevadm control --reload && udevadm trigger'
```

This command will automatically create a udev rule and reload the udev system.



