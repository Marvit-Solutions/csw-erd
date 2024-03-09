-- This script was generated by the ERD tool in pgAdmin 4.
-- Please log an issue at https://github.com/pgadmin-org/pgadmin4/issues/new/choose if you find any bugs, including reproduction steps.
BEGIN;


ALTER TABLE IF EXISTS public.addresses DROP CONSTRAINT IF EXISTS user_detail_address_fk;

ALTER TABLE IF EXISTS public.class_user_plans DROP CONSTRAINT IF EXISTS plan_class_user_plan_fk;

ALTER TABLE IF EXISTS public.class_user_plans DROP CONSTRAINT IF EXISTS user_class_user_plan_fk;

ALTER TABLE IF EXISTS public.plans DROP CONSTRAINT IF EXISTS module_sub_plan_fk;

ALTER TABLE IF EXISTS public.schedules DROP CONSTRAINT IF EXISTS class_user_plan_schedule_fk;

ALTER TABLE IF EXISTS public.schedules DROP CONSTRAINT IF EXISTS sub_subject_schedule_fk;

ALTER TABLE IF EXISTS public.sub_modules DROP CONSTRAINT IF EXISTS module_sub_module_fk;

ALTER TABLE IF EXISTS public.sub_subjects DROP CONSTRAINT IF EXISTS subject_sub_subject_fk;

ALTER TABLE IF EXISTS public.subjects DROP CONSTRAINT IF EXISTS sub_module_subject_fk;

ALTER TABLE IF EXISTS public.user_details DROP CONSTRAINT IF EXISTS class_user_user_detail_fk;

ALTER TABLE IF EXISTS public.user_details DROP CONSTRAINT IF EXISTS user_user_detail_fk;

ALTER TABLE IF EXISTS public.user_testimonials DROP CONSTRAINT IF EXISTS testimonial_user_testimonial_fk;

ALTER TABLE IF EXISTS public.user_testimonials DROP CONSTRAINT IF EXISTS user_user_testimonial_fk;

ALTER TABLE IF EXISTS public.users DROP CONSTRAINT IF EXISTS role_user_fk;



DROP TABLE IF EXISTS public.addresses;

CREATE TABLE IF NOT EXISTS public.addresses
(
    id text COLLATE pg_catalog."default" NOT NULL,
    user_detail_id text COLLATE pg_catalog."default" NOT NULL,
    province text COLLATE pg_catalog."default" NOT NULL,
    regency_city text COLLATE pg_catalog."default" NOT NULL,
    sub_district text COLLATE pg_catalog."default" NOT NULL,
    created_at timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT addresses_pkey PRIMARY KEY (id)
);

DROP TABLE IF EXISTS public.class_user;

CREATE TABLE IF NOT EXISTS public.class_user
(
    id text COLLATE pg_catalog."default" NOT NULL,
    name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    created_at timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT class_user_pkey PRIMARY KEY (id)
);

DROP TABLE IF EXISTS public.class_user_plans;

CREATE TABLE IF NOT EXISTS public.class_user_plans
(
    id text COLLATE pg_catalog."default" NOT NULL,
    user_id text COLLATE pg_catalog."default" NOT NULL,
    plan_id text COLLATE pg_catalog."default" NOT NULL,
    name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    created_at timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT class_user_plan_pkey PRIMARY KEY (id),
    CONSTRAINT class_user_plan_uq UNIQUE (name)
);

DROP TABLE IF EXISTS public.modules;

CREATE TABLE IF NOT EXISTS public.modules
(
    id text COLLATE pg_catalog."default" NOT NULL,
    name text COLLATE pg_catalog."default" NOT NULL,
    created_at timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT modules_pkey PRIMARY KEY (id),
    CONSTRAINT module_uq UNIQUE (name)
        INCLUDE(name)
);

DROP TABLE IF EXISTS public.plans;

CREATE TABLE IF NOT EXISTS public.plans
(
    id text COLLATE pg_catalog."default" NOT NULL,
    module_id text COLLATE pg_catalog."default" NOT NULL,
    name text COLLATE pg_catalog."default" NOT NULL,
    price numeric NOT NULL,
    grup_pejuang boolean NOT NULL,
    exercise bigint NOT NULL,
    access bigint NOT NULL,
    module boolean NOT NULL,
    try_out bigint NOT NULL,
    zoom boolean NOT NULL,
    created_at timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT sub_plans_pkey PRIMARY KEY (id)
);

DROP TABLE IF EXISTS public.roles;

CREATE TABLE IF NOT EXISTS public.roles
(
    id text COLLATE pg_catalog."default" NOT NULL,
    name character varying(20) COLLATE pg_catalog."default" NOT NULL,
    created_at timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT roles_pkey PRIMARY KEY (id),
    CONSTRAINT role_uq UNIQUE (name)
        INCLUDE(name)
);

DROP TABLE IF EXISTS public.schedules;

CREATE TABLE IF NOT EXISTS public.schedules
(
    id text COLLATE pg_catalog."default" NOT NULL,
    sub_subject_id text COLLATE pg_catalog."default" NOT NULL,
    class_user_plan_id text COLLATE pg_catalog."default" NOT NULL,
    meeting_date timestamp with time zone NOT NULL,
    created_at timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT schedule_pkey PRIMARY KEY (id)
);

DROP TABLE IF EXISTS public.sub_modules;

CREATE TABLE IF NOT EXISTS public.sub_modules
(
    id text COLLATE pg_catalog."default" NOT NULL,
    module_id text COLLATE pg_catalog."default" NOT NULL,
    name text COLLATE pg_catalog."default" NOT NULL,
    description text COLLATE pg_catalog."default" NOT NULL,
    created_at timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT sub_modules_pkey PRIMARY KEY (id),
    CONSTRAINT sub_module_uq UNIQUE (name)
        INCLUDE(name)
);

