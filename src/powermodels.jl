function branch_basekv(network_data::Dict{String, Any})
    basekv = Dict{String, Float64}()
    for branch_idx in keys(network_data["branch"])
        br = network_data["branch"][branch_idx]
        f, t = br["f_bus"], br["t_bus"]
        bf, bt = network_data["bus"][string(f)], network_data["bus"][string(t)]
        basekv[branch_idx] = max(bf["base_kv"], bt["base_kv"])
    end
    return basekv
end
