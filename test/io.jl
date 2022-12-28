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