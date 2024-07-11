--SQL 7 problem CASE STUDY Challenge 

CREATE TABLE eusers (
    USER_ID INT PRIMARY KEY,
    USER_NAME VARCHAR(20) NOT NULL,
    USER_STATUS VARCHAR(20) NOT NULL
);

CREATE TABLE eLOGINS (
    USER_ID INT,
    LOGIN_TIMESTAMP DATETIME NOT NULL,
    SESSION_ID INT PRIMARY KEY,
    SESSION_SCORE INT,
    FOREIGN KEY (USER_ID) REFERENCES eusers(USER_ID)
);

-- eusers Table
INSERT INTO eusers VALUES (1, 'Alice', 'Active');
INSERT INTO eusers VALUES (2, 'Bob', 'Inactive');
INSERT INTO eusers VALUES (3, 'Charlie', 'Active');
INSERT INTO eusers  VALUES (4, 'David', 'Active');
INSERT INTO eusers  VALUES (5, 'Eve', 'Inactive');
INSERT INTO eusers  VALUES (6, 'Frank', 'Active');
INSERT INTO eusers  VALUES (7, 'Grace', 'Inactive');
INSERT INTO eusers  VALUES (8, 'Heidi', 'Active');
INSERT INTO eusers VALUES (9, 'Ivan', 'Inactive');
INSERT INTO eusers VALUES (10, 'Judy', 'Active');

-- eLOGINS Table 

INSERT INTO eLOGINS  VALUES (1, '2023-07-15 09:30:00', 1001, 85);
INSERT INTO eLOGINS VALUES (2, '2023-07-22 10:00:00', 1002, 90);
INSERT INTO eLOGINS VALUES (3, '2023-08-10 11:15:00', 1003, 75);
INSERT INTO eLOGINS VALUES (4, '2023-08-20 14:00:00', 1004, 88);
INSERT INTO eLOGINS  VALUES (5, '2023-09-05 16:45:00', 1005, 82);

INSERT INTO eLOGINS  VALUES (6, '2023-10-12 08:30:00', 1006, 77);
INSERT INTO eLOGINS  VALUES (7, '2023-11-18 09:00:00', 1007, 81);
INSERT INTO eLOGINS VALUES (8, '2023-12-01 10:30:00', 1008, 84);
INSERT INTO eLOGINS  VALUES (9, '2023-12-15 13:15:00', 1009, 79);


-- 2024 Q1
INSERT INTO eLOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (1, '2024-01-10 07:45:00', 1011, 86);
INSERT INTO eLOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (2, '2024-01-25 09:30:00', 1012, 89);
INSERT INTO eLOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (3, '2024-02-05 11:00:00', 1013, 78);
INSERT INTO eLOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (4, '2024-03-01 14:30:00', 1014, 91);
INSERT INTO eLOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (5, '2024-03-15 16:00:00', 1015, 83);

INSERT INTO eLOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (6, '2024-04-12 08:00:00', 1016, 80);
INSERT INTO eLOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (7, '2024-05-18 09:15:00', 1017, 82);
INSERT INTO eLOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (8, '2024-05-28 10:45:00', 1018, 87);
INSERT INTO eLOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (9, '2024-06-15 13:30:00', 1019, 76);
INSERT INTO eLOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (10, '2024-06-25 15:00:00', 1010, 92);
INSERT INTO eLOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (10, '2024-06-26 15:45:00', 1020, 93);
INSERT INTO eLOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (10, '2024-06-27 15:00:00', 1021, 92);
INSERT INTO eLOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (10, '2024-06-28 15:45:00', 1022, 93);
INSERT INTO eLOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (1, '2024-01-10 07:45:00', 1101, 86);
INSERT INTO eLOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (3, '2024-01-25 09:30:00', 1102, 89);
INSERT INTO eLOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (5, '2024-01-15 11:00:00', 1103, 78);
INSERT INTO eLOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (2, '2023-11-10 07:45:00', 1201, 82);
INSERT INTO eLOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (4, '2023-11-25 09:30:00', 1202, 84);
INSERT INTO eLOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (6, '2023-11-15 11:00:00', 1203, 80);
select * from eusers;
select * from elogins;

--today's month 
select month(getdate()) as today_month

--1 Management wants to see all the users that did not login in the past 5 months.
-- return only user_name

with cte as(
select distinct user_id
from eLOGINS as l 
where month(LOGIN_TIMESTAMP) between month(getdate())-5 and month(getdate())-1 )
select user_id,user_name
from eusers 
where user_id not in (select * from cte)

