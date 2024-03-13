# worter
<p class='center'>
An app that uses the OpenAI platform to make learning German words fun.
</p>

## Platform Support

| Android | iOS | Web |
|:-------:| :-: |:---:|
|  ✅     | ✅ |  ✅ |

## Features
- The initial screen of the app allows the user to provide a user name.
- Upon entering a user name, the user can then progress to the primary screen of the app.
- The primary screen will present a word for translation to English.  The user can then
- select from four English words, one of which is the correct translated English word.
- Three is also a button to present a hint at translation.  A total of three hints are allowed.
- In addition, the app tracks the number of correct translations and shows the number as a score.

## Usage
- To use this app, you will need an OpenAI api key.
- The key can be obtained here: https://platform.openai.com
- Upon obtaining a key, the key can then be used when running this app project
- by providing it as a runtime argument.
- --dart-define OPENAI_KEY=[Insert key here]
