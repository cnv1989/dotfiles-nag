#!/usr/bin/env python3

import argparse
import os
import time


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="""Client for synchronizing between local and remote."""
    )
    parser.add_argument(
        "--local",
        "-l",
        required=True,
        help="Path to the local directory")

    parser.add_argument(
        "--ssh",
        required=True,
        help="Address of the remote server")

    parser.add_argument(
        "--remote",
        "-r",
        required=True,
        help="Path of the remote server")

    parser.add_argument(
        "--sync",
        required=True,
        choices=['local_to_remote', 'remote_to_local'],
        help="Direction of the sync")

    parser.add_argument(
        "--interval",
        "-i",
        type=int,
        default=10,
        help="Sync interval in seconds")

    parser.add_argument(
        "--exclude-files",
        "-e",
        help="Path to the file containing list of files to be excluded")

    args = parser.parse_args()

    while True:
        if args.sync == 'remote_to_local':
            command = """rsync -r -a -v -e ssh --delete {ssh}:{remote} {local}"""
        else:
            command = """rsync -r -a -v -e ssh --delete {local} {ssh}:{remote}"""

        if args.exclude_files:
            command = " {command} --exclude-from={exclude_files}".format(
                command=command, exclude_files=args.exclude_files)

        command = command.format(
            exclude_files=args.exclude_files,
            ssh=args.ssh,
            remote=args.remote,
            local=args.local
        )
        os.system(command)
        time.sleep(args.interval)
