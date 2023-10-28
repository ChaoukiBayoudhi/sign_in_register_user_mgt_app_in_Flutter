create table Users(
    id serial primary key,
    name varchar(200) not null,
    family_name varchar(200) not null,
    email varchar(150) not null,
    birthdate date,
    password varchar(100),
    phone varchar(20),
    user_role varchar(50),
    photo varchar(200)
);