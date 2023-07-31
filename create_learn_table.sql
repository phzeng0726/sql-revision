CREATE DATABASE demo;

USE demo;

create table student (
	s_id varchar(20),
    s_name varchar(20) not null default '',
    s_birth varchar(20) not null default '',
    s_sex varchar(10) not null default '',
    primary key(s_id)
);

create table course (
	c_id varchar(20),
    c_name varchar(20) not null default '',
    t_id varchar(20) not null,
    primary key(c_id)
);

create table teacher (
	t_id varchar(20),
    t_name varchar(20) not null default '',
    primary key(t_id)
);

create table score (
	s_id varchar(20),
    c_id varchar(20),
    s_score int(3),
    primary key(s_id, c_id)
);