DROP TABLE IF EXISTS public.sub_subjects;

CREATE TABLE IF NOT EXISTS public.sub_subjects
(
    id text COLLATE pg_catalog."default" NOT NULL,
    subject_id text COLLATE pg_catalog."default" NOT NULL,
    name text COLLATE pg_catalog."default" NOT NULL,
    content text COLLATE pg_catalog."default" NOT NULL,
    created_at timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT sub_subjects_pkey PRIMARY KEY (id),
    CONSTRAINT sub_subject_uq UNIQUE (name, content)
);

DROP TABLE IF EXISTS public.subjects;

CREATE TABLE IF NOT EXISTS public.subjects
(
    id text COLLATE pg_catalog."default" NOT NULL,
    sub_module_id text COLLATE pg_catalog."default" NOT NULL,
    name text COLLATE pg_catalog."default" NOT NULL,
    created_at timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT subjects_pkey PRIMARY KEY (id),
    CONSTRAINT subject_uq UNIQUE (name)
        INCLUDE(name)
);

DROP TABLE IF EXISTS public.test_types;

CREATE TABLE IF NOT EXISTS public.test_types
(
    id text COLLATE pg_catalog."default" NOT NULL,
    name text COLLATE pg_catalog."default" NOT NULL,
    created_at timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT test_type_pkey PRIMARY KEY (id),
    CONSTRAINT test_type_uq UNIQUE (name)
);

DROP TABLE IF EXISTS public.testimonials;

CREATE TABLE IF NOT EXISTS public.testimonials
(
    id text COLLATE pg_catalog."default" NOT NULL,
    comment text COLLATE pg_catalog."default" NOT NULL,
    rating numeric NOT NULL,
    created_at timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT testimonials_pkey PRIMARY KEY (id)
);

DROP TABLE IF EXISTS public.user_details;

CREATE TABLE IF NOT EXISTS public.user_details
(
    id text COLLATE pg_catalog."default" NOT NULL,
    class_user_id text COLLATE pg_catalog."default" NOT NULL,
    user_id text COLLATE pg_catalog."default" NOT NULL,
    name character varying(100) COLLATE pg_catalog."default" NOT NULL,
    phone_number character varying(50) COLLATE pg_catalog."default" NOT NULL,
    profile_picture text COLLATE pg_catalog."default" NOT NULL,
    created_at timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT user_details_pkey PRIMARY KEY (id),
    CONSTRAINT user_details_uq UNIQUE (phone_number, profile_picture)
);

DROP TABLE IF EXISTS public.user_testimonials;

CREATE TABLE IF NOT EXISTS public.user_testimonials
(
    id text COLLATE pg_catalog."default" NOT NULL,
    user_id text COLLATE pg_catalog."default" NOT NULL,
    testimonial_id text COLLATE pg_catalog."default" NOT NULL,
    created_at timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT user_testimonials_pkey PRIMARY KEY (id)
);

DROP TABLE IF EXISTS public.users;

CREATE TABLE IF NOT EXISTS public.users
(
    id text COLLATE pg_catalog."default" NOT NULL,
    role_id text COLLATE pg_catalog."default" NOT NULL,
    google_id text COLLATE pg_catalog."default",
    facebook_id text COLLATE pg_catalog."default",
    email character varying(64) COLLATE pg_catalog."default" NOT NULL,
    password text COLLATE pg_catalog."default" NOT NULL,
    created_at timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT users_pkey PRIMARY KEY (id),
    CONSTRAINT users_email_key UNIQUE (email)
);

ALTER TABLE IF EXISTS public.addresses
    ADD CONSTRAINT user_detail_address_fk FOREIGN KEY (user_detail_id)
    REFERENCES public.user_details (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.class_user_plans
    ADD CONSTRAINT plan_class_user_plan_fk FOREIGN KEY (plan_id)
    REFERENCES public.plans (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.class_user_plans
    ADD CONSTRAINT user_class_user_plan_fk FOREIGN KEY (user_id)
    REFERENCES public.users (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.plans
    ADD CONSTRAINT module_sub_plan_fk FOREIGN KEY (module_id)
    REFERENCES public.modules (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.schedules
    ADD CONSTRAINT class_user_plan_schedule_fk FOREIGN KEY (class_user_plan_id)
    REFERENCES public.class_user_plans (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.schedules
    ADD CONSTRAINT sub_subject_schedule_fk FOREIGN KEY (sub_subject_id)
    REFERENCES public.sub_subjects (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.sub_modules
    ADD CONSTRAINT module_sub_module_fk FOREIGN KEY (module_id)
    REFERENCES public.modules (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.sub_subjects
    ADD CONSTRAINT subject_sub_subject_fk FOREIGN KEY (subject_id)
    REFERENCES public.subjects (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.subjects
    ADD CONSTRAINT sub_module_subject_fk FOREIGN KEY (sub_module_id)
    REFERENCES public.sub_modules (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.user_details
    ADD CONSTRAINT class_user_user_detail_fk FOREIGN KEY (class_user_id)
    REFERENCES public.class_user (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.user_details
    ADD CONSTRAINT user_user_detail_fk FOREIGN KEY (user_id)
    REFERENCES public.users (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.user_testimonials
    ADD CONSTRAINT testimonial_user_testimonial_fk FOREIGN KEY (testimonial_id)
    REFERENCES public.testimonials (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.user_testimonials
    ADD CONSTRAINT user_user_testimonial_fk FOREIGN KEY (user_id)
    REFERENCES public.users (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.users
    ADD CONSTRAINT role_user_fk FOREIGN KEY (role_id)
    REFERENCES public.roles (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

END;