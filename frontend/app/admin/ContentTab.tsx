'use client';

import { useEffect, useState } from 'react';
import { createClient } from '@/lib/supabase/client';

const API = process.env.NEXT_PUBLIC_API_URL;

/* ---------- types ---------- */

interface Subject {
  id: number;
  slug: string;
  name: string;
  description: string | null;
  icon: string;
  order_index: number;
  is_available: boolean;
  practice_kind: string;
  teach_model: string;
  modules: number;
  published_modules: number;
}

interface Module {
  id: number;
  slug: string;
  title: string;
  description: string | null;
  order_index: number;
  published: boolean;
  book_id: number | null;
  questions: number;
}

interface Project {
  id: number;
  subject_id: number;
  slug: string;
  title: string;
  brief: string | null;
  order_index: number;
  subject_name: string | null;
}

/* ---------- helpers ---------- */

function Panel({ title, children }: { title: string; children: React.ReactNode }) {
  return (
    <div className="rounded-2xl bg-white border border-gray-100 p-5">
      <h3 className="font-semibold text-gray-800 mb-3 text-sm">{title}</h3>
      {children}
    </div>
  );
}

function StatusBadge({ published }: { published: boolean }) {
  if (published) {
    return <span className="rounded-full px-2 py-0.5 text-xs font-medium bg-green-100 text-green-700">Published</span>;
  }
  return <span className="rounded-full px-2 py-0.5 text-xs font-medium bg-amber-100 text-amber-700">Draft</span>;
}

/* ---------- component ---------- */

