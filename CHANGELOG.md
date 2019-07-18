# Changelog

All notable changes to the PGClone will be added to this repo. For changes to the core project, see [PGBlitz changelog](https://github.com/PGBlitz/PGBlitz.com/blob/v8.6base/CHANGELOG.md).

All changes require a PGClone redeploy to get them!

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
