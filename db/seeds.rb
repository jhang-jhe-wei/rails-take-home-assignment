# frozen_string_literal: true

User.find_or_create_by(name: '王小明')
User.find_or_create_by(name: 'Eric')
User.find_or_create_by(name: 'Apple')
Stock.create_with(name: "台積電").find_or_create_by(code: "2330")
Stock.create_with(name: "聯發科").find_or_create_by(code: "2454")
Stock.create_with(name: "鴻海").find_or_create_by(code: "2317")
Stock.create_with(name: "聯電").find_or_create_by(code: "2303")
Stock.create_with(name: "台達電").find_or_create_by(code: "2308")
Stock.create_with(name: "富邦金").find_or_create_by(code: "2881")
Stock.create_with(name: "國泰金").find_or_create_by(code: "2882")
