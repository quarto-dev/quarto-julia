

module Quarto

import JSON

function render(input::AbstractString)

  # quarto binary
  quarto_bin = find_quarto()

  # alias input for linter
  target = input

  # run render
  cmd = `$quarto_bin render $target`
  run(cmd)

  # return 
  return nothing

end

function metadata(input::AbstractString)
  # quarto binary
  quarto_bin = find_quarto()

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

function find_quarto()
  path = Quarto.path()
  if isnothing(path)
    throw(ErrorException("Unable to find quarto command line tools."))
  else
    return path
  end
end