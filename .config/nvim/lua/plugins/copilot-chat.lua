return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    ---@module 'CopilotChat'
    ---@type CopilotChat.config
    opts = {
      model = "qwen2.5-coder:latest",
      providers = {
        ollama = {
          prepare_input = require("CopilotChat.config.providers").copilot.prepare_input,
          prepare_output = require("CopilotChat.config.providers").copilot.prepare_output,

          get_models = function(headers)
            local response, err = require("CopilotChat.utils").curl_get("http://localhost:11434/v1/models", {
              headers = headers,
              json_response = true,
            })

            if err then
              error(err)
            end

            return vim.tbl_map(function(model)
              return {
                id = model.id,
                name = model.id,
              }
            end, response.body.data)
          end,

          embed = function(inputs, headers)
            local response, err = require("CopilotChat.utils").curl_post("http://localhost:11434/v1/embeddings", {
              headers = headers,
              json_request = true,
              json_response = true,
              body = {
                input = inputs,
                model = "qwen2.5-coder",
              },
            })

            if err then
              error(err)
            end

            return response.body.data
          end,

          get_url = function()
            return "http://localhost:11434/v1/chat/completions"
          end,
        },
      },
    },
  },
}
