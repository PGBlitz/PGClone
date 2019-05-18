#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
mountnumbers () {
    pgclonevars

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
VFS RClone Mount Settings ~ pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
NOTE1 : typ only numbers without M / G or H


RClone Variable Name           Default ~ Current Settings

[1] Buffer-Size                16M        [$vfs_bs] MB
[2] Drive-Chunk-Size           64M        [$vfs_dcs] MB
[3] Dir-Cache-Time             2M         [$vfs_dct] Minutes
[4] VFS-Read-Chunk-Size        64M        [$vfs_rcs] MB
[5] VFS-Read-Chunk-Size-Limit  2G         [$vfs_rcsl] GB
[6] VFS-Cache-Mode             off        [$vfs_cm]
[7] VFS-Cache-Max-Age          1H         [$vfs_cma] Hours
[8] VFS-Cache-Max-Size         100G       [$vfs_cms] GB
[Z] Exit

Please read the wiki on how changing these settings impact stability and performance!
After you change these settings, you must redeploy the mounts for them to take effect.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

    read -rp '↘️  Input Selection | Press [ENTER]: ' fluffycat < /dev/tty

    case $fluffycat in
        1 )
        mountset ;;
        2 )
        mountset ;;
        3 )
        mountset ;;
        4 )
        mountset ;;
        5 )
        mountset ;;
        6 )
        mountset ;;
        7 )
        mountset ;;
        8 )
        mountset ;;
        z )
        a=b ;;
        Z )
        a=b ;;
        * )
        mountnumbers ;;
    esac

}

mountset () {

    mountselection="$fluffycat"

    if [[ "$mountselection" == "1" ]]; then
        name="Buffer-Size"
        sizeSuffix="MB"
        start="8"
        end="1024"
        note="Open files will be buffered to RAM up to this limit. This limit is per opened file.

        The buffer size should be a relatively small amount. It's intended to smooth out network congestion and blips.
        The buffer will get cleared when you seek in plex or when the file is closed.
        Having a larger buffer may cause slower video start times.

        WARNING: This is highly dependent on the amount of RAM and number of opened files.
        Plex opens several files during library scans and each file open will consume up to the amount of RAM specified.
        If you set this too high and don't have enough free RAM, you will cause the mounts to crash!

        RECOMMENDATIONS: 2GB RAM: 8MB | 4GB RAM: 16MB | 8GB RAM: 16-32MB | 16GB+ RAM: 64MB-128MB
        This value must be less than the vfs-read-chunk-size to prevent 'too many open file requests' errors!
        "

    fi

    if [[ "$mountselection" == "2" ]]; then
      name="Drive-Chunk-Size"
      sizeSuffix="MB"
      start="8"
      end="1024"
      note="Upload chunk size, increasing the chunk size may increase upload speed, however it uses more RAM.
      Input must be one of the following numbers (power of 2)!
      [8] [16] [32] [64] [128] [256] [512] [1024]"
    fi

    if [[ "$mountselection" == "3" ]]; then
        name="Dir-Cache-Time"
        sizeSuffix="Minutes"
        start="1"
        end="7620"
        note="This controls the cache time for remote directory information and contents.
        This may delay external changes (such as from gdrive website) from being seen on your server until the cache expires.
        You should set this high unless you make lots of external changes."
    fi

    if [[ "$mountselection" == "4" ]]; then
        name="VFS-Read-Chunk-Size"
        sizeSuffix="MB"
        start="16"
        end="1024"
        note="This allows reading the source objects in parts, by requesting only chunks from the remote that are actually read at the cost of an increased number of requests.
        Must be greater than the buffer-size to prevent too many open file requests!"
    fi

    if [[ "$mountselection" == "5" ]]; then
        name="VFS-Read-Chunk-Size-Limit"
        sizeSuffix="GB"
        start="1"
        end="100"
        note="The chunk size for each open file will get doubled for each chunk read, until the specified value is reached.
        This limit must be greater than vfs-read-chunk-size and it's only used when the vfs-cache-mode is not set to full."
    fi

    if [[ "$mountselection" == "6" ]]; then
        name="VFS-Cache-Mode"
        sizeSuffix=""
        start="1"
        end="4"
        note="1) off:
    ◽️ Files opened for read OR write will NOT be buffered to disks.
    ◽️ Files can’t be opened for both read AND write.
    ◽️ Files opened for write can’t be seeked.

2) minimal:
    ◽️ Files opened for read/write will be buffered to disks.
    ◽️ Files opened for write only can’t be seeked

