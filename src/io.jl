using StringViews

struct EachByte{IOT<:IO}
  stream::IOT
  ondone::Function
  EachByte(stream::IO=stdin; ondone::Function=()->nothing) = new{typeof(stream)}(stream, ondone)
end

"""
    eachbyte(io::IO=stdin)
    eachbyte(filename::AbstractString)

Create an iterable `EachByte` object that will yield each byte from an I/O stream or a file.
Iteration calls [`read`](@ref) on the stream argument repeatedly. When called with a file name,
the file is opened once at the beginning of iteration and closed at the end. If iteration is
interrupted, the file will be closed when the `EachByte` object is garbage collected.

# Examples
```jldoctest
julia> open("my_file.txt", "w") do io
  write(io, "\0\1\2\3\4");
end;

julia> for byte in eachbyte("my_file.txt")
@show byte
end
byte = 0x00
byte = 0x01
byte = 0x02
byte = 0x03
byte = 0x04

julia> rm("my_file.txt");
````
"""
function eachbyte(stream::IO=stdin)
  EachByte(stream)::EachByte
end

function eachbyte(filename::AbstractString)
  bs = open(filename)
  EachByte(bs, ondone=()->close(bs))::EachByte
end

function Base.iterate(itr::EachByte, state=nothing)
  eof(itr.stream) && return (itr.ondone(); nothing)
  (read(itr.stream, UInt8)::UInt8, nothing)
end

eltype(::Type{<:EachByte}) = UInt8

Base.IteratorSize(::Type{<:EachByte}) = Base.SizeUnknown()

isdone(itr::EachByte, state...) = eof(itr.stream)


struct EachInt{IOT<:IO}
  stream::IOT
  ondone::Function
  EachInt(stream::IO=stdin; ondone::Function=()->nothing) = new{typeof(stream)}(stream, ondone)
end

"""
    eachint(io::IO=stdin)
    eachint(filename::AbstractString)

Create an iterable `eachint` object that will yield integers from an I/O stream or a file containing
space-separated integers. Iteration calls [`read`](@ref) on the stream argument repeatedly. When
called with a file name, the file is opened once at the beginning of iteration and closed at the
end. If iteration is interrupted, the file will be closed when the `EachInt` object is garbage
collected.

# Examples
```jldoctest
julia> open("my_file.txt", "w") do io
  write(io, "0 1 2 3 4");
end;

julia> for int in eachint("my_file.txt")
@show int
end
int = 0
int = 1
int = 2
int = 3
int = 4

julia> rm("my_file.txt");
````
"""
function eachint(stream::IO=stdin)
  EachInt(stream)::EachInt
end

function eachint(filename::AbstractString)
  bs = open(filename)
  EachInt(bs, ondone=()->close(bs))::EachInt
end

const _whitespace = ['\n', '\r', '\t', ' '] .|> UInt8
function Base.iterate(itr::EachInt, state=nothing)
  function intresult()
    sv = StringView(intchars)
    (parse(Int, sv), nothing)
  end

  intchars = Vector{UInt8}()
  while true
    if eof(itr.stream)
      if !isempty(intchars)
        return intresult()
      else
        return (itr.ondone(); nothing)
      end
    end

    c = read(itr.stream, UInt8)::UInt8
    if c in _whitespace
      if !isempty(intchars)
        return intresult()
      else
        continue
      end
    end
    
    push!(intchars, c)
  end
end

eltype(::Type{<:EachInt}) = Int

Base.IteratorSize(::Type{<:EachInt}) = Base.SizeUnknown()

isdone(itr::EachInt, state...) = eof(itr.stream)