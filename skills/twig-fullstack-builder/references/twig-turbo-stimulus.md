# Twig + Turbo + Stimulus + Tailwind v4 Patterns

---

## Tailwind v4 in Twig — conventions

### Base layout structure

```html
{# Resources/views/layout.html.twig #}
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{% block title %}{{ app_name }}{% endblock %}</title>
    {% block stylesheets %}
        {{ importmap('app') }}
    {% endblock %}
</head>
<body class="min-h-screen bg-gray-50 font-sans text-gray-900 antialiased">
    {% block flash_messages %}
        {% for type, messages in app.flashes %}
            {% for message in messages %}
                <div data-controller="flash" class="
                    fixed top-4 right-4 z-50 px-4 py-3 rounded-lg shadow-lg text-sm font-medium
                    {{ type == 'success' ? 'bg-emerald-50 text-emerald-800 border border-emerald-200' : '' }}
                    {{ type == 'error' ? 'bg-red-50 text-red-800 border border-red-200' : '' }}
                    {{ type == 'warning' ? 'bg-amber-50 text-amber-800 border border-amber-200' : '' }}
                ">
                    {{ message }}
                </div>
            {% endfor %}
        {% endfor %}
    {% endblock %}

    <main class="container mx-auto px-4 py-8 max-w-7xl">
        {% block body %}{% endblock %}
    </main>

    {% block javascripts %}{% endblock %}
</body>
</html>
```

### Component-style Twig with Tailwind

```html
{# Resources/views/invoice/_card.html.twig #}
{# Partial: invoice card with status badge and action buttons #}

<div id="invoice-{{ invoice.id }}"
     class="bg-white rounded-xl shadow-sm border border-gray-100 p-6
            hover:shadow-md transition-shadow duration-200">

    <div class="flex items-start justify-between">
        <div>
            <h3 class="font-semibold text-gray-900 text-lg">
                {{ invoice.invoiceNumber }}
            </h3>
            <p class="text-sm text-gray-500 mt-1">
                {{ invoice.client.name }}
            </p>
        </div>

        {# Status badge #}
        {% set statusColors = {
            'draft': 'bg-gray-100 text-gray-700',
            'validated': 'bg-blue-100 text-blue-700',
            'sent': 'bg-indigo-100 text-indigo-700',
            'paid': 'bg-emerald-100 text-emerald-700',
            'archived': 'bg-amber-100 text-amber-700',
        } %}
        <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium
                     {{ statusColors[invoice.status] ?? 'bg-gray-100 text-gray-700' }}">
            {{ invoice.status|capitalize }}
        </span>
    </div>

    <div class="mt-4 flex items-center gap-3">
        <span class="text-xl font-bold text-gray-900">
            {{ invoice.total|number_format(2, ',', ' ') }} €
        </span>
    </div>

    <div class="mt-4 flex justify-end gap-2">
        {% if is_granted('INVOICE_ARCHIVE', invoice) and invoice.status != 'archived' %}
            <button
                data-controller="confirm-action"
                data-confirm-action-message-value="Archive this invoice?"
                data-action="confirm-action#confirm"
                data-confirm-action-url-value="{{ path('invoicing_archive', {id: invoice.id}) }}"
                data-confirm-action-token-value="{{ csrf_token('archive_invoice_' ~ invoice.id) }}"
                class="inline-flex items-center px-3 py-1.5 text-sm font-medium rounded-lg
                       text-amber-700 bg-amber-50 hover:bg-amber-100
                       border border-amber-200 transition-colors duration-150">
                Archive
            </button>
        {% endif %}
    </div>
</div>
```

---

## Turbo Frame — lazy loading pattern

```html
{# Wrap content that can be updated independently in a Turbo Frame #}

{# In the parent page #}
<turbo-frame id="invoice-list" loading="lazy" src="{{ path('invoicing_list_frame') }}">
    <div class="animate-pulse bg-gray-100 rounded-xl h-48"></div>
</turbo-frame>

{# In the frame response template (list_frame action returns this) #}
<turbo-frame id="invoice-list">
    {% for invoice in invoices %}
        {% include '@Invoicing/invoice/_card.html.twig' %}
    {% else %}
        <div class="text-center py-12 text-gray-500">
            <p class="text-lg font-medium">No invoices yet</p>
        </div>
    {% endfor %}
</turbo-frame>
```

---

## Turbo Stream — in-place update after action

