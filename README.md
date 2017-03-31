# wipe-arm-asuswrt
This script downloads and compiles all packages needed for adding secure file wiping capability of magnetic media to Asus ARM routers.

### HOWTO: Compile Wipe for AsusWRT firmware
```
cd
git clone https://github.com/blackfuel/wipe-arm-asuswrt.git
cd wipe-arm-asuswrt
./wipe.sh
```

### Usage
```
# wipe -h
Wipe v2.3.1 - released November 1st, 2009
by Tom Vier <nester@users.sf.net>

Usage is wipe [options] [file-list]

Options:         Default: wipe -ZdNTVEAkO -S512 -C4096 -l1 -x1 -p1

-h          --   help - display this screen
-u          --   usage
-c          --   show copyright and license
-w          --   show warranty information
-i  and  -I --   enable (-i) or disable (-I) interaction - overrides force
-f          --   force file wiping and override interaction
-r  and  -R --   recursion - traverse subdirectories
-s          --   silent - disable percentage and error reporting
-v          --   force verbose - always show percentage
-V          --   verbose - show percentage if file is >= 25K
-e  and  -E --   enhance (-e) percentage accuracy or faster writes (-E)
-d  and  -D --   delete (-d) or keep (-D) after wiping
-n  and  -N --   delete (-n) or skip (-N) special files
-k  and  -K --   lock (-k) or don't lock (-K) files
-z          --   zero-out file - single pass of zeroes
-Z          --   perform normal wipe passes
-t  and  -T --   enable (-t) or disable (-T) static passes
-a  and  -A --   write until out of space (-a) or don't (-A)
-o[size] -O --   write to stdout (-o) or use files (-O)
-B(count)   --   block device sector count
-S(size)    --   block device sector size - default 512 bytes
                 or stdout write length when used with -A
-C(size)    --   chunk size - maximum file buffer size in kilobytes (2^10)
-l[0-2]     --   sets wipe secure level
-x[1-32] -X --   sets number of random passes per wipe or disables
-p(1-32)    --   wipe file x number of times
-b(0-255)   --   overwrite file with this value byte
```

[Manpage for wipe](https://github.com/blackfuel/wipe-arm-asuswrt/blob/master/wipe.md)

[Secure Deletion of Data from Magnetic and Solid-State Memory by Peter Gutmann](http://wipe.sourceforge.net/secure_del.html)  
([Local Copy](https://github.com/blackfuel/wipe-arm-asuswrt/blob/master/secure_del.md))
