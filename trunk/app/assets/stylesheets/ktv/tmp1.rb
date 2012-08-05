File.open("./__dz.css.scss.erb") do |f|
  while line=f.gets
    puts line.gsub(/url\(['"]*([^'"()]*)['"]*\)/, "url(<%=asset_path('\\1')%>)")
  end
end
