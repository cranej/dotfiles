#!/usr/bin/python
import subprocess

def get_gmail_password():
    return subprocess.check_output(
            ["gpg2 -dq ~/.mutt/muttpwds2.gpg"], shell=True).strip('\n')
