Given(/^a file derived from project file "(.*?)"$/) do |path|
  file_name = path.split('/').last
  write_file file_name, File.read(File.join(@project_path, path))
end
