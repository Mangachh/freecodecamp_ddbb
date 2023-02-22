--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: scores; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.scores (
    score_id integer NOT NULL,
    user_id integer NOT NULL,
    score integer NOT NULL
);


ALTER TABLE public.scores OWNER TO freecodecamp;

--
-- Name: scores_score_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.scores_score_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.scores_score_id_seq OWNER TO freecodecamp;

--
-- Name: scores_score_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.scores_score_id_seq OWNED BY public.scores.score_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    name character varying(22)
);


ALTER TABLE public.users OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: scores score_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.scores ALTER COLUMN score_id SET DEFAULT nextval('public.scores_score_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: scores; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.scores VALUES (1, 1, 2);
INSERT INTO public.scores VALUES (2, 2, 370);
INSERT INTO public.scores VALUES (3, 2, 370);
INSERT INTO public.scores VALUES (4, 3, 276);
INSERT INTO public.scores VALUES (5, 3, 376);
INSERT INTO public.scores VALUES (6, 2, 516);
INSERT INTO public.scores VALUES (7, 2, 497);
INSERT INTO public.scores VALUES (8, 2, 264);
INSERT INTO public.scores VALUES (9, 1, 9);
INSERT INTO public.scores VALUES (10, 1, 1);
INSERT INTO public.scores VALUES (11, 4, 218);
INSERT INTO public.scores VALUES (12, 4, 252);
INSERT INTO public.scores VALUES (13, 5, 499);
INSERT INTO public.scores VALUES (14, 5, 681);
INSERT INTO public.scores VALUES (15, 4, 393);
INSERT INTO public.scores VALUES (16, 4, 921);
INSERT INTO public.scores VALUES (17, 4, 692);
INSERT INTO public.scores VALUES (18, 6, 195);
INSERT INTO public.scores VALUES (19, 6, 819);
INSERT INTO public.scores VALUES (20, 7, 878);
INSERT INTO public.scores VALUES (21, 7, 941);
INSERT INTO public.scores VALUES (22, 6, 26);
INSERT INTO public.scores VALUES (23, 6, 248);
INSERT INTO public.scores VALUES (24, 6, 991);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.users VALUES (1, 'Pepote');
INSERT INTO public.users VALUES (2, 'user_1677086923725');
INSERT INTO public.users VALUES (3, 'user_1677086923724');
INSERT INTO public.users VALUES (4, 'user_1677087279106');
INSERT INTO public.users VALUES (5, 'user_1677087279105');
INSERT INTO public.users VALUES (6, 'user_1677087394990');
INSERT INTO public.users VALUES (7, 'user_1677087394989');


--
-- Name: scores_score_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.scores_score_id_seq', 24, true);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.users_user_id_seq', 7, true);


--
-- Name: scores scores_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.scores
    ADD CONSTRAINT scores_pkey PRIMARY KEY (score_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: scores scores_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.scores
    ADD CONSTRAINT scores_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- PostgreSQL database dump complete
--

