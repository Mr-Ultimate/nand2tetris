Given(/^a file derived from project file "(.*?)"$/) do |path|
  file_name = path.split('/').last
  write_file file_name, File.read(File.join(@project_path, path))
end

Then(/^the assembled file "(.*?)" should be created$/) do |file|
  @output_file = file
  check_file_presence([@output_file], true)
end

Then(/^its content should match the project file "(.*?)"$/) do |path|
  check_exact_file_content @output_file, File.read(File.join(@project_path, path))
end
