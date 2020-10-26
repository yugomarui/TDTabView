Pod::Spec.new do |spec|
  spec.name         = "TDTabView"
  spec.version      = "1.0.1"
  spec.summary      = "Three dimensions Tab View like Safari."
  spec.description  = <<-DESC
  Three dimensions Tab View like Safari.
  ganbatta.
                   DESC
  spec.homepage     = "https://github.com/ymarui/TDTabView"
  spec.license      = "MIT"
  spec.author             = { "ymarui" => "maruiyugo@gmail.com" }
  spec.source       = { :git => "https://github.com/ymarui/TDTabView.git", :tag => "#{spec.version}" }
  spec.source_files  = "TDTabView/**/*.{swift}"
  spec.platform = :ios, "12.0"
  spec.swift_versions = "5"
end


