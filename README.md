# Zafira ruby RSpec integration using Jenkins

An example of using gem `zafira-ruby` https://github.com/qaprosoft/zafira-ruby

## How to

### Using Qaprosoft infrastructure https://github.com/qaprosoft/qps-infra

Please read how to setup qps-infra https://github.com/qaprosoft/qps-infra

Then create a freestyle project.
Following settings should be set before run:
- Source Code Management
  - Git
    - Repository URL. It's a rspec tests repository. Currently we use `https://github.com/qaprosoft/zafira-ruby-rspec-integration`.
    - Branch Specifier (blank for 'any'). A branch. Currently we use `master`.
  - Build
    - Add execute shell. We use script below:
    ```bash
    # here we install bundle
    gem install bundler
    # install all dependencies from Gemfile
    bundle install
    # start run
    # Please look https://github.com/qaprosoft/zafira-ruby#possible-environment-and-config-variables
    # for another possible variables
    ZAFIRA_ENV_TEST_SUITE_CONFIG_FILE=./test_suite_config.yml \
    ZAFIRA_ENV_CI_RUN_BUILD_NUMBER=${BUILD_NUMBER} \
    ZAFIRA_ENV_CI_JOB_URL=$BUILD_URL \
    ZAFIRA_ENV_CI_HOST=\"$JENKINS_URL\" \
    ZAFIRA_ENV_CI_JOB_NAME=\"$JOB_NAME\" \
    ZAFIRA_ENV_CI_TEST_RUN_UUID=\"$(uuidgen)\" \
    bundle exec rspec spec/ -f Zafira::Rspec::Formatter -f doc
    ```

Then you can start run :).

### Using usual Jenkins and Zafira instances

First you have to setup your Jenkins.

Following plugins should be installed for proper run:
- Rvm
- Rake Plugin

Then create a freestyle project.
Following settings should be set before run:
- Source Code Management
  - Git
    - Repository URL. It's a rspec tests repository. Currently we use `https://github.com/qaprosoft/zafira-ruby-rspec-integration`.
    - Branch Specifier (blank for 'any'). A branch. Currently we use `master`.
  - Build Environment
    - Run the build in a RVM-managed environment. Should be checked. We use `2.4.0`.
  - Build
    - Add execute shell. We use script below:
    ```bash
    # here we install bundle
    gem install bundler
    # install all dependencies from Gemfile
    bundle install
    # start run
    # Please look https://github.com/qaprosoft/zafira-ruby#possible-environment-and-config-variables
    # for another possible variables
    ZAFIRA_ENV_TEST_SUITE_CONFIG_FILE=./test_suite_config.yml \
    ZAFIRA_ENV_CI_RUN_BUILD_NUMBER=${BUILD_NUMBER} \
    ZAFIRA_ENV_CI_JOB_URL=$BUILD_URL \
    ZAFIRA_ENV_CI_HOST=\"$JENKINS_URL\" \
    ZAFIRA_ENV_CI_JOB_NAME=\"$JOB_NAME\" \
    ZAFIRA_ENV_CI_TEST_RUN_UUID=\"$(uuidgen)\" \
    bundle exec rspec spec/ -f Zafira::Rspec::Formatter -f doc
    ```

Then you can start run :).

## Examples

For the example we implemented 3 test cases.
```ruby
describe "Zafira integration Spec" do
  describe "zafira enabled" do
    context "example failed" do
      it { expect(1).to eq(2) }
    end

    context "example passed" do
      it { expect(1).to eq(1) }
    end

    context "example skipped" do
      xit { expect(1).to eq(1) }
    end
  end
end
```

1 test case should pass, 1 should fail, 1 should be skipped.
If you open Zafira you see following:
![screenshot from 2018-04-08 22-43-16](https://user-images.githubusercontent.com/3288759/38471751-42b96316-3b7e-11e8-8ca4-3d7af6b9d5b5.png)


## Custom handlers

Note: Here in the example we don't any custom handlers for test cases in Zafira.
By default `zafira-ruby` sends backtrace for failed tests only.

For example you want to send screenshots for your capybara tests. You can easily write your own handlers. Please, read https://github.com/qaprosoft/zafira-ruby#zafira-logging-overrides how to do it.

You also can check how we added a custom handler for cucumber example:
https://github.com/qaprosoft/zafira-ruby-cucumber-integration