--2 Quaterly analysis calculate how many users and how many sessions per quater in year 2024
--order by quater newest to oldest
--return first day of the quater, user count, session count
select * from eLOGINS where year(LOGIN_TIMESTAMP)=2024 order by LOGIN_TIMESTAMP

with cte as(
select *, 
case 
when month(LOGIN_TIMESTAMP)>=1 and month(LOGIN_TIMESTAMP)<=3 then 1
when month(LOGIN_TIMESTAMP)>=4 and month(LOGIN_TIMESTAMP)<=6 then 2
when month(LOGIN_TIMESTAMP)>=7 and month(LOGIN_TIMESTAMP)<=9 then 3
when month(LOGIN_TIMESTAMP)>=10 and month(LOGIN_TIMESTAMP)<=12 then 4
end as quater
from eLOGINS 
--where year(LOGIN_TIMESTAMP)=2024
)
select quater,count(distinct user_id) as total_User,count(session_id) as total_sessions,min(LOGIN_TIMESTAMP) as first_day_of_quater
from cte
group by quater;

-- 3 display user that did not login in nov 23 but login in jan 24 
--return user_id
with cte as(
select distinct user_id
from eLOGINS
where LOGIN_TIMESTAMP between '2023-11-01' and '2023-11-30'
)
select distinct user_id
from eLOGINS 
where LOGIN_TIMESTAMP between '2024-01-01' and '2024-01-31' and user_id not in (select * from cte)

--4 Add to the query number 2 the percentage change in sessions from prev quater
--return first day of the quater, session cnt, prev quater session cnt, % change

with cte as(
select *, 
case 
when month(LOGIN_TIMESTAMP)>=1 and month(LOGIN_TIMESTAMP)<=3 then 1
when month(LOGIN_TIMESTAMP)>=4 and month(LOGIN_TIMESTAMP)<=6 then 2
when month(LOGIN_TIMESTAMP)>=7 and month(LOGIN_TIMESTAMP)<=9 then 3
when month(LOGIN_TIMESTAMP)>=10 and month(LOGIN_TIMESTAMP)<=12 then 4
end as quater
from eLOGINS 
--where year(LOGIN_TIMESTAMP)=2024
), 
cte2 as(
select quater,count(distinct user_id) as total_User,count(session_id) as total_sessions,min(LOGIN_TIMESTAMP) as first_day_of_quater
from cte
group by quater)
select first_day_of_quater,total_sessions,lag(total_sessions,1) over(order by first_day_of_quater) as prev_cnt,
(total_sessions-lag(total_sessions,1,total_sessions) over(order by first_day_of_quater))*100.0/lag(total_sessions,1) over(order by first_day_of_quater) as percentage_change 
from cte2
order by first_day_of_quater;

--5 Display user name that has highest session score(max session score) each day 
--return - date,username,score

with cte as(
select user_id,cast (LOGIN_TIMESTAMP as date) as login_date,sum(SESSION_SCORE) as max_score
from eLOGINS  
group by user_id,cast (LOGIN_TIMESTAMP as date))
select login_date,user_name,max_score from 
(select *,row_number() over(partition by login_date order by max_score desc) as drn
from cte) as a 
join eusers as s 
on a.USER_ID=s.USER_ID 
where a.drn=1;

--6 Identify best users ie user that had a session on every single day since their first login
--make assumptions
--return user_id
with cte as(
select *,
datediff(day,LOGIN_TIMESTAMP,lead(LOGIN_TIMESTAMP,1,dateadd(day,1,login_timestamp)) over(partition by user_id order by login_timestamp)) as ddiff
from eLOGINS)
select e.user_id,e.USER_NAME,count(ddiff) as number_of_loginins,min(login_timestamp) as first_login_date, 
max(LOGIN_TIMESTAMP) as last_login_date
from eusers as e 
join cte as c on e.USER_ID=c.USER_ID
where e.user_id not in  (select user_id from cte where ddiff>1)
group by  e.user_id,e.USER_NAME

--7 On what dates there were no login at all 
--return login dates

with cte as(
select cast(min(LOGIN_TIMESTAMP) as date) as first_date,cast(max(LOGIN_TIMESTAMP) as date) as last_date
from eLOGINS
union all 
select dateadd(day,1,first_date) as first_date,last_date from cte
where first_date<last_date
)
select *
from cte
where first_date not in (select distinct cast(login_timestamp as date) from elogins)
option(maxrecursion 500);
