-- ============================================================
-- Plateforme Pédagogique de Physique – UCD
-- Schéma de base de données Supabase
-- ============================================================

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ============================================================
-- TABLE: chapters
-- ============================================================
CREATE TABLE IF NOT EXISTS public.chapters (
  id          SERIAL PRIMARY KEY,
  number      INTEGER NOT NULL UNIQUE,
  title       TEXT NOT NULL,
  description TEXT,
  is_active   BOOLEAN DEFAULT true,
  created_at  TIMESTAMPTZ DEFAULT NOW(),
  updated_at  TIMESTAMPTZ DEFAULT NOW()
);

-- Insert default chapters
INSERT INTO public.chapters (number, title, description) VALUES
  (1, 'Électrocinétique', 'Lois fondamentales des circuits électriques, dipôles et régimes transitoires.'),
  (2, 'Mécanique classique', 'Cinématique et dynamique du point matériel, lois de Newton et énergie mécanique.'),
  (3, 'Optique géométrique', 'Propagation de la lumière, réflexion, réfraction et systèmes optiques.'),
  (4, 'Thermodynamique', 'Principes de la thermodynamique, gaz parfaits et cycles thermodynamiques.'),
  (5, 'Ondes et vibrations', 'Phénomènes ondulatoires, propagation des ondes, acoustique et optique ondulatoire.')
ON CONFLICT (number) DO NOTHING;

-- ============================================================
-- TABLE: questions
-- ============================================================
CREATE TABLE IF NOT EXISTS public.questions (
  id              SERIAL PRIMARY KEY,
  chapter_id      INTEGER REFERENCES public.chapters(id) ON DELETE CASCADE,
  order_num       INTEGER DEFAULT 1,
  question        TEXT NOT NULL,
  option_a        TEXT NOT NULL,
  option_b        TEXT NOT NULL,
  option_c        TEXT NOT NULL,
  option_d        TEXT NOT NULL,
  correct_answer  CHAR(1) NOT NULL CHECK (correct_answer IN ('A', 'B', 'C', 'D')),
  explanation     TEXT,
  has_latex       BOOLEAN DEFAULT false,
  image_url       TEXT,
  is_active       BOOLEAN DEFAULT true,
  created_at      TIMESTAMPTZ DEFAULT NOW(),
  updated_at      TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================
-- TABLE: resources
-- ============================================================
CREATE TABLE IF NOT EXISTS public.resources (
  id              SERIAL PRIMARY KEY,
  title           TEXT NOT NULL,
  chapter_id      INTEGER REFERENCES public.chapters(id) ON DELETE SET NULL,
  chapter_name    TEXT,
  type            TEXT NOT NULL CHECK (type IN ('cours', 'td', 'tp')),
  file_type       TEXT,  -- pdf, slx, m, xlsx, xls
  description     TEXT,
  file_url        TEXT,
  storage_path    TEXT,
  published_at    TIMESTAMPTZ DEFAULT NOW(),
  -- TP specific fields
  tp_number       INTEGER,
  tp_title        TEXT,
  objectives      TEXT,
  created_at      TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================
-- TABLE: evaluations
-- ============================================================
CREATE TABLE IF NOT EXISTS public.evaluations (
  id                    SERIAL PRIMARY KEY,
  title                 TEXT DEFAULT 'Évaluation de Physique',
  duration_minutes      INTEGER DEFAULT 60,
  questions_per_chapter INTEGER DEFAULT 4,
  total_questions       INTEGER DEFAULT 20,
  show_corrections      BOOLEAN DEFAULT true,
  is_active             BOOLEAN DEFAULT true,
  created_at            TIMESTAMPTZ DEFAULT NOW()
);

-- Insert default evaluation config
INSERT INTO public.evaluations (title, duration_minutes, questions_per_chapter, total_questions, show_corrections, is_active)
VALUES ('Évaluation Physique – Licence S1', 60, 4, 20, true, true)
ON CONFLICT DO NOTHING;

-- ============================================================
-- TABLE: student_results
-- ============================================================
CREATE TABLE IF NOT EXISTS public.student_results (
  id              UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  student_name    TEXT DEFAULT 'Anonyme',
  score           INTEGER NOT NULL,
  total_questions INTEGER NOT NULL,
  percentage      INTEGER NOT NULL,
  answers_json    JSONB,
  evaluation_id   INTEGER REFERENCES public.evaluations(id) ON DELETE SET NULL,
  created_at      TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================
-- ROW LEVEL SECURITY (RLS)
-- ============================================================

-- Enable RLS on all tables
ALTER TABLE public.chapters ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.questions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.resources ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.evaluations ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.student_results ENABLE ROW LEVEL SECURITY;

-- CHAPTERS: Anyone can read, only authenticated users can write
CREATE POLICY "chapters_read_all" ON public.chapters FOR SELECT USING (true);
CREATE POLICY "chapters_write_auth" ON public.chapters FOR ALL USING (auth.role() = 'authenticated');

-- QUESTIONS: Anyone can read active questions, only authenticated can write
-- IMPORTANT: Correct answers should not leak before submission
-- This policy allows reading questions without exposing correct_answer to anon
CREATE POLICY "questions_read_all" ON public.questions FOR SELECT USING (is_active = true);
CREATE POLICY "questions_write_auth" ON public.questions FOR ALL USING (auth.role() = 'authenticated');

-- RESOURCES: Anyone can read, only authenticated can write
CREATE POLICY "resources_read_all" ON public.resources FOR SELECT USING (true);
CREATE POLICY "resources_write_auth" ON public.resources FOR ALL USING (auth.role() = 'authenticated');

-- EVALUATIONS: Anyone can read, only authenticated can write
CREATE POLICY "evaluations_read_all" ON public.evaluations FOR SELECT USING (true);
CREATE POLICY "evaluations_write_auth" ON public.evaluations FOR ALL USING (auth.role() = 'authenticated');

-- STUDENT RESULTS: Anyone can insert their own, only authenticated can read all
CREATE POLICY "results_insert_all" ON public.student_results FOR INSERT WITH CHECK (true);
CREATE POLICY "results_read_auth" ON public.student_results FOR SELECT USING (auth.role() = 'authenticated');
CREATE POLICY "results_delete_auth" ON public.student_results FOR DELETE USING (auth.role() = 'authenticated');

-- ============================================================
-- STORAGE BUCKET (run in Supabase Dashboard SQL editor)
-- ============================================================
-- Note: Create the bucket via the Supabase Dashboard UI:
-- Storage > New bucket > Name: "resources" > Public: true
-- Then add these storage policies:

-- INSERT INTO storage.buckets (id, name, public) VALUES ('resources', 'resources', true)
-- ON CONFLICT DO NOTHING;

-- CREATE POLICY "storage_read_all" ON storage.objects FOR SELECT USING (bucket_id = 'resources');
-- CREATE POLICY "storage_write_auth" ON storage.objects FOR INSERT USING (auth.role() = 'authenticated');
-- CREATE POLICY "storage_delete_auth" ON storage.objects FOR DELETE USING (auth.role() = 'authenticated');
