Feature: Site Redirection

  Scenario: no_www-no_ssl redirection works properly
    When I run '/bin/bash -c 'echo "127.0.0.1 www.example.test" >> /etc/hosts''
    And I run 'bin/ee site create example.test'
    Then After delay of 5 seconds
    Then Request on 'localhost' with header 'Host: www.example.test' should contain following headers:
    | header                         |
    | HTTP/1.1 301 Moved Permanently |
    | Location: http://example.test/ |

  Scenario: www-no_ssl redirection works properly
    When I run '/bin/bash -c 'echo "127.0.0.1 example1.test" >> /etc/hosts''
    And I run 'bin/ee site create www.example1.test'
    Then After delay of 5 seconds
    Then Request on 'localhost' with header 'Host: example1.test' should contain following headers:
    | header                              |
    | HTTP/1.1 301 Moved Permanently      |
    | Location: http://www.example1.test/ |

  @self
  Scenario: no_www-ssl redirection works properly
    When I run 'bin/ee site create example2.test --ssl=self'
    Then After delay of 2 seconds
    Then Request on 'localhost' with header 'Host: www.example2.test' should contain following headers:
      | header                           |
      | HTTP/1.1 301 Moved Permanently   |
      | Location: https://example2.test/ |
    And Request on 'https://www.example2.test' with resolve option 'www.example2.test:443:127.0.0.1' should contain following headers:
      | header                           |
      | HTTP/2 301                       |
      | location: https://example2.test/ |
    And Request on 'example2.test' should contain following headers:
      | header                           |
      | HTTP/1.1 301 Moved Permanently   |
      | Location: https://example2.test/ |
    And Verify self signed certificate for 'example2.test'

  @self
  Scenario: www-ssl redirection works properly
    When I run 'bin/ee site create www.example3.test --ssl=self'
    Then After delay of 2 seconds
    Then Request on 'localhost' with header 'Host: example3.test' should contain following headers:
      | header                               |
      | HTTP/1.1 301 Moved Permanently       |
      | Location: https://www.example3.test/ |
    And Request on 'https://example3.test/' with resolve option 'example3.test:443:127.0.0.1' should contain following headers:
      | header                               |
      | HTTP/2 301                           |
      | location: https://www.example3.test/ |
    And Request on 'www.example3.test' should contain following headers:
      | header                               |
      | HTTP/1.1 301 Moved Permanently       |
      | Location: https://www.example3.test/ |
    And Verify self signed certificate for 'www.example3.test'
