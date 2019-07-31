#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Authors:    Admin9705, Deiteq, and many PGBlitz Contributors
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################

showPresetBWLimitOptions() {
    tee <<-EOF
[0]    |  Max allowed by network and Google.
[9]    |  Default limit to prevent over 750gb a day.
[15]   |  Uses ~150mbps for uploading.
[40]   |  Uses ~350mbps for uploading.
[60]   |  Uses ~500mpbs for uploading.
[80]   |  Uses ~650mbps for uploading.
[100]  |  Uses ~800mbps for uploading.
[125]  |  Uses ~1Gbps for uploading.
[250]  |  Uses ~2Gbps for uploading.
[625]  |  Uses ~5Gbps for uploading.
EOF
}

setThrottle() {
    bwlimitVar="move.bw"

    if [[ "$transport" == "be" || "$transport" == "bu" ]]; then
        bwlimitVar="blitz.bw"
    fi

    bwlimit=$(cat "/var/plexguide/$bwlimitVar")
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⏫ Upload Limit                          📓 Reference: pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

This restricts upload bandwidth, useful to prevent network saturation.
You should only change this if you are uisng blitz!

EOF
    showPresetBWLimitOptions
    tee <<-EOF

ℹ️ This change will take effect on the next upload cycle.
Speeds are limited by your server's max upload speed and gdrive limits.

Current Limit: $bwlimit
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[T] TimeTable  | Change the upload limit based on time/day.
[Z] Exit
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

    read -rp '↘️  Input Selection | Type a Speed from 0 - 1000 | 0 for unlimited | Press [ENTER]: ' typed </dev/tty

    if [[ "$typed" == "Z" || "$typed" == "z" ]]; then
        rcloneSettings
    elif [[ "$typed" == "T" || "$typed" == "t" ]]; then
        setCustomTimeTable
    else
        if [[ "$typed" -ge "0" && "$typed" -le "10000" ]]; then
            echo "${typed}M" >"/var/plexguide/$bwlimitVar"
            rcloneSettingUpdatedNotice
        else
            badinput
            setThrottle
        fi
    fi
}

addCustomTimeTablePart() {
    timetable=$(cat /var/plexguide/timetable.bw)
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📅 BW Limit TimeSlot Configuration       📓 Reference: pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[1] Set the day when the limit should take effect:     [$day]
[2] Set then time when the limit should take effect:   [$time]
[3] Set BW Limit:                                      [$limit]

EOF
    if [[ $time == "" || $limit == "" ]]; then
        tee <<-EOF
Set the options above to build a timeslot to add to the timetable.
EOF
    else
        if [[ $day == "Everyday" || $day == "" ]]; then
            tee <<-EOF
Add this Timeslot: [$time,$limit]
Every day from [$time] to midnight, the uploads will be limited to [$limit].
EOF
        else
            tee <<-EOF
Add this Timeslot: [$day-$time,$limit]
On [$day] from [$time] to midnight, the uploads will be limited to [$limit].
EOF
        fi
    fi
    if [[ $time != "" && $limit != "" ]]; then
        tee <<-EOF

Current TimeTable: [$timetable]
EOF
    fi

    if [[ $time == "" || $limit == "" ]]; then
        tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[Z] Exit
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    else
        tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[A] Add Timeslot to Table
[Z] Exit
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    fi
    read -rp '↘️  Input Selection | Press [ENTER]: ' typed </dev/tty

    case $typed in
    1)

        dayofweek
        addCustomTimeTablePart
        ;;

    2)
        read -rp '↘️  Type a time (hh:ss) when the limit should take effect | Press [ENTER]: ' typed </dev/tty

        if [[ "$typed" =~ ^(0[0-9]|1[0-9]|2[0-3]|[0-9]):[0-5][0-9]$ ]]; then
            time="$typed"
            if [[ $time =~ ^([0-9]):[0-5][0-9]$ ]]; then
                time="0$time"
            fi

            addCustomTimeTablePart
        else
            invalidTimeNotice
            addCustomTimeTablePart
        fi
        ;;
    3)

        tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Common BW Limits
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
        showPresetBWLimitOptions
        tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

        read -rp '↘️  Type a BWLimit from 0 - 1000 | Press [ENTER]: ' typed </dev/tty
        if [[ "$typed" -ge "1" && "$typed" -le "10000" ]]; then
            limit="${typed}M"
            addCustomTimeTablePart
        elif [[ "$typed" == 0 ]]; then
            limit="off"
            addCustomTimeTablePart
        else
            badinput
            addCustomTimeTablePart
        fi
        ;;
    a)

        addTimeSlotToTable
        time=""
        day=""
        limit=""
        read -rp '↘️  TimeSlot Added!' typed </dev/tty
        ;;
    A)
        addTimeSlotToTable
        time=""
        day=""
        limit=""
        read -rp '↘️  TimeSlot Added!' typed </dev/tty
        ;;
    z) setCustomTimeTable ;;
    Z) setCustomTimeTable ;;
    *)
        addCustomTimeTablePart
        ;;
    esac
}

