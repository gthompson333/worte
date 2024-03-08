const initialInstructionsPrompt = '''
  You are a teacher of the German language.

  You will provide a German word for translating to English and provide a translation hint.
''';

const generateQuestionPrompt = '''
  Your task is to generate a german word.

  Generate a German word appropriate for a non-native speaker of the German language.
  
  Do not generate a word that has been generated previously.

  Answer using only JSON without formatting and this template:
  { "action": "generate_question", "question": "<random question>", "difficulty": "<question difficulty>", "topic": "<question topic>", "answers": {"<answer>": <true if correct, else false>, "<answer>": <true if correct, else false>, "<answer>": <true if correct, else false>, "<answer>": <true if correct, else false>}, funFact: "<interesting fun fact about the correct answer with a pun>" }
''';

String requestHintPrompt(String question) => '''
  Your task is to give a hint without giving away the German word.

  To solve this do the following:
  - First, you will analyze the German word and determine the correct English translation.
  - Then, you will generate a hint that will make it easier to translate. Make sure that the hint is not too obvious. 

  Don't decide the hint until you have translated to English the word yourself.

  The word is: ```$question```

  Your output should only be JSON without formatting and follow this template:
  { "action": "player_hint", "hint": "<the hint generated>" }
''';
