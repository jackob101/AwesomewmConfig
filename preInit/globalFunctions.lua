function load(path_to_folder, file_name)
    require(path_to_folder .. "." .. file_name)
end

function load_all(path_to_folder, file_names)
    for i, v in ipairs(file_names) do
        load(path_to_folder, v)
    end
end
