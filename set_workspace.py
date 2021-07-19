#!/usr/bin/python3
import json
import os
import re
import shlex
import subprocess
from pathlib import Path

dir_path = Path(os.path.dirname(os.path.realpath(__file__)))
WORKSPACE_ENV_FILE = dir_path / '.workspace.env'
WORKSPACE_TF_VARS_FILE = dir_path / '.workspace.tfvars'


def print_ident(text):
    print(f'  -> {text}')


def run_cmd(cmd):
    return subprocess.check_output(shlex.split(cmd)).decode().strip()


def get_current_subscription():
    info = json.loads(run_cmd('az account show'))
    return info['id']


def read_workspace_values():
    with open(dir_path / 'workspace.json', 'r') as f:
        values = json.load(f)
    return values


def set_subscription_id(values):
    current_subscription = get_current_subscription()
    expected_subscription = values['subscription_id']
    if current_subscription != expected_subscription:
        print_ident(f'Switching account to subscription_id: {expected_subscription}')
        run_cmd(f'az account set --subscription {expected_subscription}')
    print(f"Subscription ID set to: {values['subscription_id']}")


def write_file(file, values, line_formatter):
    warning = '\n# !!! WARNING: This file is managed by "set_workspace" and may be overwritten anytime!!!\n\n'
    lines_to_write = [warning]
    for k, v in values.items():
        lines_to_write.append(line_formatter(k, v))

    lines_to_write.append(warning)

    with open(file, 'w') as f:
        f.writelines(lines_to_write)

    # make file only accessible by current user (due to secrets)
    file.chmod(0o600)


def write_env_file(values):
    def line_formatter(k, v):
        varname = k.upper().replace('-', '_')
        return f'export {varname}="{v}"\n'

    write_file(WORKSPACE_ENV_FILE, values, line_formatter)


def determine_variable_names_expected_by_terraform():
    tfvars = []
    varfile = dir_path / 'vars.tf'
    with open(varfile, 'r') as f:
        for line in f.readlines():
            match = re.match(r'^variable\s*"?(\w+)"?\s*', line.strip())
            if match:
                tfvars.append(match.group(1))
    return tfvars


def filter_values_for_terraform(values):
    expected = determine_variable_names_expected_by_terraform()
    return {k: v for k, v in values.items() if k in expected}


def write_terraform_value_file(values):
    def line_formatter(k, v):
        return f'{k}="{v}"\n'

    values = filter_values_for_terraform(values)
    write_file(WORKSPACE_TF_VARS_FILE, values, line_formatter)


VALUES = read_workspace_values()
set_subscription_id(VALUES)
write_env_file(VALUES)
write_terraform_value_file(VALUES)