addTimeSlotToTable() {

    if [[ $limit != "" && $time != "" ]]; then

        if [[ "$day" == "Everyday" ]]; then
            echo -n " $time,$limit" | tr -d '\n' >>/var/plexguide/timetable.bw
            timetable=$(cat /var/plexguide/timetable.bw)
            echo -n "${timetable}" | awk '{gsub(/^ +| +$/,"")} {print $0 }' | tr -d '\n' >/var/plexguide/timetable.bw
            addCustomTimeTablePart
        else
            echo -n " $day-$time,$limit" | tr -d '\n' >>/var/plexguide/timetable.bw
            timetable=$(cat /var/plexguide/timetable.bw)
            echo -n "${timetable}" | awk '{gsub(/^ +| +$/,"")} {print $0 }' | tr -d '\n' >/var/plexguide/timetable.bw
            addCustomTimeTablePart
        fi

    else
        badinput
        addCustomTimeTablePart
    fi
}

setCustomTimeTable() {

    timetable=$(cat /var/plexguide/timetable.bw)
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📅 BW Limit TimeTable              rclone.org/docs/#bwlimit-bandwidth-spec
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

It's highly recommended you read the rclone docs on the BWLimit TimeTable.
While this does perform minor validation, it's still possible to make an invalid table which prevent uploads from working.

Read the docs: https://rclone.org/docs/#bwlimit-bandwidth-spec

[1] Add Timeslot to TimeTable
[2] Reset TimeTable

Current TimeTable: [$timetable]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[A] Apply TimeTable to Upload Limit
[Z] Exit
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    read -rp '↘️  Input Selection | Press [ENTER]: ' typed </dev/tty

    if [[ "$typed" == "z" || "$typed" == "Z" ]]; then
        setThrottle

    else
        if [[ "$typed" == "a" || "$typed" == "A" ]]; then
            if [[ $(cat /var/plexguide/timetable.bw) != "" ]]; then
                echo -n "$(cat /var/plexguide/timetable.bw)" >/var/plexguide/$bwlimitVar
                rcloneSettingUpdatedNotice
            else
                badinput
                setCustomTimeTable
            fi

        elif
            [[ "$typed" == "1" ]]
        then
            addCustomTimeTablePart
            setCustomTimeTable
        elif [[ "$typed" == "2" ]]; then
            echo -n "" >/var/plexguide/timetable.bw
            setCustomTimeTable
        fi
    fi
}

invalidTimeNotice() {
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔ Invalid Time Notice
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

NOTE: The value must be a time in hh:ss format.
Do not use am/pm! Use 24 hour (military) time. 

You must pad with a zero, so 0:00 should be 00:00 or 4:00 should be 04:00

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    read -rp '↘️  Acknowledge Info | Press [ENTER] ' typed </dev/tty
}

dayofweek() {
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🗓️ Choose day of the week                📓 Reference: pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[0] Everyday
[1] Sunday
[2] Monday
[3] Tuesday
[4] Wednsday
[5] Thursday
[6] Friday
[7] Saturday

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[Z] Exit
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

    read -rp '↘️  Input Selection | Press [ENTER]: ' typed </dev/tty

    case $typed in
    0) day="Everyday" ;;

    1) day="Sun" ;;
    2) day="Mon" ;;
    3) day="Tue" ;;
    4) day="Wed" ;;
    5) day="Thu" ;;
    6) day="Fri" ;;
    7) day="Sat" ;;
    z) a=b ;;
    Z) a=b ;;
    *) dayofweek ;;
    esac
}
