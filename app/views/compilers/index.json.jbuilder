json.array!(@compilers) do |compiler|
  json.extract! compiler, :id, :source_code
  json.url compiler_url(compiler, format: :json)
end