```html
{# Resources/views/invoice/_archive_stream.html.twig #}
{# Returned as Turbo Stream response after archive action #}

<turbo-stream action="replace" target="invoice-{{ invoiceId }}">
    <template>
        {# Updated card showing archived state — or remove from list #}
        <div id="invoice-{{ invoiceId }}"
             class="bg-white rounded-xl shadow-sm border border-gray-100 p-6 opacity-60">
            <div class="flex items-center gap-3">
                <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium
                             bg-amber-100 text-amber-700">
                    Archived
                </span>
            </div>
        </div>
    </template>
</turbo-stream>

<turbo-stream action="prepend" target="flash-messages">
    <template>
        <div data-controller="flash" class="bg-emerald-50 text-emerald-800 border border-emerald-200
                                             fixed top-4 right-4 z-50 px-4 py-3 rounded-lg
                                             shadow-lg text-sm font-medium">
            Invoice archived successfully.
        </div>
    </template>
</turbo-stream>
```

---

## Stimulus Controller — confirm-action pattern

```javascript
// assets/controllers/confirm_action_controller.js

import { Controller } from '@hotwired/stimulus';

/**
 * Confirm-action Stimulus controller
 * Shows a browser confirmation dialog before submitting a POST action.
 *
 * Usage:
 * data-controller="confirm-action"
 * data-confirm-action-message-value="Are you sure?"
 * data-confirm-action-url-value="/invoices/123/archive"
 * data-confirm-action-token-value="csrf_token_value"
 * data-action="click->confirm-action#confirm"
 */
export default class extends Controller {
    static values = {
        message: { type: String, default: 'Are you sure?' },
        url: String,
        token: String,
    };

    confirm(event) {
        event.preventDefault();

        if (!window.confirm(this.messageValue)) {
            return;
        }

        const form = document.createElement('form');
        form.method = 'POST';
        form.action = this.urlValue;
        form.style.display = 'none';

        const tokenInput = document.createElement('input');
        tokenInput.type = 'hidden';
        tokenInput.name = '_token';
        tokenInput.value = this.tokenValue;
        form.appendChild(tokenInput);

        document.body.appendChild(form);
        form.requestSubmit();
    }
}
```

---

## Stimulus Controller — flash auto-dismiss pattern

```javascript
// assets/controllers/flash_controller.js

import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
    connect() {
        // Auto-dismiss after 4 seconds
        this.timeout = setTimeout(() => {
            this.element.style.transition = 'opacity 300ms ease-out';
            this.element.style.opacity = '0';
            setTimeout(() => this.element.remove(), 300);
        }, 4000);
    }

    disconnect() {
        clearTimeout(this.timeout);
    }
}
```

---

## Controller — Turbo detection pattern (PHP)

```php
// Detect whether the request expects a Turbo Stream response:

use Symfony\UX\Turbo\TurboBundle;

// In controller action:
if (TurboBundle::STREAM_FORMAT === $request->getPreferredFormat()) {
    $request->setRequestFormat(TurboBundle::STREAM_FORMAT);
    return $this->render('@Bundle/template/_stream.html.twig', $data);
}

// For non-Turbo requests: redirect or full page render
return $this->redirectToRoute('route_name');
```

---

## Tailwind v4 color conventions

Use Tailwind v4 semantic colors in `@theme` in `assets/styles/app.css`:

```css
@import "tailwindcss";

@theme {
    /* Brand palette */
    --color-brand-50: oklch(97% 0.02 260);
    --color-brand-500: oklch(55% 0.18 260);
    --color-brand-600: oklch(48% 0.18 260);
    --color-brand-700: oklch(40% 0.18 260);

    /* Status colors — used for badges */
    --color-status-draft: oklch(70% 0.04 260);
    --color-status-validated: oklch(65% 0.14 240);
    --color-status-sent: oklch(60% 0.16 220);
    --color-status-paid: oklch(62% 0.14 145);
    --color-status-archived: oklch(70% 0.12 75);
}
```

Status colors in templates use Tailwind utilities, not inline styles.
Use `bg-emerald-*`, `text-emerald-*` etc. Avoid custom inline CSS.

---

## Twig template conventions

- All module templates live in `Resources/views/<domain>/`
- Layout: `Resources/views/layout.html.twig` (or extend app base template)
- Partials (included by other templates) are prefixed with `_`: `_card.html.twig`, `_row.html.twig`
- Each action has its own template file: `list.html.twig`, `show.html.twig`, `edit.html.twig`
- Turbo Stream templates are suffixed with `_stream`: `_archive_stream.html.twig`
- Template namespace is registered as `@BundleAlias` in bundle config
