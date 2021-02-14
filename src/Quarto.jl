

module Quarto

import JSON



function render(input::AbstractString;
                output_format::Union{Nothing,AbstractString} = nothing,
                output_file::Union{Nothing,AbstractString} = nothing,
                execute::Bool = true,
                execute_dir::Union{Nothing,AbstractString} = nothing,
                cache::Union{Nothing,Bool} = nothing,
                cache_refresh::Bool = false,
                kernel_keepalive::Union{Nothing,Int} = nothing,
                kernel_restart::Bool = false,
                debug::Bool = false,
                quiet::Bool = false,
                pandoc_args::Union{Nothing,Array{String}} = nothing)

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
  if !isnothing(output_file)
    push!(args, "--output")
    push!(args, output_file)
  end
  if execute 
    push!(args, "--execute")
  end
  # TODO: execute params
  if !isnothing(execute_dir)
    push!(args, "--execute-dir")
    push!(args, execute_dir)
  end
  if !isnothing(cache)
    if cache
      push!(args, "--cache")
    else
      push!(args, "--no-cache")
    end
  end
  if cache_refresh
    push!(args, "--cache-refresh")
  end
  if !isnothing(kernel_keepalive)
    push!(args, "--kernel-keepalive")
    push!(args, string(kernel_keepalive))
  end
  if kernel_restart
    push!(args, "--kernel-restart")
  end
  if debug 
    push!(args, "--debug")
  end
  if quiet 
    push!(args, "--quiet")
  end
  if !isnothing(pandoc_args)
    args = cat(args, pandoc_args, dims = 1)
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
