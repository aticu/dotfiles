#!/bin/bash

pacman -Qqe > packages-$(cat /etc/hostname)
