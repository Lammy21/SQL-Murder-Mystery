/* OBJECTRIVE: Vaguely remember that the crime occurred on Jan. 15, 2018 in SQL city. Start by retrieving
the corresponding crime scene report from the police department's database*/

select * from crime_scene_report
where date = 20180115 and city = 'SQL City'

/*Security footage shows that there were 2 witnesses. The first witness lives at the last house on
"Northwestern Dr". The second witness, named Annabel, lives somewhere on "Franklin Ave".*/

/*Witness one lives at the last house*/

select * from person
where address_street_name = 'Northwestern Dr'
order by address_number desc

select address_street_name, max (address_number) from person
group by address_street_name
having address_street_name = 'Northwestern Dr'

select * from person where address_number = 4919 

select * from person 
where name like '%Annabel%'
and address_street_name = 'Franklin Ave'

/*The second witness' name is Annabel Miller, lives on 103, Franklin Ave, License_id 490173, 
ssn 318771143*/

select * from interview 
where person_id = 14887 or person_id = 16371

/*The 1st wistness is Morty Schapiro with id 14887, license_id 118009, address_number 4919, 
Northwestern Dr ssn 111564949*/

/*Witness one said - I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. 
The membership number on the bag started with "48Z". Only gold members have those bags. The man got into a 
car with a plate that included "H42W".*/

/*witness two said - I saw the murder happen, and I recognized the killer from my gym when I was working 
out last week on January the 9th.*/

select * from get_fit_now_member
where id like '%48Z%'
and membership_status = 'gold'

/* the first suspect is Joe Germuska with id 48Z7A, person_id 28819, membership_start_date 20160305
the second suspect is Jeremy Bowers with id 48Z55, person_id 67318, membership_start_date 20160101*/

select * from get_fit_now_check_in
where check_in_date = 20180109

select * from drivers_license 
where plate_number like '%H42W%'

select dl.age, dl.height, dl.hair_color, dl.gender, dl.plate_number, dl.car_make, dl.car_model,
p.name, p.ssn, p.address_street_name, p.id
from drivers_license as dl
left join person as p
on dl.id = p.license_id
where plate_number like '%H42W%'

/*Jeremy Bowers' interview - I was hired by a woman with a lot of money. I don't know her name but I know
she's around 5'5" (65") or 5'7" (67"). She has red hair and she drives a Tesla Model S. I know that she 
attended the SQL Symphony Concert 3 times in December 2017.*/


select * from interview
where person_id = 67318

select * from drivers_license
where height between 65 and 67 and hair_color = 'red' and gender = 'female' and car_make = 'Tesla' 
and car_model = 'Model S'


select dl.age, dl.height, dl.hair_color, dl.gender, dl.plate_number, dl.car_make, dl.car_model,
p.name, p.ssn, p.address_street_name, p.id
from drivers_license as dl
left join person as p
on dl.id = p.license_id
where gender = 'female' and hair_color = 'red' and car_make = 'Tesla' and car_model = 'Model S'
and height in (65, 67)

create table suspect as (select * from drivers_license
where height between 65 and 67 and hair_color = 'red' and gender = 'female' and car_make = 'Tesla' 
and car_model = 'Model S')

select S.id, s.age, s.height,
p.id as person_id, p.name, p.address_street_name, p.ssn
from suspect as s
right join person as p
on s.id = p.license_id

-- person_id for the 3 suspects are 99716, 90700, 78881--

select * from facebook_event_checkin
where event_name = 'SQL Symphony Concert' 
and date between 20171201 and 20171231
and person_id in (99716, 90700, 78881)

-- the suspect is person_id 99716 --

select * from person
where id = 99716

-- the killer is Miranda Priestly--





--important query testing --

select event_name, date, id, height, hair_color, gender, car_make, car_model 
from facebook_event_checkin, person, drivers_license
where event_name = 'SQL Symphony Concert' and date between 20171201 and 20171231 
and height between 65 and 67 and hair_color = 'red' and gender = 'female' and car_make = 'Tesla' 
and car_model = 'Model S' and person_id in (202298, 291182, 918773)

select * from facebook_event_checkin
where id between 202298 and 291182 and 918773 and date between 20171201 and 20171231

