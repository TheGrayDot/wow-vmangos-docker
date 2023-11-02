#!/usr/bin/python

import collections
import multiprocessing
import subprocess
import time
import threading


MAP_LIST = collections.deque(
    [
        0,
        1,
        13,
        25,
        30,
        33,
        34,
        35,
        36,
        37,
        42,
        43,
        44,
        47,
        48,
        70,
        90,
        109,
        129,
        169,
        189,
        209,
        229,
        230,
        249,
        269,
        289,
        309,
        329,
        349,
        369,
        389,
        409,
        429,
        449,
        450,
        451,
        469,
        489,
        509,
        529,
        531,
        533,
    ]
)


class worker_thread(threading.Thread):
    def __init__(self, map_id):
        threading.Thread.__init__(self)
        self.map_id = map_id

    def run(self):
        subprocess.call(
            [
                "./MoveMapGen",
                str(self.map_id),
                "--silent",
                "--configInputPath",
                "config.json",
            ],
            startupinfo=None,
        )


if __name__ == "__main__":
    cpu_count = multiprocessing.cpu_count()
    if cpu_count < 1:
        cpu_count = 1
    while len(MAP_LIST) > 0:
        if threading.active_count() <= cpu_count:
            worker_thread(MAP_LIST.popleft()).start()
        time.sleep(0.1)
