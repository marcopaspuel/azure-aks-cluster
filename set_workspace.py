#!/usr/bin/python3
import json
import os
import shlex
import subprocess
from pathlib import Path

dir_path = Path(os.path.dirname(os.path.realpath(__file__)))


def print_ident(text):
    print(f'  -> {text}')


def run_cmd(cmd):
    return subprocess.check_output(shlex.split(cmd)).decode().strip()


def get_current_subscription():
    info = json.loads(run_cmd('az account show'))
    return info['id']


def read_workspace_values():
    with open(dir_path / 'workspace_all.json', 'r') as f:
        values = json.load(f)
    return values


def set_subscription_id(values):
    current_subscription = get_current_subscription()
    expected_subscription = values['subscription_id']
    if current_subscription != expected_subscription:
        print_ident(f'Switching account to subscription_id: {expected_subscription}')
        run_cmd(f'az account set --subscription {expected_subscription}')
    print(f"Subscription ID set to: {values['subscription_id']}")


VALUES = read_workspace_values()
set_subscription_id(VALUES)
