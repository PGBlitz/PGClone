# Changelog

All notable changes to the PGClone will be added to this repo. For changes to the core project, see [PGBlitz changelog](https://github.com/PGBlitz/PGBlitz.com/blob/v8.6base/CHANGELOG.md).

Most changes require a PGClone redeploy to get them!

## 2019-07-31

**New features**

- Moved BWLimit setting to be under Rclone Settings menu so it can utilize quick deploy.
- Added TimeTable option when setting BWLimit! Now you can set different limits based on time/day.
- Moved RClone settings to be a top menu item
- Changed some commands. `ntdrive`, `ngdrive`, `ntcrypt`, `ngcrypt` have been updated to `ndrive gdrive`,`ndrive tdrive`,`ndrive gcrypt`,`ndrive tcrypt`
- Added `pglog appname` to easily to see docker logs for an app
- Added `pglogs` to display all of the mount and transport logs, (matches prior `blitz`/`move` functionality)
- Added Rclone speed test under RClone Settings
- Added --max-transfer and --transfers setttings.

## 2019-07-24

**New features**

- Moved user agent setting to be under Rclone Settings menu so it can utilize quick deploy.

## 2019-07-22

**New features**

- Updated pg commands
  - `blitz` will now just show the blitz/move log
  - dropped `move` since it's generic enough to cause conflicts
  - dropped `ntdrive`, `ngdrive`, `ntcrypt`, `ngcrypt` in favor of `nrcloneenv` instead.
  - Added excludes-file to allow user-custom file name pattern excludes.
    - Patterns listed in this file will be excluded from upload. This is useful for mp4 automator users.
    - Added `npgexclude` to edit the excludes file
    - Changes to the exclude file take affect on the next blitz/move cycle.

**Bugfixes**

- Fixed bug with recent changes that prevented the rclone services from unmounting

## 2019-07-20

**New features**

- CloneCleaner refactored so cleaner is updated when PGClone menu is started, no longer requires a redeploy just to update the cleaner script
- Consolidated the cleaner code into 1 script, the blitz/move scripts updated to call the cleaner script (redeploy pgclone needed for this change).

## 2019-07-19

**New features**

- VFS Options can now be Quick-Deployed, which is much faster than a full deploy. It doesn't stop the apps, it now just restarts the rclone services!

**Bugfixes**

- Fixes bug in cleaner (again sigh)
- Fixes issue with rclone services not exiting
  - Due to this bug, if you deployed 7-18 changes, you have to redeploy PGClone, then reboot your machine (important), then redeploy PGClone after reboot to fix.

## 2019-07-18

**New features**

- The deployment process will now verify your mounts are up! If your mounts have an error, deployment will be stopped and the error message is shown. This eliminates the need to manually verify your mounts are up after a deploy. It also keeps your apps shutdown if your mounts are down to prevent data loss.
- Log format has been updated to be more useful
- When no files are to be uploaded, it will now say that instead of running rclone and outputting a zeroed out progress log that was confusing to users.
- The deployment process now truncates your logs

**Bugfixes**

- Fixes "Fatal error: failed to umount FUSE fs: exit status 1: fusermount: failed to unmount" error.
- Fixes Move/Blitz logs from being truncated (blank) when nothing is active
- Fixes 0 files 0% progress logs that rclone will output when there is no files to upload. Now it will say there are no files to upload.
- Fixes cleaner script
- Fixes cleaner script cron job from not being created.
