# Changelog

All notable changes to the PGClone will be added to this repo. For changes to the core project, see [PGBlitz changelog](https://github.com/PGBlitz/PGBlitz.com/blob/v8.6base/CHANGELOG.md).

All changes require a PGClone redeploy to get them!

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
