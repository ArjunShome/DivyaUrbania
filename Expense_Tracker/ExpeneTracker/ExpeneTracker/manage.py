#!/usr/bin/env python
"""
Command-line utility for administrative tasks.
"""

import os
import django
import sys

if __name__ == "__main__":
    os.environ.setdefault(
        "DJANGO_SETTINGS_MODULE",
        "ExpeneTracker.settings"
    )

    from django.core.management import execute_from_command_line

    execute_from_command_line(sys.argv)
