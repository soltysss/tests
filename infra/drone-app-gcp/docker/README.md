### Build and publish standalone nolimit drone image

```bash
export VERSION=<version>

docker build --build-arg VERSION=$VERSION --rm -f server.dockerfile -t drone/drone:$VERSION .

docker tag drone/drone:$VERSION gcr.io/development-156220/drone/drone:$VERSION

docker push gcr.io/development-156220/drone/drone:$VERSION
```

### Build and publish standalone drone-runner-docker image

```bash
export VERSION=<version>

docker build --build-arg VERSION=$VERSION --rm -f runner.dockerfile -t drone/drone-runner-docker:$VERSION .

docker tag drone/drone-runner-docker:$VERSION gcr.io/development-156220/drone/drone-runner-docker:$VERSION

docker push gcr.io/development-156220/drone/drone-runner-docker:$VERSION
```