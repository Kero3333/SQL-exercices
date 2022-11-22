/* get the report*/
SELECT * FROM crime_scene_report WHERE type='murder' AND date='20180115' AND city='SQL City'; 

/*
    result

    Security footage shows that there were 2 witnesses. 
    The first witness lives at the last house on "Northwestern Dr". 
    The second witness, named Annabel, lives somewhere on "Franklin Ave". 
*/


/* get informations about the 2 witnesses */
SELECT * FROM person 
WHERE name LIKE '%Annabel%' AND address_street_name='Franklin Ave'
UNION 
(SELECT * FROM person
WHERE address_street_name='Northwestern Dr' 
ORDER BY address_number DESC 
LIMIT 1);

/*
    result

  id   |      name      | license_id | address_number | address_street_name |    ssn    
-------+----------------+------------+----------------+---------------------+-----------
 14887 | Morty Schapiro |     118009 |           4919 | Northwestern Dr     | 111564949
 16371 | Annabel Miller |     490173 |            103 | Franklin Ave        | 318771143

*/

/* get their interviews*/
SELECT p.name, fec.event_name, i.transcript FROM person AS p 
INNER JOIN facebook_event_checkin AS fec ON p.id=fec.person_id 
INNER JOIN interview AS i ON p.id=i.person_id 
WHERE name LIKE '%Annabel%' AND address_street_name='Franklin Ave'
UNION 
(SELECT p.name, fec.event_name, i.transcript FROM person AS p 
INNER JOIN facebook_event_checkin AS fec ON p.id=fec.person_id
INNER JOIN interview AS i ON p.id=i.person_id 
WHERE address_street_name='Northwestern Dr' 
ORDER BY address_number DESC 
LIMIT 1);

/*
    result

Annabel Miller | The Funky Grooves Tour | I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th.

Morty Schapiro | The Funky Grooves Tour | I heard a gunshot and then saw a man run out. 
He had a "Get Fit Now Gym" bag. The membership number on the bag started with "48Z". 
Only gold members have those bags. The man got into a car with a plate that included "H42W".
*/

/* find the culprit with informations gived by the two interviews*/
SELECT p.id, p.name, dl.gender, dl.plate_number, g1.id, g2.check_in_date FROM person AS p 
INNER JOIN drivers_license AS dl ON p.license_id=dl.id 
INNER JOIN get_fit_now_member AS g1 ON p.id=g1.person_id 
INNER JOIN get_fit_now_check_in AS g2 ON g1.id=g2.membership_id 
WHERE dl.plate_number LIKE '%H42W%' 
AND g1.id LIKE '%48Z%' 
AND g1.membership_status='gold' 
AND dl.gender='male' 
AND g2.check_in_date='20180109';

/*
    result

  id   |     name      | gender | plate_number |  id   | check_in_date 
-------+---------------+--------+--------------+-------+---------------
 67318 | Jeremy Bowers | male   | 0H42W2       | 48Z55 |      20180109

*/

/* to validate */
INSERT INTO solution (value) VALUES ('Jeremy Bowers');
/*
    result

    NOTICE:  Congrats, you found the murderer! But wait, there's more... 
    If you think you're up for a challenge, try querying the interview transcript of the murderer to find the real villian behind this crime. 
    If you feel especially confident in your SQL skills, try to complete this final step with no more than 2 queries.
*/

SELECT * FROM interview WHERE person_id=67318;

/*
 the interview of the culprit 

I was hired by a woman with a lot of money.
I don't know her name but I know she's around 5'5" (65") or 5'7" (67"). 
She has red hair and she drives a Tesla Model S. 
I know that she attended the SQL Symphony Concert 3 times in December 2017

*/

/* to find the 'real' culprit */
SELECT p.id, p.name, COUNT(p.name) FROM person AS p 
INNER JOIN drivers_license AS dl ON p.license_id=dl.id 
INNER JOIN facebook_event_checkin AS f ON p.id=f.person_id 
WHERE dl.car_make='Tesla' 
AND dl.car_model='Model S' 
AND dl.gender='female' 
AND dl.hair_color='red'
AND f.date<20180101 AND f.date>=20171201 
AND f.event_name='SQL Symphony Concert'
GROUP BY p.id;

/*
    result

  id   |       name       | count 
-------+------------------+-------
 99716 | Miranda Priestly |     3

*/

/* to validate */
INSERT INTO solution (value) VALUES ('Miranda Priestly');

/*
    result
    
    NOTICE:  Congrats, you found the brains behind the murder! 
    Everyone in SQL City hails you as the greatest SQL detective of all time. Time to break out the champagne!

*/