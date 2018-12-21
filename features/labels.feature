Feature: Container Labels


  Scenario: All easyengine containers are tagged
    Given I run "bin/ee site create labels.test"
    Then There should be 1 containers with labels
    """
    io.easyengine.site=labels.test
    """

  Scenario: Create wildcard SSL site
    When Create site config setting
    And I run '/bin/bash -c 'echo "127.0.0.1 a123.mbtest.gq" >> /etc/hosts''
    And I run 'bin/ee site create a123.mbtest.gq --type=wp --ssl=le --wildcard'
    Then After delay of 5 seconds
    Then STDOUT should return something like
      """
      Configuring project.
      """
