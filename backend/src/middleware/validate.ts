/**
 * Validation helpers for Express route handlers.
 * All functions return a human-readable error string or null (valid).
 */

/**
 * Check that `body` contains every field in `fields` as a non-null, non-undefined value.
 * Returns the first missing field name as an error message, or null if all present.
 */
export function requireFields(body: any, fields: string[]): string | null {
  for (const field of fields) {
    const val = body?.[field];
    if (val === undefined || val === null) {
      return `Missing required field: ${field}`;
    }
  }
  return null;
}

/**
 * Check that `val` is a non-empty string (after trimming).
 * Returns an error message or null if valid.
 */
export function requireString(val: any, name: string): string | null {
  if (typeof val !== 'string') {
    return `Field "${name}" must be a string`;
  }
  if (val.trim().length === 0) {
    return `Field "${name}" must not be empty`;
  }
  return null;
}

/**
 * Check that `val` is a finite number.
 * Returns an error message or null if valid.
 */
export function requireNumber(val: any, name: string): string | null {
  if (typeof val !== 'number' || !Number.isFinite(val)) {
    return `Field "${name}" must be a number`;
  }
  return null;
}

/**
 * Check that `val` is a boolean.
 * Returns an error message or null if valid.
 */
export function requireBoolean(val: any, name: string): string | null {
  if (typeof val !== 'boolean') {
    return `Field "${name}" must be a boolean`;
  }
  return null;
}

/**
 * Check that `val` is one of the allowed values.
 * Returns an error message or null if valid.
 */
export function requireOneOf(val: any, name: string, allowed: readonly string[]): string | null {
  if (!allowed.includes(val)) {
    return `Field "${name}" must be one of: ${allowed.join(', ')}`;
  }
  return null;
}

/**
 * Validate an array of errors; if any are non-null, return 400 with first error and true.
 * Otherwise return null and false.
 */
export function sendValidationErrors(res: any, errors: (string | null)[]): boolean {
  for (const err of errors) {
    if (err !== null) {
      res.status(400).json({ error: err });
      return true;
    }
  }
  return false;
}
