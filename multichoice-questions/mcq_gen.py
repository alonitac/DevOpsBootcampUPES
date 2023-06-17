from collections import defaultdict, OrderedDict
import json
import markdown
import glob
import re

# pip install Markdown

title_re = r"<h1>(.*?)</h1>"

with open('.sol.json') as s:
    sol = json.load(s)


def generate(file):
    with open(file) as f:
        md = f.read()

    # Convert Markdown to HTML with checkboxes
    html = markdown.markdown(md, extensions=['fenced_code'], output_format='html5')

    match = re.search(title_re, html)

    if match:
        # Extract content between <h1> tags
        title = match.group(1)
    else:
        title = 'Multichoice questions'


    html = '''
    
    <!DOCTYPE html>
    <html>
    <head>
        <title>
    ''' + title + '''
    </title>
        <meta name="viewport" content="width=device-width, initial-scale=1" xmlns="http://www.w3.org/1999/html">
        <script src="https://polyfill.io/v3/polyfill.min.js?features=TextEncoder%2Ccrypto.subtle"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
        <link rel="stylesheet" href="github-markdown-css.css">
        <style>
            .markdown-body {
                box-sizing: border-box;
                min-width: 200px;
                max-width: 980px;
                margin: 0 auto;
                padding: 45px;
            }
    
            @media (max-width: 767px) {
                .markdown-body {
                    padding: 15px;
                }
            }
            
            .floating-button {
              position: fixed;
              bottom: 20px; /* Adjust the distance from the bottom as needed */
              right: 20px; /* Adjust the distance from the right as needed */
              z-index: 9999; /* Ensure the button appears above other elements */
            }
        </style>
        <script>
            const solutions = ''' + json.dumps(sol[file]) + '''
        </script>
    </head>
    <body>
    
    <article class="markdown-body">  
    
    ''' + html.replace('[ ]', '<input type="checkbox">').replace('<ul>', '<ul style="list-style-type: none;">') + ''' 
    
        <script>
    
            function test(){
                const studentSolution = {};
    
                $('ul').each(function (index) {
                    if ($(this).find('input[type="checkbox"]').length > 0) {
                      var ulElement = $(this);
                      var qNum = ($('ul').index(ulElement) + 1) + '';

                      var answerToken = '' + qNum;
                      ulElement.find('li').each(function () {
                        var isChecked = $(this).find('input').prop('checked');
                        answerToken += isChecked ? '1' : '0';

                      });
                      console.log(answerToken);

                      var hashPromise  = crypto.subtle.digest('SHA-256', new TextEncoder().encode(answerToken))
                        .then((hashBuffer) => {
                          var hashArray = Array.from(new Uint8Array(hashBuffer));
                          var hashHex = hashArray.map(b => ('00' + b.toString(16)).slice(-2)).join('');
                          return hashHex;
                        });
    
                      studentSolution[qNum] = hashPromise;
    
                    }
                });
    
                Promise.allSettled(Object.values(studentSolution))
                  .then(function (results) {
                    results.forEach(function (result, i) {
                       studentSolution[(i + 1) + ''] = result.value;
                    });
                }).then(function () {

                    console.log(studentSolution)

                    for (const i in studentSolution) {
                      console.log('student solution' + studentSolution[i]);
                      if (solutions[i] === studentSolution[i]) {
                        $("h2:contains('Question " + i + "'):first").css('color', 'green');
                      } else {
                        $("h2:contains('Question " + i + "'):first").css('color', 'red');
                      }
                    }
                });
            }
    
        </script>
    
        <input type="button" class="floating-button" value="Test" onclick="test()">
    
    </article>
    </body>
    </html>
    
    '''

    with open(file.split('.')[0] + '.html', 'w') as f:
        f.write(html)

    return title


if __name__ == '__main__':
    for file in sorted(glob.glob("*.md")):
        unit = file.split('_')[0]
        title = generate(file)

