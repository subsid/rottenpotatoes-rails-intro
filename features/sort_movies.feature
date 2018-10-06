Feature: List movies sorted by title or release data

  I want to see movies sorted by title or release date

Background: Add movies to databsae

  Given the following movies exist:
  | title                   | rating | release_date |
  | Aladdin                 | G      | 25-Nov-1992  |
  | The Terminator          | R      | 26-Oct-1984  |
  | Raiders of the Lost Ark | PG     | 12-Jun-1981  |
  | Chicken Run             | G      | 21-Jun-2000  |

  And I am on the home page

Scenario: sort movies alphabetically
  When I follow "Movie Title"
  Then I should see "Aladdin" before "The Terminator"
  Then I should see "Aladdin" before "Raiders of the Lost Ark"

Scenario: sort movies in increasing order of release date
  When I follow "Release Date"
  Then I should see "The Terminator" before "Aladdin"
  Then I should see "Aladdin" before "Chicken Run"
  Then I should see "Raiders of the Lost Ark" before "Aladdin"

