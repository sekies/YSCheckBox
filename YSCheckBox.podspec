Pod::Spec.new do |spec|

  spec.name         = "YSCheckBox"
  spec.version      = "0.0.1"
  spec.summary      = "YSCheckBox."
  spec.description  = <<-DESC
                        - Normal CheckBox.
                   DESC

  spec.homepage     = "https://github.com/sekies/YSCheckBox"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Yosuke Seki" => "y.sekies@gmail.com" }
  spec.platform     = :ios, "8.0"
  spec.source       = { :git => "https://github.com/sekies/YSCheckBox.git", :tag => "#{spec.version}" }
  spec.source_files  = "YSCheckBox/**/*.swift"
  spec.swift_versions = "5"
end
