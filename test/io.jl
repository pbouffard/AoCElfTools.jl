@testset "eachbyte" begin
  @testset "IO" begin
    io = IOBuffer(Vector{UInt8}(1:10))
    eb = eachbyte(io)
    @test !AoCElfTools.isdone(eb)
    for (i, b) in enumerate(eb)
      @test i == b
    end
    @test AoCElfTools.isdone(eb)
  end

  @testset "file" begin
    (path, io) = mktemp(; cleanup=false)
    write(path, Vector{UInt8}(1:10))
    close(io)
    eb = eachbyte(path)
    @test !AoCElfTools.isdone(eb)
    for (i, b) in enumerate(eb)
      @test i == b
    end
    @test AoCElfTools.isdone(eb)
    rm(path)
  end
end

@testset "eachint" begin
  @testset "IO" begin
    io = IOBuffer(ascii("1 2 3 4 5 6 7 8 9 10"))
    eb = eachint(io)
    @test !AoCElfTools.isdone(eb)
    for (i, ii) in enumerate(eb)
      @test i == ii
    end
    @test AoCElfTools.isdone(eb)
  end

  @testset "file" begin
    (path, io) = mktemp(; cleanup=false)
    write(path, ascii("1 2 3 4 5 6 7 8 9 10"))
    close(io)
    eb = eachint(path)
    @test !AoCElfTools.isdone(eb)
    for (i, ii) in enumerate(eb)
      @test i == ii
    end
    @test AoCElfTools.isdone(eb)
    rm(path)
  end
end


onetoten = ascii("1 2 3 4 5 6 7 8 9 10")
onetotennewlines = ascii("1 2 3 4\n5 6 7 8\n9 10")
onetotenint = 1:10

negatives = ascii("1 -2 3 4 5 6 -7 8 -9 10")
negativesnewlines = ascii("1 -2 3 4\n5 6 -7 8\n-9 10")
negativesint = [1, -2, 3, 4, 5, 6, -7, 8, -9, 10]

@testset "eachint" begin
  for (desc, str, int) in [
    ("no newlines", onetoten, onetotenint),
    ("newlines", onetotennewlines, onetotenint),
    ("no newlines, negatives", negatives, negativesint),
    ("newlines, negatives", negativesnewlines, negativesint),
  ]

    @testset "EOF" begin
      for (desc, eolstr) in [
        ("no EOL @ EOF", ""),
        ("no whitespace after last line", ""),
        ("whitespace after last line", "\n"),
        ("whitespace after last line, windows", "\r\n"),
      ]

        (path, io) = mktemp(; cleanup=false)
        write(path, str * eolstr)
        close(io)
        iob = IOBuffer(str)

        @testset "IO" begin
          eb = eachint(iob)
          @test !AoCElfTools.isdone(eb)
          for (i, ii) in enumerate(eb)
            @test int[i] == ii
          end
          @test AoCElfTools.isdone(eb)
        end

        @testset "file" begin
          eb = eachint(path)
          @test !AoCElfTools.isdone(eb)
          for (i, ii) in enumerate(eb)
            @test int[i] == ii
          end
          @test AoCElfTools.isdone(eb)
        end

        rm(path)
      end
    end

  end

end