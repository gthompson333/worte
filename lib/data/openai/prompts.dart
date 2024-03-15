const initialInstructionsPrompt = '''
  You are a teacher of the German language.

  You will provide a word in the German language for translating to English and provide a translation hint.
''';

const generateWordPrompt = '''
  Your task is to generate a word in the German language.

  Generate a random word appropriate for a non-native speaker of the German language.
  
  The same word should not be generated more than once.

  Answer using only JSON without formatting and this template:
  {"action": "generate_word", "word": "<word>", "translations": {"<translation>": <true if correct, else false>, "<translation>": <true if correct, else false>, "<translation>": <true if correct, else false>, "<translation": <true if correct, else false>}"}
''';

String requestHintPrompt(String word) => '''
  Your task is to give a hint without giving away the German word.

  To solve this do the following:
  - First, you will analyze the German word and determine the correct English translation.
  - Then, you will generate a hint that will make it easier to translate. Make sure that the hint is not too obvious. 

  Don't decide the hint until you have translated to English the word yourself.

  The word is: ```$word```

  Your output should only be JSON without formatting and follow this template:
  {"action": "generate_hint", "hint": "<hint>"}
''';
