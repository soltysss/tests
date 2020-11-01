import os
import requests

DRONE_TOKEN = os.environ['DRONE_TOKEN']
MACHINE = os.environ['MACHINE']
URL_PREFIX = f"{os.environ['DRONE_SERVER']}/api/"


def main():
    headers = {"Authorization": DRONE_TOKEN}

    def get(path):
        return requests.get(URL_PREFIX + path, headers=headers).json()

    url_pattern = URL_PREFIX + "repos/{namespace}/{name}/builds/{build}"
    queue = {}
    for build in get('queue'):
        queue[build["build_id"]] = {"machine": build["machine"]}

    for build in get('builds/incomplete'):
        in_queue = queue.get(build["build"]["id"])
        if not in_queue or not in_queue["machine"] == MACHINE:
            continue
        url = url_pattern.format(
            namespace=build["namespace"],
            name=build["name"],
            build=build["build"]["number"],
        )
        # cancel build
        requests.delete(url, headers=headers)
        # restart build
        requests.post(url, headers=headers)


if __name__ == "__main__":
    main()
