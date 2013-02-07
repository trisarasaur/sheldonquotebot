require 'yaml'


quotes = YAML.load_file 'SheldonQuote_quotes.yaml'




puts quotes.sample