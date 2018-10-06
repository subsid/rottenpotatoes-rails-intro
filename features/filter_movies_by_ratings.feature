Feature: Filter movies by rating
 
  So that I can quickly browse movies

Background: movies have been added to database

  Given the following movies exist:
  | title                   | rating | release_date |
  | Aladdin                 | G      | 25-Nov-1992  |
  | The Terminator          | R      | 26-Oct-1984  |
  | The Help                | PG-13  | 10-Aug-2011  |
  | Chocolat                | PG-13  | 5-Jan-2001   |

  And  I am on the home page

Scenario: restrict to movies with 'G' or 'R' ratings
  When I check the following ratings: G, R
  And I uncheck the following ratings: PG-13
  And I press "Refresh"
  And I should see "The Terminator"
  And I should not see "Alladin"
  And I should not see "The Help"
  And I should not see "Chocolat"

Scenario: all ratings selected
  When I check the following ratings: R, G, PG-13
  And I press "Refresh"
  Then I should see all the movies
