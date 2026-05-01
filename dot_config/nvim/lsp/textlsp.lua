return {
  enabled = false,
  filetypes = { "markdown" },
  settings = {
    textLSP = {
      analysers = {
        languagetool = {
          enabled = false,
          check_text = {
            on_open = true,
            on_save = true,
            on_change = false,
          },
        },
        ollama = {
          enabled = true,
          check_text = {
            on_open = false,
            on_save = true,
            on_change = false,
          },
          model = "phi3:3.8b-instruct", -- smaller but faster model
          -- model = "phi3:14b-instruct",  -- more accurate
          max_token = 50,
        },
        gramformer = {
          -- gramformer dependency needs to be installed manually
          enabled = false,
          gpu = false,
          check_text = {
            on_open = false,
            on_save = true,
            on_change = false,
          },
        },
        hf_checker = {
          enabled = false,
          gpu = false,
          quantize = 32,
          model = "pszemraj/flan-t5-large-grammar-synthesis",
          min_length = 40,
          check_text = {
            on_open = false,
            on_save = true,
            on_change = false,
          },
        },
        hf_instruction_checker = {
          enabled = false,
          gpu = false,
          quantize = 32,
          model = "grammarly/coedit-large",
          min_length = 40,
          check_text = {
            on_open = false,
            on_save = true,
            on_change = false,
          },
        },
        hf_completion = {
          enabled = false,
          gpu = false,
          quantize = 32,
          model = "bert-base-multilingual-cased",
          topk = 5,
        },
        openai = {
          enabled = false,
          api_key = "<MY_API_KEY>",
          -- url = '<CUSTOM_URL>'  -- optional to use an OpenAI-compatible server
          check_text = {
            on_open = false,
            on_save = false,
            on_change = false,
          },
          model = "gpt-3.5-turbo",
          max_token = 16,
        },
        grammarbot = {
          enabled = false,
          api_key = "<MY_API_KEY>",
          -- longer texts are split, this parameter sets the maximum number of splits per analysis
          input_max_requests = 1,
          check_text = {
            on_open = false,
            on_save = false,
            on_change = false,
          },
        },
      },
      documents = {
        -- the language of the documents, could be set to `auto` of `auto:<fallback>`
        -- to detect automatically, default: auto:en
        language = "auto:en",
        -- do not autodetect documents with fewer characters
        min_length_language_detect = 20,
        org = {
          org_todo_keywords = {
            "TODO",
            "IN_PROGRESS",
            "DONE",
          },
        },
        txt = {
          parse = true,
        },
      },
    },
  },
}