3) writes:
    ◽️ Write only and read/write files are buffered to disk first.
    ◽️ This mode should support all normal file system operations.

4) full:
    ◽️ All files are buffered to and from disk.
    ◽️ When a file is opened for read it will be downloaded in its entirety first.
    ◽️ This mode should support all normal file system operations."
fi

if [[ "$mountselection" == "7" ]]; then
  name="VFS-Cache-Max-Age"
  sizeSuffix="Hours"
  start="1"
  end="360"
  note="Impacts how long files are cached on disk, only used if vfs-cache-mode is NOT off!"
fi

if [[ "$mountselection" == "8" ]]; then
  name="VFS-Cache-Max-Size"
  sizeSuffix="GB"
  start="1"
  end="1000"
  note="The max total size of objects in the cache, only used if vfs-cache-mode is NOT off."
fi

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Setting Variable >>> $name
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Type a number between [$start] and [$end] $sizeSuffix

$note

Quitting? Type >>> exit
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

    read -rp '↘️  Input Selection | Press [ENTER]: ' typed < /dev/tty
    if [[ "$typed" == "exit" || "$typed" == "Exit" || "$typed" == "EXIT" ]]; then mountnumbers; fi

    # This Select Requires Answers to be In the Power of Two
    if [[ "$mountselection" == "2" ]]; then
        if [[ "$typed" != "8" && "$typed" != "16" && "$typed" != "32" && "$typed" != "64" && "$typed" != "128" && "$typed" != "256" && "$typed" != "512" && "$typed" != "1024" ]]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Power of Two Notice
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

NOTE: The value you enter must be a power of two!
[8] [16] [32] [64] [128] [256] [512] [1024]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
            read -rp '↘️  Acknowledge Info | Press [ENTER] ' typed < /dev/tty
            mountset
    fi; fi


    if [[ "$typed" -lt "$start" || "$typed" -gt "$end" ]]; then mountset; else

        if [[ "$mountselection" == "1" ]]; then echo "$typed" | grep -o '[0-9]*' > /var/plexguide/vfs_bs; fi
        if [[ "$mountselection" == "2" ]]; then echo "$typed" | grep -o '[0-9]*' > /var/plexguide/vfs_dcs; fi
        if [[ "$mountselection" == "3" ]]; then echo "$typed" | grep -o '[0-9]*' > /var/plexguide/vfs_dct; fi
        if [[ "$mountselection" == "4" ]]; then echo "$typed" | grep -o '[0-9]*' > /var/plexguide/vfs_rcs; fi
        if [[ "$mountselection" == "5" ]]; then echo "$typed" | grep -o '[0-9]*' > /var/plexguide/vfs_rcsl; fi
        if [[ "$mountselection" == "7" ]]; then echo "$typed" | grep -o '[0-9]*' > /var/plexguide/vfs_cma; fi
        if [[ "$mountselection" == "8" ]]; then echo "$typed" | grep -o '[0-9]*' > /var/plexguide/vfs_cms; fi


      if [[ "$mountselection" == "6" ]]; then
        if [[ "$typed" == "1" ]]; then echo "off" > /var/plexguide/vfs_cm; fi
        if [[ "$typed" == "2" ]]; then echo "minimal" > /var/plexguide/vfs_cm; fi
        if [[ "$typed" == "3" ]]; then echo "writes" > /var/plexguide/vfs_cm; fi
        if [[ "$typed" == "4" ]]; then echo "full" > /var/plexguide/vfs_cm; fi
      fi

    fi

    mountnumbers
}
