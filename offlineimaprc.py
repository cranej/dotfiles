#!/usr/bin/python
import subprocess

def get_gmail_password():
    return subprocess.check_output(
            ["pass email/crane.jin@outlook.com"], shell=True).strip('\n')
