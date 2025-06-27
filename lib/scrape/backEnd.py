from flask import Flask, jsonify
from openai import OpenAI

app = Flask(__name__)
client = OpenAI(api_key="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")

@app.route('/', methods=['GET'])
def ask_how_are_you():
    completion = client.chat.completions.create(
        model="gpt-4o",
        messages=[{"role": "user", "content": "Provide a prompt with the BPM and Energy as <BPM>, <Energy>. eg (104, 140). NO TEXT AT ALL! (scale from 0-100) for song with spotify ID, 7iWWLbTuSYdncjX1tT22JJ. If you dont know the BMP or energy, make a guess"}]
    )
    reply = completion.choices[0].message.content.strip()
    return jsonify({'response': reply})

if __name__ == '__main__':
    app.run(debug=True)
