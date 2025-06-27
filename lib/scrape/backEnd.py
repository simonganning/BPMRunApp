from flask import Flask, jsonify
from openai import OpenAI

app = Flask(__name__)
client = OpenAI(api_key="bajs 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")

@app.route('/', methods=['GET'])
def ask_how_are_you():
    completion = client.chat.completions.create(
        model="gpt-4o",
        messages=[{
            "role": "user",
            "content": "Provide BPM and Energy of a song in format BPM:<BPM> , Energy: <Energy>. NO TEXT AT ALL! (scale from 0-100) for song with spotify ID, 7iWWLbTuSYdncjX1tT22JJ. If you don't know, make a guess."
        }]
    )
    message = completion.choices[0].message.content.strip()

    try:
        # Example: "BPM: 95, Energy: 78"
        parts = message.split(',')
        bpm = int(parts[0].split(':')[1].strip())
        energy = int(parts[1].split(':')[1].strip())
        return jsonify({'bpm': bpm, 'energy': energy})
    except Exception as e:
        return jsonify({'error': 'Failed to parse response', 'raw': message}), 500
    
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001, debug=True)



'''
This mutherfucker works fine
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
'''