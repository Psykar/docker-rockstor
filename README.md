# Run Rockstor inside a Docker container

> This is still WORK IN PROGRESS

Make your own `docker-compose.overide.yml` from `docker-compose.overide.yml.dist`
mapping ports and volumes as you like.

To use rockons you'll need to mount the directories that they need in your host (rockstor can't do this for you!)

On the docker host run `mkdir /mnt2`
If you have a single pool, just mount the pool at `/mnt2`.
If you have multiple pools, you'll need to mount each subvol as a subdirectory inside `/mnt2` instead.

Start `docker-compose up -d`

Open browser on `https://localhost/`


You can view logs
Enter inside container `docker-compose exec rockstor bash`
Keep an eye on logs for debugging purposes `tail -f /opt/rockstor/var/log/*.log`
