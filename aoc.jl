#!/bin/bash
#=
exec julia --project --color=yes --startup-file=no "${BASH_SOURCE[0]}" "$@"
=#

using ArgParse
using AoCElfTools
using ProgressMeter

function parse_commandline()
  s = ArgParseSettings(;
    # prog="Advent Of Code",
    description="Run Advent Of Code puzzle solutions",
    # TODO print available years in epilog
  )

  @add_arg_table! s begin
    "--year", "--years", "-y"
    help = "Year(s) to run puzzle(s) from, comma separated"
    arg_type = Int
    default = yearsavailable()
    nargs = '+'
    "--day", "--days", "-d"
    help = "Day(s) to run puzzles, for the given year(s), comma separated - if unspecified run all days of all years"
    default = []
    arg_type = Int
    nargs = '+'
    "--input", "-i"
    help = "When a single puzzle is selected, path to the input file to use"
    default = ""
    "--all"
    help = "Run all puzzles for all days and years"
  end

  return parse_args(s)
end

function main()
  parsed_args = parse_commandline()
  for iyear in parsed_args["year"]
    arg_days = parsed_args["day"]
    idays = length(arg_days) == 0 ? daysavailable(Val(iyear)) : arg_days
    p = Progress(length(idays); color=:blue)
    for iday in (length(arg_days) == 0 ? daysavailable(Val(iyear)) : arg_days)
      if parsed_args["input"] == ""
        user = Dict(2018 => "pbouffard", 2022 => "jbshannon")[iyear]
        inputfile = userpath(user, iday, iyear)
      else
        inputfile = parsed_args["input"]
      end

      print("\nSolving $iyear Day $iday for input $inputfile ...")
      @time (part1ans, part2ans) = solve_specific(iyear, iday, inputfile)
      println("Part 1: $part1ans")
      println("Part 2: $part2ans")
      next!(p)
    end
  end
end


main()
