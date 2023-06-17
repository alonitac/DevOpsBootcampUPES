# CI/CD with Jenkins

## Pull Request testing

It's common practice to perform an extensive testing on a Pull Request before the code is being deployed to production systems.
So far we've seen how pipeline can be built and run around a single Git branch (e.g. `main` or `dev`). Now we would like to create a new pipeline which will be triggered on **every PR that is created in GitHub**.
For that we will utilize Jenkins [multi-branch pipeline](https://www.jenkins.io/doc/book/pipeline/multibranch/).

1. From the main Jenkins dashboard page, choose **New Item**, and create a **Multibranch Pipeline** named `PR-testing`.
2. In the **GitHub** source section, under **Discover branches** configure this pipeline to discover PRs only!
3. This pipeline should be defined by a Jenkinsfile called `PullRequest.Jenkinsfile`.
4. In `main` branch, create the `PullRequest.Jenkinsfile` as follows:
```text
pipeline {
    agent any

    stages {
        stage('Unittest') {
            steps {
                echo "testing"
            }
        }
        stage('Lint') {
            steps {
                echo "linting"
            }
        }
        stage('Functional test') {
            steps {
                echo "testing"
            }
        }
    }
}
```

5. Commit the Jenkinsfile and push it.

From now one, we would like to protect branch `main` from being merged by non-tested and reviewed branch.

7. From GitHub main repo page, go to **Settings**, then **Branches**.
8. **Add rule** for the `main` branch as follows:
   1. Check **Require a pull request before merging**.
   2. Check **Require status checks to pass before merging** and search the `continuous-integration/jenkins/branch` check done by Jenkins.
   3. Save the protection rule.

Your `main` branch is now protected and no code can be merged to it unless the PR is reviewed by other team member and passed all automatic tests done by Jenkins.

Let's implement the pull request testing pipeline. 

9. From branch `main` create a new branch called `sample_feature` which simulates some new feature that a developer is going to develop. Push the branch to remote. 
10. In your app GitHub page, create a Pull Request from `sample_feature` into `main`.
11. Watch the triggered pipeline in Jenkins. 

### Run unittests

1. In the **updated** app directory (`14_yolo5_app`), you are given directory called `tests`. This is a common name for the directory containing all unittests files. The directory contains a file called `test_allowed_file.py` which implements unittest for the `allowed_file` function in `app.py` file. 

2. Run the unittest locally (you may need to install the following requirements: `pytest`), check that all tests are passed:
```shell
python3 -m pytest --junitxml results.xml tests
```

3. Integrate the unittesting in `PullRequest.Jenkinsfile` under the **Unittest** stage.

4. You can add the following `post` step to display the tests results in the readable form:
```text
post {
    always {
        junit allowEmptyResults: true, testResults: 'results.xml'
    }
}
```
5. Make sure Jenkins is blocking the PR to be merged when unittest is failed!

### Run linting check

[Pylint](https://pylint.pycqa.org/en/latest/) is a static code analyser for Python.
Pylint analyses your code without actually running it. It checks for errors, enforces a coding standard, and can make suggestions about how the code could be refactored.

1. Install `pylint` locally if needed.
2. Generate a default template for `.pylintrc` file which is a configuration file defines how Pylint should behave
```shell
pylint --generate-rcfile > .pylintrc
```

3. Lint your code locally by:
```shell
python3 -m pylint *.py
```

How many warnings do you get? If you need to ignore some unuseful warning, add it to `disable` list in `[MESSAGES CONTROL]` section in your `.pylintrc` file.

4. Integrate the unittesting in `PullRequest.Jenkinsfile` under the **Lint** stage.
5. (Bonus) Add Pylint reports to Jenkins pipeline dashboard:
   1. Install the [Warnings Next Generation Plugin](https://www.jenkins.io/doc/pipeline/steps/warnings-ng/).
   2. Change your linting stage to be something like (make sure you understand this change):
   ```text
   steps {
     sh 'python3 -m pylint -f parseable --reports=no *.py > pylint.log'
   }
   post {
     always {
       sh 'cat pylint.log'
       recordIssues (
         enabledForFailure: true,
         aggregatingResults: true,
         tools: [pyLint(name: 'Pylint', pattern: '**/pylint.log')]
       )
     }
   }
   ```


[comment]: <> (### &#40;optional&#41; Run integration tests)

[comment]: <> (`curl -X POST -H "Content-Type: multipart/form-data" -F "file=@11.png" localhost:8081/api`)

### Run tests in parallel 

Use [`parallel`](https://www.jenkins.io/doc/book/pipeline/syntax/#parallel) directive to run the test stages in parallel, while failing the whole build when one of the stages is failed.


