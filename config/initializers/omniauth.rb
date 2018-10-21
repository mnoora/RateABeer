Rails.application.config.middleware.use OmniAuth::Builder do
    provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
    #provider :github, "f299b817a92469db5639", "16f1ae3135f46355d35cacdb9e02f2c13c113ef1"
   end