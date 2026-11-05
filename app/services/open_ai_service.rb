class OpenAiService
  def initialize(run, history, user_message)
    @run = run
    @history = history
    @user_message = user_message
  end

  def call

    system_instructions = <<~TEXT
      You are an experienced and empathetic running coach.
      Your goal is to analyze the user's runs and provide technical feedback.

      CRITICAL LANGUAGE RULE: Always respond in the SAME LANGUAGE as the user's last message.
      - If Portuguese: You MUST use exclusively European Portuguese (pt-PT).
        - Avoid Brazilian Portuguese expressions (e.g., avoid "legal", "bacana", or excessive gerunds like "estou correndo").
        - Use correct technical terminology: "Cadência", "Frequência Cardíaca", "Ritmo", "Elevação".
      - If English: Use standard technical terminology: "Cadence", "Heart Rate", "Pace", "Elevation".

      Tone: Natural, motivating, and conversational.
      AVOID: Complex tables, long lists, or a robotic/statistical tone.
      FOCUS: On how the user feels and what they can practically improve.

      Run Data:
      Date: #{@run.date}
      Distance: #{@run.distance}km
      #{formatted_metrics}

      Recent History:
      #{formatted_history}

      Be concise and direct. Talk like a training partner.
    TEXT

    chat = RubyLLM::Chat.new(model: "gpt-4o-mini")

    full_prompt = "#{system_instructions}\n\nUser Question: #{@user_message}"

    response = chat.ask(full_prompt)

    response.respond_to?(:content) ? response.content : response
  end

  private

  def formatted_history
    @history.select { |r| r.is_a?(Run) }.map { |r| "#{r.date}: #{r.distance}km" }.join("\n")
  end

  def formatted_metrics
    metrics = []

    metrics << "Date: #{@run.date}"
    metrics << "Distance: #{@run.distance}km"

    metrics << "Cadence: #{@run.cadence} spm" if @run.cadence.present?
    metrics << "Heart Rate: #{@run.heart_rate} bpm" if @run.heart_rate.present?
    metrics << "Elevation: #{@run.elevation}m" if @run.elevation.present?
    metrics.join("\n")
  end
end
