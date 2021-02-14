

module Quarto

import JSON



function render(input::AbstractString;
                output_format::Union{Nothing,AbstractString} = nothing)

  # quarto binary
  quarto_bin = Quarto.path()
  if isnothing(quarto_bin) 
    throw(ErrorException("Unable to find quarto command line tools."))
  end

  # alias input for linter
  target = input

  # args array 
  args = []
  if !isnothing(output_format)
    push!(args, "--to")
    push!(args, output_format)
  end

  # run render
  cmd = `$quarto_bin render $target $args`
  run(cmd)

  # return 
  return nothing

end

function metadata(input::AbstractString)
  # quarto binary
  quarto_bin = Quarto.path()
  if isnothing(quarto_bin) 
    throw(ErrorException("Unable to find quarto command line tools."))
  end

  # alias input for linter
  target = input

  # run cmd and capture stdout
  cmd = `$quarto_bin metadata $target --json`
  out = Pipe()
  run(pipeline(cmd, stdout = out))
  close(out.in)
  stdout = String(read(out))

  # parse json
  return JSON.parse(stdout)
end

function path()
  if (haskey(ENV, "QUARTO_PATH"))
    return ENV["QUARTO_PATH"]
  else
    return Sys.which("quarto")
  end
end


end # module
