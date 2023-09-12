Config.config(:wallaby,
  js_errors: false,
  chromedriver: [
    headless: false,
    host_rules: "MAP * 127.0.0.1"
  ]
)
