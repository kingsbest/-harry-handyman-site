# Harry Handyman Website — Deploy Guide (for Claude Code)

## What this is
A **complete, ready-to-deploy static website**. These are not mockups to
rebuild — the `.dc.html` files ARE the site and run directly in any browser.
No build step, no framework, no npm install.

## Stack
- Plain HTML pages (`*.dc.html`) that self-render via `support.js`.
- `index.html` at the root auto-redirects to the home page.
- Images live in `uploads/`. Interactive image drop-zones use `image-slot.js`.

## Required files (must all deploy together)
- `index.html` — entry point / redirect to home
- `Home Harry Handyman Service.dc.html` — home page
- All other `*.dc.html` pages (about, areas, contact, faq, our-work,
  service + location pages, etc.)
- `support.js` — runtime that renders every `.dc.html` page (do NOT remove)
- `image-slot.js` — image drop-zone component
- `uploads/` — all photos and logos

## Deploy to Netlify
This is a static site. No build command needed.

**Option A — Git (recommended):**
```
git add .
git commit -m "Deploy Harry Handyman site"
git push origin main
```
Repo: `kingsbest/-harry-handyman-site`. In Netlify, connect the repo with:
- Build command: *(leave empty)*
- Publish directory: `.` (root)

**Option B — Netlify CLI:**
```
netlify deploy --prod --dir .
```

**Option C — drag & drop:** zip the project root and drop it on
app.netlify.com/drop.

## Notes
- The root URL serves `index.html`, which redirects to the home page.
- Page-to-page links are relative, so they work on any host.
- Filenames contain spaces (e.g. `Home Harry Handyman Service.dc.html`);
  Netlify handles these, but keep them URL-encoded (`%20`) in any hand-written
  links. Existing links already work.
- To rename the home file to a cleaner URL, update the redirect target in
  `index.html` and any nav links that point to it.
