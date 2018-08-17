# Run Rockstor inside a Docker container

> This is still WORK IN PROGRESS

Unfortunately Rockstor was not meant for running inside a Docker container, but this is a first small step in the correct direction.
The image builds correcly and all services are running, but the WebUI hans after initial administration account setup.
If someone has more in depth knownledge of Rockstor, any help wellcome.

Make your own `docker-compose.overide.yml` from `docker-compose.overide.yml.dist`
mapping ports and volumes as you like.

Start `docker-compose up -d`

Enter inside container `docker-compose exec rockstor bash`
Keep an eye on logs for debugging purposes `tail -f /opt/rockstor/var/log/*.log`

Open browser on `https://localhost/`
