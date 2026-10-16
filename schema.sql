-- Таблица результатов исследования «Геймификация в образовании»
-- Выполнить в Supabase: SQL Editor → New query → Run

create table if not exists public.gamification_results (
    id               bigint generated always as identity primary key,
    created_at       timestamptz not null default now(),
    nickname         text        not null,
    favorite_element text,
    motivation       smallint    check (motivation between 1 and 10),
    quiz_score       smallint    check (quiz_score between 0 and 3),
    quiz_xp          integer     default 0,
    open_answer      text,
    ai_xp            integer     check (ai_xp between 0 and 50),
    ai_topic         text,
    ai_feedback      text,
    ai_next_task     text,
    ai_next_level    text,
    total_xp         integer     default 0,
    rank             text,
    teacher_comment  text        default '',
    verified         boolean     not null default false,
    is_demo          boolean     not null default false
);

create index if not exists gamification_results_created_at_idx
    on public.gamification_results (created_at desc);

-- Включаем Row Level Security без публичных политик:
-- анонимный доступ из браузера закрыт, а серверное приложение
-- работает с ключом service_role (он обходит RLS и хранится только в st.secrets).
alter table public.gamification_results enable row level security;
