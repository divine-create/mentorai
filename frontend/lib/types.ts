export interface Module {
  id: number;
  slug: string;
  title: string;
  description: string;
  order_index: number;
  estimated_hours_min: number;
  estimated_hours_max: number;
  mastery_score: number;   // 0–100
  attempts: number;
  unlocked: boolean;
  last_assessed_at: string | null;
}

export interface LearnerProfile {
  current_module_id: number | null;
  overall_mastery: number;
  streak_days: number;
  last_session_at: string | null;
}

export interface Subject {
  id: string;
  slug: string;
  name: string;
  description?: string;
  icon?: string;
  practice_kind?: string;
  mastery_weights?: Record<string, unknown>;
}

export interface LearningPath {
  modules: Module[];
  profile: LearnerProfile | null;
  subject: Subject | null;
}

// Per-subject rollup for the dashboard course catalog (GET /api/subjects/overview).
export interface SubjectOverview {
  id: number;
  slug: string;
  name: string;
  description?: string;
  icon?: string;
  practice_kind?: string;
  total_modules: number;
  completed_modules: number;
  avg_mastery: number;
  progress_pct: number;
  started: boolean;
  active: boolean;
}

// GET /api/progress/summary — streak, weekly activity, and a ready-made
// welcome-back / streak-at-risk notification string.
export interface ProgressSummary {
  streak: number;
  streakAtRisk: boolean;
  overallMastery: number;
  currentModule: { title: string | null; slug: string | null };
  weekSessions: number;
  weekMinutes: number;
  reviewsDue: number;
  notification: string | null;
}

// GET /api/profile — identity, lifetime stats, and recent session activity.
export interface ProfileData {
  profile: {
    name: string | null;
    email: string;
    goal: string | null;
    experience: string | null;
    subscription_status: string;
    created_at: string;
    streak_days: number;
    overall_mastery: number;
  };
  stats: {
    totalSessions: number;
    totalMinutes: number;
    questionsAnswered: number;
    accuracyPct: number;
    modulesCompleted: number;
  };
  recentSessions: {
    moduleTitle: string;
    moduleSlug: string;
    endedAt: string;
    durationMinutes: number;
    summary: string | null;
  }[];
}

export interface ModelOption {
  id: string;
  label: string;
  provider: 'anthropic' | 'deepseek' | 'gemini';
  model: string;
  description: string;
  available: boolean;
}
