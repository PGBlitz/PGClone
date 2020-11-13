### Falls under PG Prune for Execution to Save Time & Sanity

# Outside Variables
dlpath=$(cat ${PGBLITZ_DIR}/var/server.hd.path)
cleaner="$(cat ${PGBLITZ_DIR}/var/cloneclean)"

# Starting Actions
touch /pg/logs/pgblitz.log
mkdir -p "$dlpath/move"

# Repull excluded folder 
 wget -qN https://raw.githubusercontent.com/PGBlitz/PGClone/v10/functions/exclude -P ${PGBLITZ_DIR}/var/

# Permissions
chown -R 1000:1000 "$dlpath/move"
chmod -R 775 "$dlpath/move"

# Remove empty directories
find "$dlpath/move/" -type d -mmin +2 -empty -exec rm -rf {} \;

# Removes garbage
find "$dlpath/downloads" -mindepth 2 -type d -cmin +$cleaner $(printf "! -name %s " $(cat ${PGBLITZ_DIR}/var/exclude)) -empty -exec rm -rf {} \;
find "$dlpath/downloads" -mindepth 2 -type f -cmin +$cleaner $(printf "! -name %s " $(cat ${PGBLITZ_DIR}/var/exclude)) -size +1M -exec rm -rf {} \;
