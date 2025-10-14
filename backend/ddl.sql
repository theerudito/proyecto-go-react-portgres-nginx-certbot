--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- Name: character; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."character" (
    character_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    age integer NOT NULL,
    clan_id bigint
);


ALTER TABLE public."character" OWNER TO postgres;

--
-- Name: character_character_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.character_character_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.character_character_id_seq OWNER TO postgres;

--
-- Name: character_character_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.character_character_id_seq OWNED BY public."character".character_id;


--
-- Name: clan; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clan (
    clan_id bigint NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.clan OWNER TO postgres;

--
-- Name: clan_clan_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.clan_clan_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.clan_clan_id_seq OWNER TO postgres;

--
-- Name: clan_clan_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.clan_clan_id_seq OWNED BY public.clan.clan_id;


--
-- Name: character character_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."character" ALTER COLUMN character_id SET DEFAULT nextval('public.character_character_id_seq'::regclass);


--
-- Name: clan clan_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clan ALTER COLUMN clan_id SET DEFAULT nextval('public.clan_clan_id_seq'::regclass);


--
-- Data for Name: character; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."character" (character_id, name, age, clan_id) FROM stdin;
1	Naruto	17	1
2	Sasuke	17	2
3	Hinata	16	3
4	Sakura	17	4
\.


--
-- Data for Name: clan; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clan (clan_id, name) FROM stdin;
1	Uzumaki
2	Uchiha
3	Hyuga
4	Haruno
\.


--
-- Name: character_character_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.character_character_id_seq', 4, true);


--
-- Name: clan_clan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clan_clan_id_seq', 4, true);


--
-- Name: character character_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."character"
    ADD CONSTRAINT character_pkey PRIMARY KEY (character_id);


--
-- Name: clan clan_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clan
    ADD CONSTRAINT clan_pkey PRIMARY KEY (clan_id);


--
-- Name: character fk_clan; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."character"
    ADD CONSTRAINT fk_clan FOREIGN KEY (clan_id) REFERENCES public.clan(clan_id);


--
-- PostgreSQL database dump complete
--

