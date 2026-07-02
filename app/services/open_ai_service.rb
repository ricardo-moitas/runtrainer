class OpenAiService
  def initialize(run, history)
    @run = run
    @history = history
  end

  def call
    client = RubyLLM::Client.new

    # 2. Construir o prompt com os dados
    prompt = <<~TEXT
      Tu és um treinador de corrida especializado.
      Analisa a seguinte corrida:
      Distância: #{@run.distance}km
      Data: #{@run.date}

      Histórico recente:
      #{@history.map { |r| "#{r.date}: #{r.distance}km" }.join("\n")}

      Dá um feedback motivador e técnico.
    TEXT

    # 3. Chamar a API
    response = client.generate(prompt: prompt)

    # 4. Devolver o texto da resposta
    response.dig(:choices, 0, :message, :content)
  end
end
