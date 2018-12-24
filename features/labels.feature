Feature: Container Labels


  Scenario: All easyengine containers are tagged
    Given I run "bin/ee site create labels.test"
    Then There should be 1 containers with labels
    """
    io.easyengine.site=labels.test
    """

  Scenario: Create wildcard ssl site without cloudflare api key
    When Create SSL wildcard site without API key

  Scenario: Add SSL configuration
    When Create site configuration

  Scenario: Create wildcard ssl site
    When Create SSL wildcard site