export default function ContentTab() {
  const supabase = createClient();

  /* subjects */
  const [subjects, setSubjects] = useState<Subject[]>([]);
  const [expanded, setExpanded] = useState<Record<number, boolean>>({});

  /* modules (per subject) */
  const [modulesMap, setModulesMap] = useState<Record<number, Module[]>>({});

  /* projects */
  const [projects, setProjects] = useState<Project[]>([]);

  /* subject create form */
  const [showCreateSubject, setShowCreateSubject] = useState(false);
  const [newSubjectName, setNewSubjectName] = useState('');
  const [newSubjectIcon, setNewSubjectIcon] = useState('');
  const [newSubjectPracticeKind, setNewSubjectPracticeKind] = useState('none');

  /* subject edit */
  const [editingSubject, setEditingSubject] = useState<number | null>(null);
  const [editSubjectName, setEditSubjectName] = useState('');
  const [editSubjectIcon, setEditSubjectIcon] = useState('');
  const [editSubjectAvailable, setEditSubjectAvailable] = useState(true);

  /* module create form (per subject) */
  const [createModuleFor, setCreateModuleFor] = useState<number | null>(null);
  const [newModuleTitle, setNewModuleTitle] = useState('');
  const [newModuleDescription, setNewModuleDescription] = useState('');

  /* project create form */
  const [showCreateProject, setShowCreateProject] = useState(false);
  const [newProjectTitle, setNewProjectTitle] = useState('');
  const [newProjectSubjectId, setNewProjectSubjectId] = useState('');

  /* loading / error */
  const [loadingSubjects, setLoadingSubjects] = useState(true);
  const [loadingProjects, setLoadingProjects] = useState(true);

  /* ---------- auth helper ---------- */

  async function token() {
    const { data: { session } } = await supabase.auth.getSession();
    return session?.access_token ?? null;
  }

  /** Surface a failed request to the admin instead of failing silently. */
  async function showError(res: Response, action: string) {
    const body = await res.json().catch(() => ({} as { error?: string }));
    alert(`Could not ${action}: ${body.error ?? `request failed (${res.status})`}`);
  }

  /* ---------- load data ---------- */

  async function loadSubjects() {
    const t = await token();
    if (!t) return;
    const res = await fetch(`${API}/api/admin/content/subjects`, {
      headers: { Authorization: `Bearer ${t}` },
    });
    if (res.ok) setSubjects((await res.json()).subjects ?? []);
    setLoadingSubjects(false);
  }

  async function loadProjects() {
    const t = await token();
    if (!t) return;
    const res = await fetch(`${API}/api/admin/content/projects`, {
      headers: { Authorization: `Bearer ${t}` },
    });
    if (res.ok) setProjects((await res.json()).projects ?? []);
    setLoadingProjects(false);
  }

  useEffect(() => {
    loadSubjects();
    loadProjects();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);


  /* ---------- modules ---------- */

  async function loadModules(subjectId: number) {
    const t = await token();
    if (!t) return;
    const res = await fetch(`${API}/api/admin/content/subjects/${subjectId}/modules`, {
      headers: { Authorization: `Bearer ${t}` },
    });
    if (res.ok) {
      const data = await res.json();
      setModulesMap((prev) => ({ ...prev, [subjectId]: data.modules ?? [] }));
    }
  }

  function toggleExpand(subjectId: number) {
    setExpanded((prev) => {
      const now = !prev[subjectId];
      if (now) loadModules(subjectId);
      return { ...prev, [subjectId]: now };
    });
  }

  /* ---------- subject CRUD ---------- */

  async function createSubject(e: React.FormEvent) {
    e.preventDefault();
    if (!newSubjectName.trim()) return;
    const t = await token();
    if (!t) return;
    const body: Record<string, unknown> = { name: newSubjectName.trim(), practice_kind: newSubjectPracticeKind };
    if (newSubjectIcon.trim()) body.icon = newSubjectIcon.trim();
    const res = await fetch(`${API}/api/admin/content/subjects`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${t}` },
      body: JSON.stringify(body),
    });
    if (res.ok) {
      setNewSubjectName('');
      setNewSubjectIcon('');
      setNewSubjectPracticeKind('none');
      setShowCreateSubject(false);
      await loadSubjects();
    } else {
      await showError(res, 'create subject');
    }
  }

  async function startEditSubject(subject: Subject) {
    setEditingSubject(subject.id);
    setEditSubjectName(subject.name);
    setEditSubjectIcon(subject.icon);
    setEditSubjectAvailable(subject.is_available);
  }

  async function saveSubject(id: number) {
    if (!editSubjectName.trim() || !editSubjectIcon.trim()) return;
    const t = await token();
    if (!t) return;
    const res = await fetch(`${API}/api/admin/content/subjects/${id}`, {
      method: 'PATCH',
      headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${t}` },
      body: JSON.stringify({
        name: editSubjectName.trim(),
        icon: editSubjectIcon.trim(),
        is_available: editSubjectAvailable,
      }),
    });
    if (res.ok) {
      setEditingSubject(null);
      await loadSubjects();
    } else {
      await showError(res, 'save subject');
    }
  }

  async function deleteSubject(id: number) {
    if (!confirm('Delete this subject and all its content?')) return;
    const t = await token();
    if (!t) return;
    const res = await fetch(`${API}/api/admin/content/subjects/${id}`, {
      method: 'DELETE',
      headers: { Authorization: `Bearer ${t}` },
    });
    if (res.ok) {
      setSubjects((prev) => prev.filter((s) => s.id !== id));
    } else {
      await showError(res, 'delete subject');
    }
  }

  /* ---------- module CRUD ---------- */

  async function createModule(subjectId: number, e: React.FormEvent) {
    e.preventDefault();
    if (!newModuleTitle.trim()) return;
    const t = await token();
    if (!t) return;
    const res = await fetch(`${API}/api/admin/content/subjects/${subjectId}/modules`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${t}` },
      body: JSON.stringify({ title: newModuleTitle.trim(), description: newModuleDescription.trim() }),
    });
    if (res.ok) {
      setNewModuleTitle('');
      setNewModuleDescription('');
      setCreateModuleFor(null);
      await loadModules(subjectId);
    } else {
      await showError(res, 'create module');
    }
  }

  async function toggleModulePublished(moduleId: number, currentlyPublished: boolean) {
    const t = await token();
    if (!t) return;
    const res = await fetch(`${API}/api/admin/content/modules/${moduleId}`, {
      method: 'PATCH',
      headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${t}` },
      body: JSON.stringify({ published: !currentlyPublished }),
    });
    if (res.ok) {
      setModulesMap((prev) => {
        const next = { ...prev };
        for (const sid of Object.keys(next)) {
          const id = Number(sid);
          next[id] = next[id].map((m) =>
            m.id === moduleId ? { ...m, published: !currentlyPublished } : m,
          );
        }
        return next;
      });
    } else {
      await showError(res, 'update module');
    }
  }

  async function deleteModule(moduleId: number) {
    if (!confirm('Delete this module?')) return;
    const t = await token();
    if (!t) return;
    const res = await fetch(`${API}/api/admin/content/modules/${moduleId}`, {
      method: 'DELETE',
      headers: { Authorization: `Bearer ${t}` },
    });
    if (res.ok) {
      setModulesMap((prev) => {
        const next = { ...prev };
        for (const sid of Object.keys(next)) {
          const id = Number(sid);
          next[id] = next[id].filter((m) => m.id !== moduleId);
        }
        return next;
      });
    } else {
      await showError(res, 'delete module');
    }
  }

  /* ---------- project CRUD ---------- */

  async function createProject(e: React.FormEvent) {
    e.preventDefault();
    if (!newProjectTitle.trim() || !newProjectSubjectId) return;
    const t = await token();
    if (!t) return;
    const res = await fetch(`${API}/api/admin/content/projects`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${t}` },
      body: JSON.stringify({ subject_id: Number(newProjectSubjectId), title: newProjectTitle.trim() }),
    });
    if (res.ok) {
      setNewProjectTitle('');
      setNewProjectSubjectId('');
      setShowCreateProject(false);
      await loadProjects();
    } else {
      await showError(res, 'create project');
    }
  }

  async function deleteProject(id: number) {
    if (!confirm('Delete this project?')) return;
    const t = await token();
    if (!t) return;
    const res = await fetch(`${API}/api/admin/content/projects/${id}`, {
      method: 'DELETE',
      headers: { Authorization: `Bearer ${t}` },
    });
    if (res.ok) {
      setProjects((prev) => prev.filter((p) => p.id !== id));
    } else {
      await showError(res, 'delete project');
    }
  }
  /* ---------- render ---------- */

  return (
    <div className="space-y-6">
      {/* ============ Subjects & Modules ============ */}
      <Panel title="Subjects &amp; Modules">
        {loadingSubjects ? (
          <p className="text-sm text-gray-400">Loading…</p>
        ) : (
          <div className="space-y-2">
            {subjects.length === 0 && (
              <p className="text-sm text-gray-400">No subjects yet.</p>
            )}

            {subjects.map((subject) => (
              <div
                key={subject.id}
                className="rounded-xl border border-gray-100 overflow-hidden"
              >
                {/* Accordion header */}
                <button
                  onClick={() => toggleExpand(subject.id)}
                  className="w-full flex items-center gap-3 px-4 py-3 text-left hover:bg-gray-50 transition-colors"
                >
                  <span className="text-lg shrink-0">{subject.icon}</span>
                  <div className="flex-1 min-w-0">
                    <span className="text-sm font-medium text-gray-800">
                      {subject.name}
                    </span>
                    <span className="ml-2 text-xs text-gray-400">
                      {subject.published_modules}/{subject.modules} modules
                      {subject.is_available ? ' · Live' : ' · Hidden'}
                    </span>
                  </div>
                  <span className="text-xs text-gray-400 shrink-0">
                    {expanded[subject.id] ? '▲' : '▼'}
                  </span>
                </button>

                {/* Expanded body */}
                {expanded[subject.id] && (
                  <div className="border-t border-gray-100 px-4 py-3 space-y-3">
                    {/* Inline edit subject */}
                    {editingSubject === subject.id ? (
                      <div className="flex items-center gap-2 flex-wrap">
                        <input
                          value={editSubjectIcon}
                          onChange={(e) => setEditSubjectIcon(e.target.value)}
                          placeholder="icon"
                          className="w-12 border border-gray-300 rounded-md px-2 py-1.5 text-sm"
                        />
                        <input
                          value={editSubjectName}
                          onChange={(e) => setEditSubjectName(e.target.value)}
                          placeholder="Name"
                          className="flex-1 min-w-[120px] border border-gray-300 rounded-md px-2 py-1.5 text-sm"
                        />
                        <label className="flex items-center gap-1 text-xs text-gray-500">
                          <input
                            type="checkbox"
                            checked={editSubjectAvailable}
                            onChange={(e) => setEditSubjectAvailable(e.target.checked)}
                            className="rounded"
                          />
                          Available
                        </label>
                        <button
                          onClick={() => saveSubject(subject.id)}
                          className="rounded-md bg-indigo-600 text-white px-3 py-1.5 text-sm font-medium hover:bg-indigo-700"
                        >
                          Save
                        </button>
                        <button
                          onClick={() => setEditingSubject(null)}
                          className="text-xs text-gray-500 hover:underline"
                        >
                          Cancel
                        </button>
                      </div>
                    ) : (
                      <div className="flex items-center gap-2">
                        <button
                          onClick={() => startEditSubject(subject)}
                          className="text-xs text-indigo-600 hover:underline"
                        >
                          Edit
                        </button>
                        <button
                          onClick={() => deleteSubject(subject.id)}
                          className="text-xs text-red-500 hover:underline"
                        >
                          Delete
                        </button>
                      </div>
                    )}


                    {/* Modules list */}
                    {modulesMap[subject.id] === undefined ? (
                      <p className="text-xs text-gray-400">Loading modules…</p>
                    ) : modulesMap[subject.id].length === 0 ? (
                      <p className="text-xs text-gray-400">No modules yet.</p>
                    ) : (
                      <table className="w-full text-sm">
                        <thead>
                          <tr className="text-left text-xs text-gray-400">
                            <th className="py-1">Title</th>
                            <th>Status</th>
                            <th>Questions</th>
                            <th />
                          </tr>
                        </thead>
                        <tbody>
                          {modulesMap[subject.id].map((mod) => (
                            <tr key={mod.id} className="border-t border-gray-100">
                              <td className="py-1.5 text-gray-800">
                                {mod.title}
                                {mod.description && (
                                  <div className="text-xs text-gray-400 truncate max-w-[200px]">
                                    {mod.description}
                                  </div>
                                )}
                              </td>
                              <td className="py-1.5">
                                <StatusBadge published={mod.published} />
                              </td>
                              <td className="py-1.5 text-xs text-gray-500">
                                {mod.questions}
                              </td>
                              <td className="py-1.5 text-right whitespace-nowrap">
                                <button
                                  onClick={() =>
                                    toggleModulePublished(mod.id, mod.published)
                                  }
                                  className="text-xs text-indigo-600 hover:underline mr-2"
                                >
                                  {mod.published ? 'Unpublish' : 'Publish'}
                                </button>
                                <button
                                  onClick={() => deleteModule(mod.id)}
                                  className="text-xs text-red-500 hover:underline"
                                >
                                  Delete
                                </button>
                              </td>
                            </tr>
                          ))}
                        </tbody>
                      </table>
                    )}
                    {/* Inline create module form */}
                    {createModuleFor === subject.id ? (
                      <form
                        onSubmit={(e) => createModule(subject.id, e)}
                        className="flex items-center gap-2 flex-wrap pt-2 border-t border-gray-100"
                      >
                        <input
                          value={newModuleTitle}
                          onChange={(e) => setNewModuleTitle(e.target.value)}
                          placeholder="Module title"
                          className="flex-1 min-w-[160px] border border-gray-300 rounded-md px-2 py-1.5 text-sm"
                        />
                        <input
                          value={newModuleDescription}
                          onChange={(e) => setNewModuleDescription(e.target.value)}
                          placeholder="Description (optional)"
                          className="flex-1 min-w-[160px] border border-gray-300 rounded-md px-2 py-1.5 text-sm"
                        />
                        <button
                          type="submit"
                          disabled={!newModuleTitle.trim()}
                          className="rounded-md bg-indigo-600 text-white px-3 py-1.5 text-sm font-medium hover:bg-indigo-700 disabled:opacity-50"
                        >
                          Create
                        </button>
                        <button
                          type="button"
                          onClick={() => {
                            setCreateModuleFor(null);
                            setNewModuleTitle('');
                            setNewModuleDescription('');
                          }}
                          className="text-xs text-gray-500 hover:underline"
                        >
                          Cancel
                        </button>
                      </form>
                    ) : (
                      <button
                        onClick={() => setCreateModuleFor(subject.id)}
                        className="text-xs text-indigo-600 hover:underline pt-1"
                      >
                        + Add module
                      </button>
                    )}
                  </div>
                )}
              </div>
            ))}
          </div>
        )}

        {/* Inline create subject form */}
        {showCreateSubject ? (
          <form onSubmit={createSubject} className="mt-4 flex items-center gap-2 flex-wrap border-t border-gray-100 pt-4">
            <input
              value={newSubjectIcon}
              onChange={(e) => setNewSubjectIcon(e.target.value)}
              placeholder="Icon (emoji)"
              className="w-16 border border-gray-300 rounded-md px-2 py-1.5 text-sm"
            />
            <input
              value={newSubjectName}
              onChange={(e) => setNewSubjectName(e.target.value)}
              placeholder="Subject name"
              className="flex-1 min-w-[160px] border border-gray-300 rounded-md px-2 py-1.5 text-sm"
            />
            <select
              value={newSubjectPracticeKind}
              onChange={(e) => setNewSubjectPracticeKind(e.target.value)}
              title="Practice type"
              className="border border-gray-300 rounded-md px-2 py-1.5 text-sm bg-white"
            >
              <option value="none">No practice</option>
              <option value="code">Code</option>
              <option value="problem">Problem</option>
              <option value="web">Web</option>
            </select>
            <button
              type="submit"
              disabled={!newSubjectName.trim()}
              className="rounded-md bg-indigo-600 text-white px-3 py-1.5 text-sm font-medium hover:bg-indigo-700 disabled:opacity-50"
            >
              Create
            </button>
            <button
              type="button"
              onClick={() => {
                setShowCreateSubject(false);
                setNewSubjectName('');
                setNewSubjectIcon('');
              }}
              className="text-xs text-gray-500 hover:underline"
            >
              Cancel
            </button>
          </form>
        ) : (
          <button
            onClick={() => setShowCreateSubject(true)}
            className="mt-4 text-xs text-indigo-600 hover:underline"
          >
            + Add subject
          </button>
        )}
      </Panel>

      {/* ============ Projects ============ */}
      <Panel title="Projects">
        {loadingProjects ? (
          <p className="text-sm text-gray-400">Loading…</p>
        ) : (
          <>
            <table className="w-full text-sm">
              <thead>
                <tr className="text-left text-xs text-gray-400">
                  <th className="py-1">Title</th>
                  <th>Subject</th>
                  <th />
                </tr>
              </thead>
              <tbody>
                {projects.length === 0 && (
                  <tr>
                    <td className="py-1.5 text-gray-400" colSpan={3}>
                      No projects yet.
                    </td>
                  </tr>
                )}
                {projects.map((proj) => (
                  <tr key={proj.id} className="border-t border-gray-100">
                    <td className="py-1.5 text-gray-800">{proj.title}</td>
                    <td className="py-1.5 text-xs text-gray-500">
                      {proj.subject_name ?? '—'}
                    </td>
                    <td className="py-1.5 text-right">
                      <button
                        onClick={() => deleteProject(proj.id)}
                        className="text-xs text-red-500 hover:underline"
                      >
                        Delete
                      </button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>

            {showCreateProject ? (
              <form
                onSubmit={createProject}
                className="mt-4 flex items-center gap-2 flex-wrap border-t border-gray-100 pt-4"
              >
                <input
                  value={newProjectTitle}
                  onChange={(e) => setNewProjectTitle(e.target.value)}
                  placeholder="Project title"
                  className="flex-1 min-w-[160px] border border-gray-300 rounded-md px-2 py-1.5 text-sm"
                />
                <select
                  value={newProjectSubjectId}
                  onChange={(e) => setNewProjectSubjectId(e.target.value)}
                  className="border border-gray-300 rounded-md px-2 py-1.5 text-sm bg-white"
                >
                  <option value="">Select subject…</option>
                  {subjects.map((s) => (
                    <option key={s.id} value={s.id}>
                      {s.icon} {s.name}
                    </option>
                  ))}
                </select>
                <button
                  type="submit"
                  disabled={!newProjectTitle.trim() || !newProjectSubjectId}
                  className="rounded-md bg-indigo-600 text-white px-3 py-1.5 text-sm font-medium hover:bg-indigo-700 disabled:opacity-50"
                >
                  Create
                </button>
                <button
                  type="button"
                  onClick={() => {
                    setShowCreateProject(false);
                    setNewProjectTitle('');
                    setNewProjectSubjectId('');
                  }}
                  className="text-xs text-gray-500 hover:underline"
                >
                  Cancel
                </button>
              </form>
            ) : (
              <button
                onClick={() => setShowCreateProject(true)}
                className="mt-4 text-xs text-indigo-600 hover:underline"
              >
                + Add project
              </button>
            )}
          </>
        )}
      </Panel>
    </div>
  );
}

