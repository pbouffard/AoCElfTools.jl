
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


