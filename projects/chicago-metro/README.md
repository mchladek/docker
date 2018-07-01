
# Chicago Metro Area

This project is configured to download/prepare/build a complete Pelias installation for Chicago, Illinois.

# Setup

Please refer to the instructions at https://github.com/pelias/docker in order to install and configure your docker environment.

The minimum configuration required in order to run this project are [installing prerequisites](https://github.com/pelias/docker#prerequisites), along with the additional requirement of having `unzip` installed, [install the pelias command](https://github.com/pelias/docker#installing-the-pelias-command) and [configure the environment](https://github.com/pelias/docker#configure-environment).

Please ensure that's all working fine before continuing.

# Run a Build

To run a complete build, execute the the `deploy.sh` script found in the root directory of this project.

# Make an Example Query

You can now make queries against your new Pelias build:

http://localhost:4000/v1/search?text=Woodlawn
