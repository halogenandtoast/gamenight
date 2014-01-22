def fixture_file name
  File.read(Rails.root.join("spec", "fixtures", name))
end
