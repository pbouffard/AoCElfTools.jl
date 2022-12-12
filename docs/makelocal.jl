#!julia --project
"""
Runs documenter locally.

Usage:
cd AoCElfTools/docs
./makelocal.jl

View generated docs:
cd AoCElfTools/docs
open build/index.html
"""

using AoCElfTools
using Documenter

makedocs(sitename="AoCElfTools")