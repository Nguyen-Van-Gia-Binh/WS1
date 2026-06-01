<!DOCTYPE html>

<html class="light" lang="en"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>AutoWash Pro - Login</title>
<!-- Google Fonts: Plus Jakarta Sans for UI, Material Symbols for Icons -->
<link href="https://fonts.googleapis.com" rel="preconnect"/>
<link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect"/>
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Hanken+Grotesk:wght@400;500;600;700&amp;family=JetBrains+Mono:wght@400;500&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<script id="tailwind-config">
      tailwind.config = {
        darkMode: "class",
        theme: {
          extend: {
            "colors": {
                    "on-primary-container": "#7c839b",
                    "tertiary-fixed": "#ffddb8",
                    "on-background": "#0b1c30",
                    "on-primary-fixed-variant": "#3f465c",
                    "surface-dim": "#cbdbf5",
                    "error-container": "#ffdad6",
                    "surface-container-lowest": "#ffffff",
                    "on-secondary-fixed-variant": "#004e5c",
                    "surface-bright": "#f8f9ff",
                    "on-secondary": "#ffffff",
                    "on-surface-variant": "#45464d",
                    "outline": "#76777d",
                    "on-primary-fixed": "#131b2e",
                    "on-tertiary-fixed-variant": "#653e00",
                    "inverse-surface": "#213145",
                    "surface-variant": "#d3e4fe",
                    "outline-variant": "#c6c6cd",
                    "on-tertiary-fixed": "#2a1700",
                    "on-primary": "#ffffff",
                    "on-error": "#ffffff",
                    "inverse-on-surface": "#eaf1ff",
                    "error": "#ba1a1a",
                    "primary": "#000000",
                    "background": "#f8f9ff",
                    "on-surface": "#0b1c30",
                    "tertiary-container": "#2a1700",
                    "primary-fixed": "#dae2fd",
                    "secondary": "#00687a",
                    "secondary-fixed-dim": "#4cd7f6",
                    "surface-container": "#e5eeff",
                    "tertiary": "#000000",
                    "on-secondary-fixed": "#001f26",
                    "on-error-container": "#93000a",
                    "surface-container-highest": "#d3e4fe",
                    "primary-fixed-dim": "#bec6e0",
                    "inverse-primary": "#bec6e0",
                    "surface": "#f8f9ff",
                    "on-secondary-container": "#006172",
                    "tertiary-fixed-dim": "#ffb95f",
                    "surface-container-low": "#eff4ff",
                    "surface-tint": "#565e74",
                    "surface-container-high": "#dce9ff",
                    "on-tertiary": "#ffffff",
                    "primary-container": "#131b2e",
                    "on-tertiary-container": "#b87500",
                    "secondary-container": "#57dffe",
                    "secondary-fixed": "#acedff"
            },
            "borderRadius": {
                    "DEFAULT": "0.25rem",
                    "lg": "0.5rem",
                    "xl": "0.75rem",
                    "full": "9999px",
                    "2xl": "1rem"
            },
            "spacing": {
                    "container-max-width": "1440px",
                    "sidebar-width": "280px",
                    "gutter": "24px",
                    "stack-sm": "8px",
                    "stack-md": "16px",
                    "margin-mobile": "16px",
                    "stack-lg": "32px",
                    "margin-desktop": "32px"
            },
            "fontFamily": {
                    "title-lg": [
                            "Hanken Grotesk"
                    ],
                    "headline-lg": [
                            "Hanken Grotesk"
                    ],
                    "body-lg": [
                            "Hanken Grotesk"
                    ],
                    "label-sm": [
                            "JetBrains Mono"
                    ],
                    "label-md": [
                            "JetBrains Mono"
                    ],
                    "display": [
                            "Hanken Grotesk"
                    ],
                    "headline-lg-mobile": [
                            "Hanken Grotesk"
                    ],
                    "headline-md": [
                            "Hanken Grotesk"
                    ],
                    "body-md": [
                            "Hanken Grotesk"
                    ]
            },
            "fontSize": {
                    "title-lg": [
                            "20px",
                            {
                                    "lineHeight": "28px",
                                    "fontWeight": "600"
                            }
                    ],
                    "headline-lg": [
                            "32px",
                            {
                                    "lineHeight": "40px",
                                    "letterSpacing": "-0.01em",
                                    "fontWeight": "600"
                            }
                    ],
                    "body-lg": [
                            "18px",
                            {
                                    "lineHeight": "28px",
                                    "fontWeight": "400"
                            }
                    ],
                    "label-sm": [
                            "12px",
                            {
                                    "lineHeight": "16px",
                                    "letterSpacing": "0.05em",
                                    "fontWeight": "500"
                            }
                    ],
                    "label-md": [
                            "14px",
                            {
                                    "lineHeight": "20px",
                                    "letterSpacing": "0.02em",
                                    "fontWeight": "500"
                            }
                    ],
                    "display": [
                            "48px",
                            {
                                    "lineHeight": "56px",
                                    "letterSpacing": "-0.02em",
                                    "fontWeight": "700"
                            }
                    ],
                    "headline-lg-mobile": [
                            "24px",
                            {
                                    "lineHeight": "32px",
                                    "fontWeight": "600"
                            }
                    ],
                    "headline-md": [
                            "24px",
                            {
                                    "lineHeight": "32px",
                                    "fontWeight": "600"
                            }
                    ],
                    "body-md": [
                            "16px",
                            {
                                    "lineHeight": "24px",
                                    "fontWeight": "400"
                            }
                    ]
            }
    },
        },
      }
    </script>
<style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            background-color: #f8f9ff;
        }
        
        /* Typography Overrides to use Plus Jakarta Sans as requested, but falling back to config classes where applicable for structure */
        .font-display { font-family: 'Plus Jakarta Sans', sans-serif; }
        .font-headline-lg { font-family: 'Plus Jakarta Sans', sans-serif; }
        .font-body-md { font-family: 'Plus Jakarta Sans', sans-serif; }
        .font-label-md { font-family: 'Plus Jakarta Sans', sans-serif; }

        .abstract-gradient {
            background: radial-gradient(circle at bottom right, rgba(0, 104, 122, 0.4) 0%, rgba(15, 23, 42, 0) 50%);
        }
    </style>
</head>
<body class="flex flex-col md:flex-row h-screen w-full overflow-hidden text-on-surface bg-background">
<!-- Left Column: Branding (Hidden on mobile, 50% on desktop) -->
<div class="hidden md:flex flex-col w-1/2 bg-[#0F172A] relative overflow-hidden justify-center items-center text-on-primary">
<!-- Abstract gradient mesh -->
<div class="absolute inset-0 abstract-gradient pointer-events-none"></div>
<div class="z-10 text-center px-margin-desktop">
<h1 class="font-display text-display text-on-primary tracking-tight">AutoWash Pro</h1>
<p class="font-body-lg text-body-lg text-primary-fixed-dim mt-stack-md max-w-md mx-auto">
                Industrial-grade automated hardware management. Secure, systematic, and frictionless operations.
            </p>
</div>
<!-- Minimalist decorative element -->
<div class="absolute top-1/4 left-1/4 w-32 h-32 border border-primary-fixed-dim/20 rounded-full opacity-50"></div>
<div class="absolute bottom-1/4 right-1/4 w-64 h-64 border border-secondary/30 rounded-full opacity-30"></div>
</div>
<!-- Right Column: Authentication Card -->
<div class="w-full md:w-1/2 bg-surface-container-lowest flex items-center justify-center p-margin-mobile md:p-margin-desktop relative">
<!-- Main Auth Container -->
<div class="w-full max-w-[440px] bg-surface-container-lowest border border-outline-variant shadow-sm rounded-2xl p-6 md:p-8 flex flex-col gap-stack-lg">
<!-- Header -->
<div class="text-center md:text-left">
<h2 class="font-headline-lg text-headline-lg text-on-background mb-stack-sm">Sign In</h2>
<p class="font-body-md text-body-md text-on-surface-variant">Enter your credentials to access the facility dashboard.</p>
</div>
<!-- Form -->
<form class="flex flex-col gap-stack-md" onsubmit="event.preventDefault();">
<!-- Phone Number Input -->
<div class="flex flex-col gap-stack-sm">
<label class="font-label-md text-label-md text-on-surface" for="phone">Phone Number</label>
<div class="relative">
<span class="absolute left-4 top-1/2 -translate-y-1/2 material-symbols-outlined text-outline-variant select-none pointer-events-none">phone</span>
<input class="w-full pl-12 pr-4 py-3 bg-[#F1F5F9] border-transparent focus:border-secondary focus:bg-surface-container-lowest focus:ring-1 focus:ring-secondary rounded-xl font-body-md text-body-md text-on-surface transition-colors outline-none" id="phone" name="phone" placeholder="(555) 000-0000" type="tel"/>
</div>
</div>
<!-- Password Input -->
<div class="flex flex-col gap-stack-sm">
<label class="font-label-md text-label-md text-on-surface flex justify-between" for="password">
                        Password
                        <a class="text-secondary hover:text-secondary-fixed transition-colors font-medium" href="#">Forgot?</a>
</label>
<div class="relative">
<span class="absolute left-4 top-1/2 -translate-y-1/2 material-symbols-outlined text-outline-variant select-none pointer-events-none">lock</span>
<input class="w-full pl-12 pr-12 py-3 bg-[#F1F5F9] border-transparent focus:border-secondary focus:bg-surface-container-lowest focus:ring-1 focus:ring-secondary rounded-xl font-body-md text-body-md text-on-surface transition-colors outline-none" id="password" name="password" placeholder="••••••••" type="password"/>
<button class="absolute right-4 top-1/2 -translate-y-1/2 text-outline-variant hover:text-on-surface transition-colors" onclick="togglePasswordVisibility()" type="button">
<span class="material-symbols-outlined" id="visibility-icon">visibility_off</span>
</button>
</div>
</div>
<!-- Action Button -->
<button class="w-full mt-stack-sm py-4 bg-secondary hover:bg-on-secondary-fixed-variant text-on-secondary font-label-md text-label-md rounded-xl transition-all active:scale-[0.98] shadow-sm flex items-center justify-center gap-2" type="submit">
                    LOG IN
                    <span class="material-symbols-outlined" style="font-variation-settings: 'FILL' 1;">login</span>
</button>
</form>
<!-- Footer Links -->
<div class="text-center mt-stack-md pt-stack-md border-t border-surface-variant">
<p class="font-body-md text-body-md text-on-surface-variant">
                    New to AutoWash Pro? 
                    <a class="text-secondary font-semibold hover:text-on-secondary-fixed-variant transition-colors ml-1" href="#">Create an account</a>
</p>
</div>
</div>
</div>
<!-- JavaScript for micro-interactions -->
<script>
        function togglePasswordVisibility() {
            const passwordInput = document.getElementById('password');
            const visibilityIcon = document.getElementById('visibility-icon');
            
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                visibilityIcon.textContent = 'visibility';
            } else {
                passwordInput.type = 'password';
                visibilityIcon.textContent = 'visibility_off';
            }
        }
    </script>
</body></html>

<!DOCTYPE html>

<html class="light" lang="en"><head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title>AutoWash Pro - Login</title>
<!-- Google Fonts: Plus Jakarta Sans for UI, Material Symbols for Icons -->
<link href="https://fonts.googleapis.com" rel="preconnect"/>
<link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect"/>
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Hanken+Grotesk:wght@400;500;600;700&amp;family=JetBrains+Mono:wght@400;500&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<script id="tailwind-config">
      tailwind.config = {
        darkMode: "class",
        theme: {
          extend: {
            "colors": {
                    "on-primary-container": "#7c839b",
                    "tertiary-fixed": "#ffddb8",
                    "on-background": "#0b1c30",
                    "on-primary-fixed-variant": "#3f465c",
                    "surface-dim": "#cbdbf5",
                    "error-container": "#ffdad6",
                    "surface-container-lowest": "#ffffff",
                    "on-secondary-fixed-variant": "#004e5c",
                    "surface-bright": "#f8f9ff",
                    "on-secondary": "#ffffff",
                    "on-surface-variant": "#45464d",
                    "outline": "#76777d",
                    "on-primary-fixed": "#131b2e",
                    "on-tertiary-fixed-variant": "#653e00",
                    "inverse-surface": "#213145",
                    "surface-variant": "#d3e4fe",
                    "outline-variant": "#c6c6cd",
                    "on-tertiary-fixed": "#2a1700",
                    "on-primary": "#ffffff",
                    "on-error": "#ffffff",
                    "inverse-on-surface": "#eaf1ff",
                    "error": "#ba1a1a",
                    "primary": "#000000",
                    "background": "#f8f9ff",
                    "on-surface": "#0b1c30",
                    "tertiary-container": "#2a1700",
                    "primary-fixed": "#dae2fd",
                    "secondary": "#00687a",
                    "secondary-fixed-dim": "#4cd7f6",
                    "surface-container": "#e5eeff",
                    "tertiary": "#000000",
                    "on-secondary-fixed": "#001f26",
                    "on-error-container": "#93000a",
                    "surface-container-highest": "#d3e4fe",
                    "primary-fixed-dim": "#bec6e0",
                    "inverse-primary": "#bec6e0",
                    "surface": "#f8f9ff",
                    "on-secondary-container": "#006172",
                    "tertiary-fixed-dim": "#ffb95f",
                    "surface-container-low": "#eff4ff",
                    "surface-tint": "#565e74",
                    "surface-container-high": "#dce9ff",
                    "on-tertiary": "#ffffff",
                    "primary-container": "#131b2e",
                    "on-tertiary-container": "#b87500",
                    "secondary-container": "#57dffe",
                    "secondary-fixed": "#acedff"
            },
            "borderRadius": {
                    "DEFAULT": "0.25rem",
                    "lg": "0.5rem",
                    "xl": "0.75rem",
                    "full": "9999px",
                    "2xl": "1rem"
            },
            "spacing": {
                    "container-max-width": "1440px",
                    "sidebar-width": "280px",
                    "gutter": "24px",
                    "stack-sm": "8px",
                    "stack-md": "16px",
                    "margin-mobile": "16px",
                    "stack-lg": "32px",
                    "margin-desktop": "32px"
            },
            "fontFamily": {
                    "title-lg": [
                            "Hanken Grotesk"
                    ],
                    "headline-lg": [
                            "Hanken Grotesk"
                    ],
                    "body-lg": [
                            "Hanken Grotesk"
                    ],
                    "label-sm": [
                            "JetBrains Mono"
                    ],
                    "label-md": [
                            "JetBrains Mono"
                    ],
                    "display": [
                            "Hanken Grotesk"
                    ],
                    "headline-lg-mobile": [
                            "Hanken Grotesk"
                    ],
                    "headline-md": [
                            "Hanken Grotesk"
                    ],
                    "body-md": [
                            "Hanken Grotesk"
                    ]
            },
            "fontSize": {
                    "title-lg": [
                            "20px",
                            {
                                    "lineHeight": "28px",
                                    "fontWeight": "600"
                            }
                    ],
                    "headline-lg": [
                            "32px",
                            {
                                    "lineHeight": "40px",
                                    "letterSpacing": "-0.01em",
                                    "fontWeight": "600"
                            }
                    ],
                    "body-lg": [
                            "18px",
                            {
                                    "lineHeight": "28px",
                                    "fontWeight": "400"
                            }
                    ],
                    "label-sm": [
                            "12px",
                            {
                                    "lineHeight": "16px",
                                    "letterSpacing": "0.05em",
                                    "fontWeight": "500"
                            }
                    ],
                    "label-md": [
                            "14px",
                            {
                                    "lineHeight": "20px",
                                    "letterSpacing": "0.02em",
                                    "fontWeight": "500"
                            }
                    ],
                    "display": [
                            "48px",
                            {
                                    "lineHeight": "56px",
                                    "letterSpacing": "-0.02em",
                                    "fontWeight": "700"
                            }
                    ],
                    "headline-lg-mobile": [
                            "24px",
                            {
                                    "lineHeight": "32px",
                                    "fontWeight": "600"
                            }
                    ],
                    "headline-md": [
                            "24px",
                            {
                                    "lineHeight": "32px",
                                    "fontWeight": "600"
                            }
                    ],
                    "body-md": [
                            "16px",
                            {
                                    "lineHeight": "24px",
                                    "fontWeight": "400"
                            }
                    ]
            }
    },
        },
      }
    </script>
<style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            background-color: #f8f9ff;
        }
        
        /* Typography Overrides to use Plus Jakarta Sans as requested, but falling back to config classes where applicable for structure */
        .font-display { font-family: 'Plus Jakarta Sans', sans-serif; }
        .font-headline-lg { font-family: 'Plus Jakarta Sans', sans-serif; }
        .font-body-md { font-family: 'Plus Jakarta Sans', sans-serif; }
        .font-label-md { font-family: 'Plus Jakarta Sans', sans-serif; }

        .abstract-gradient {
            background: radial-gradient(circle at bottom right, rgba(0, 104, 122, 0.4) 0%, rgba(15, 23, 42, 0) 50%);
        }
    </style>
</head>
<body class="flex flex-col md:flex-row h-screen w-full overflow-hidden text-on-surface bg-background">
<!-- Left Column: Branding (Hidden on mobile, 50% on desktop) -->
<div class="hidden md:flex flex-col w-1/2 bg-[#0F172A] relative overflow-hidden justify-center items-center text-on-primary">
<!-- Abstract gradient mesh -->
<div class="absolute inset-0 abstract-gradient pointer-events-none"></div>
<div class="z-10 text-center px-margin-desktop">
<h1 class="font-display text-display text-on-primary tracking-tight">AutoWash Pro</h1>
<p class="font-body-lg text-body-lg text-primary-fixed-dim mt-stack-md max-w-md mx-auto">
                Industrial-grade automated hardware management. Secure, systematic, and frictionless operations.
            </p>
</div>
<!-- Minimalist decorative element -->
<div class="absolute top-1/4 left-1/4 w-32 h-32 border border-primary-fixed-dim/20 rounded-full opacity-50"></div>
<div class="absolute bottom-1/4 right-1/4 w-64 h-64 border border-secondary/30 rounded-full opacity-30"></div>
</div>
<!-- Right Column: Authentication Card -->
<div class="w-full md:w-1/2 bg-surface-container-lowest flex items-center justify-center p-margin-mobile md:p-margin-desktop relative">
<!-- Main Auth Container -->
<div class="w-full max-w-[440px] bg-surface-container-lowest border border-outline-variant shadow-sm rounded-2xl p-6 md:p-8 flex flex-col gap-stack-lg">
<!-- Header -->
<div class="text-center md:text-left">
<h2 class="font-headline-lg text-headline-lg text-on-background mb-stack-sm">Sign In</h2>
<p class="font-body-md text-body-md text-on-surface-variant">Enter your credentials to access the facility dashboard.</p>
</div>
<!-- Form -->
<form class="flex flex-col gap-stack-md" onsubmit="event.preventDefault();">
<!-- Phone Number Input -->
<div class="flex flex-col gap-stack-sm">
<label class="font-label-md text-label-md text-on-surface" for="phone">Phone Number</label>
<div class="relative">
<span class="absolute left-4 top-1/2 -translate-y-1/2 material-symbols-outlined text-outline-variant select-none pointer-events-none">phone</span>
<input class="w-full pl-12 pr-4 py-3 bg-[#F1F5F9] border-transparent focus:border-secondary focus:bg-surface-container-lowest focus:ring-1 focus:ring-secondary rounded-xl font-body-md text-body-md text-on-surface transition-colors outline-none" id="phone" name="phone" placeholder="(555) 000-0000" type="tel"/>
</div>
</div>
<!-- Password Input -->
<div class="flex flex-col gap-stack-sm">
<label class="font-label-md text-label-md text-on-surface flex justify-between" for="password">
                        Password
                        <a class="text-secondary hover:text-secondary-fixed transition-colors font-medium" href="#">Forgot?</a>
</label>
<div class="relative">
<span class="absolute left-4 top-1/2 -translate-y-1/2 material-symbols-outlined text-outline-variant select-none pointer-events-none">lock</span>
<input class="w-full pl-12 pr-12 py-3 bg-[#F1F5F9] border-transparent focus:border-secondary focus:bg-surface-container-lowest focus:ring-1 focus:ring-secondary rounded-xl font-body-md text-body-md text-on-surface transition-colors outline-none" id="password" name="password" placeholder="••••••••" type="password"/>
<button class="absolute right-4 top-1/2 -translate-y-1/2 text-outline-variant hover:text-on-surface transition-colors" onclick="togglePasswordVisibility()" type="button">
<span class="material-symbols-outlined" id="visibility-icon">visibility_off</span>
</button>
</div>
</div>
<!-- Action Button -->
<button class="w-full mt-stack-sm py-4 bg-secondary hover:bg-on-secondary-fixed-variant text-on-secondary font-label-md text-label-md rounded-xl transition-all active:scale-[0.98] shadow-sm flex items-center justify-center gap-2" type="submit">
                    LOG IN
                    <span class="material-symbols-outlined" style="font-variation-settings: 'FILL' 1;">login</span>
</button>
</form>
<!-- Footer Links -->
<div class="text-center mt-stack-md pt-stack-md border-t border-surface-variant">
<p class="font-body-md text-body-md text-on-surface-variant">
                    New to AutoWash Pro? 
                    <a class="text-secondary font-semibold hover:text-on-secondary-fixed-variant transition-colors ml-1" href="#">Create an account</a>
</p>
</div>
</div>
</div>
<!-- JavaScript for micro-interactions -->
<script>
        function togglePasswordVisibility() {
            const passwordInput = document.getElementById('password');
            const visibilityIcon = document.getElementById('visibility-icon');
            
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                visibilityIcon.textContent = 'visibility';
            } else {
                passwordInput.type = 'password';
                visibilityIcon.textContent = 'visibility_off';
            }
        }
    </script>
</body></html>

<!DOCTYPE html><html class="h-full bg-slate-50 antialiased dark:bg-slate-900" lang="en"><head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<title>Dashboard - Hydro-Precision</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Hanken+Grotesk:wght@400;500;600;700&amp;family=JetBrains+Mono:wght@400;500&amp;display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet">
<script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    "colors": {
                        "on-tertiary-container": "#b87500",
                        "tertiary-container": "#2a1700",
                        "on-tertiary-fixed-variant": "#653e00",
                        "inverse-surface": "#213145",
                        "secondary-container": "#57dffe",
                        "tertiary-fixed": "#ffddb8",
                        "surface-container": "#e5eeff",
                        "on-tertiary": "#ffffff",
                        "surface-container-lowest": "#ffffff",
                        "on-secondary-fixed": "#001f26",
                        "outline-variant": "#c6c6cd",
                        "inverse-primary": "#bec6e0",
                        "primary": "#000000",
                        "inverse-on-surface": "#eaf1ff",
                        "secondary": "#00687a",
                        "surface-container-highest": "#d3e4fe",
                        "on-background": "#0b1c30",
                        "error-container": "#ffdad6",
                        "surface-bright": "#f8f9ff",
                        "surface-dim": "#cbdbf5",
                        "surface-container-high": "#dce9ff",
                        "on-primary-fixed-variant": "#3f465c",
                        "on-secondary-fixed-variant": "#004e5c",
                        "surface-variant": "#d3e4fe",
                        "surface": "#f8f9ff",
                        "secondary-fixed-dim": "#4cd7f6",
                        "on-surface-variant": "#45464d",
                        "tertiary": "#000000",
                        "on-surface": "#0b1c30",
                        "on-primary-fixed": "#131b2e",
                        "surface-tint": "#565e74",
                        "on-secondary-container": "#006172",
                        "on-error-container": "#93000a",
                        "surface-container-low": "#eff4ff",
                        "tertiary-fixed-dim": "#ffb95f",
                        "outline": "#76777d",
                        "on-error": "#ffffff",
                        "primary-fixed": "#dae2fd",
                        "on-primary-container": "#7c839b",
                        "secondary-fixed": "#acedff",
                        "error": "#ba1a1a",
                        "primary-container": "#131b2e",
                        "on-primary": "#ffffff",
                        "background": "#f8f9ff",
                        "on-tertiary-fixed": "#2a1700",
                        "primary-fixed-dim": "#bec6e0",
                        "on-secondary": "#ffffff"
                    },
                    "borderRadius": {
                        "DEFAULT": "0.25rem",
                        "lg": "0.5rem",
                        "xl": "0.75rem",
                        "2xl": "1rem",
                        "full": "9999px"
                    },
                    "spacing": {
                        "sidebar-width": "280px",
                        "gutter": "24px",
                        "container-max-width": "1440px",
                        "margin-mobile": "16px",
                        "margin-desktop": "32px",
                        "stack-md": "16px",
                        "stack-sm": "8px",
                        "stack-lg": "32px"
                    },
                    "fontFamily": {
                        "body-md": ["Hanken Grotesk"],
                        "label-sm": ["JetBrains Mono"],
                        "headline-lg-mobile": ["Hanken Grotesk"],
                        "label-md": ["JetBrains Mono"],
                        "display": ["Hanken Grotesk"],
                        "headline-lg": ["Hanken Grotesk"],
                        "title-lg": ["Hanken Grotesk"],
                        "headline-md": ["Hanken Grotesk"],
                        "body-lg": ["Hanken Grotesk"]
                    },
                    "fontSize": {
                        "body-md": ["16px", { "lineHeight": "24px", "fontWeight": "400" }],
                        "label-sm": ["12px", { "lineHeight": "16px", "letterSpacing": "0.05em", "fontWeight": "500" }],
                        "headline-lg-mobile": ["24px", { "lineHeight": "32px", "fontWeight": "600" }],
                        "label-md": ["14px", { "lineHeight": "20px", "letterSpacing": "0.02em", "fontWeight": "500" }],
                        "display": ["48px", { "lineHeight": "56px", "letterSpacing": "-0.02em", "fontWeight": "700" }],
                        "headline-lg": ["32px", { "lineHeight": "40px", "letterSpacing": "-0.01em", "fontWeight": "600" }],
                        "title-lg": ["20px", { "lineHeight": "28px", "fontWeight": "600" }],
                        "headline-md": ["24px", { "lineHeight": "32px", "fontWeight": "600" }],
                        "body-lg": ["18px", { "lineHeight": "28px", "fontWeight": "400" }]
                    }
                }
            }
        }
    </script>
<style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }
        .material-symbols-outlined.fill {
            font-variation-settings: 'FILL' 1;
        }
    </style>
</head>
<body class="bg-background text-on-background font-body-md text-body-md">
<!-- SideNavBar (Shared Component) -->
<aside class="fixed left-0 top-0 h-full w-sidebar-width bg-primary-container dark:bg-primary-container border-r border-outline-variant shadow-md flex flex-col py-8 z-50">
<div class="px-gutter mb-8">
<div class="flex items-center gap-3">
<div>
<h1 class="font-headline-md text-headline-md font-bold text-on-primary dark:text-on-primary">Hydro-Precision</h1>
<p class="font-label-sm text-label-sm text-on-primary-container">Customer Portal</p>
</div>
</div>
</div>
<nav class="flex-1 px-4 space-y-2 flex flex-col"><div class="flex-1 space-y-2"><!-- Active Tab --><a class="flex items-center gap-3 px-4 py-3 text-secondary-fixed border-l-4 border-secondary-fixed bg-on-primary-fixed-variant/10 rounded-r-lg cursor-pointer active:scale-95 duration-200" href="#"><span class="material-symbols-outlined fill" data-icon="dashboard">dashboard</span><span class="font-label-md text-label-md">Dashboard</span></a><!-- Inactive Tabs --><a class="flex items-center gap-3 px-4 py-3 text-on-primary-container/70 hover:text-on-primary-container hover:bg-on-primary-fixed-variant/5 transition-colors rounded-r-lg cursor-pointer active:scale-95 duration-200" href="#"><span class="material-symbols-outlined" data-icon="calendar_month">calendar_month</span><span class="font-label-md text-label-md">Booking</span></a><a class="flex items-center gap-3 px-4 py-3 text-on-primary-container/70 hover:text-on-primary-container hover:bg-on-primary-fixed-variant/5 transition-colors rounded-r-lg cursor-pointer active:scale-95 duration-200" href="#"><span class="material-symbols-outlined" data-icon="directions_car">directions_car</span><span class="font-label-md text-label-md">My Cars</span></a><a class="flex items-center gap-3 px-4 py-3 text-on-primary-container/70 hover:text-on-primary-container hover:bg-on-primary-fixed-variant/5 transition-colors rounded-r-lg cursor-pointer active:scale-95 duration-200" href="#"><span class="material-symbols-outlined" data-icon="notifications">notifications</span><span class="font-label-md text-label-md">Notifications</span></a></div><div class="mt-auto pt-4 space-y-2 border-t border-outline-variant/20"><a class="flex items-center gap-3 px-4 py-3 text-on-primary-container/70 hover:text-on-primary-container hover:bg-on-primary-fixed-variant/5 transition-colors rounded-r-lg cursor-pointer active:scale-95 duration-200" href="#"><span class="material-symbols-outlined" data-icon="settings">settings</span><span class="font-label-md text-label-md">Settings</span></a><a class="flex items-center gap-3 px-4 py-3 text-on-primary-container/70 hover:text-on-primary-container hover:bg-on-primary-fixed-variant/5 transition-colors rounded-r-lg cursor-pointer active:scale-95 duration-200" href="#"><span class="material-symbols-outlined" data-icon="help">help</span><span class="font-label-md text-label-md">Support</span></a></div></nav>
</aside>
<!-- TopNavBar (Shared Component - Integrated loosely as requested) -->
<header class="fixed top-0 right-0 w-[calc(100%-280px)] h-16 bg-surface/80 backdrop-blur-md shadow-sm z-40 flex justify-between items-center px-gutter">
<div class="flex items-center gap-2 text-on-surface-variant font-label-md text-label-md">
<span class="">Portal</span>
<span class="material-symbols-outlined text-[16px]">chevron_right</span>
<span class="text-secondary font-bold">Dashboard</span>
</div>
<div class="flex items-center gap-4">
<button class="text-on-surface-variant hover:text-secondary transition-colors">
<span class="material-symbols-outlined" data-icon="notifications">notifications</span>
</button>
<button class="text-on-surface-variant hover:text-secondary transition-colors">
<span class="material-symbols-outlined" data-icon="help">help</span>
</button>
<div class="w-8 h-8 rounded-full overflow-hidden bg-surface-variant border border-outline-variant cursor-pointer active:opacity-80">
<img alt="User Profile" class="w-full h-full object-cover" data-alt="A professional headshot of an individual in a modern, well-lit environment. The lighting is soft and neutral, typical of a corporate profile picture. The background is slightly blurred to focus on the person, fitting seamlessly into a clean, light-mode dashboard interface." src="https://lh3.googleusercontent.com/aida-public/AB6AXuDsTUAoeYSJJxnNhy-4fGlDI5huIRUjNIWFO960EzChXZ3FsR247wzDLNyW9t9g9oTGur6Td6nmCEXrwIdXojrvbbECwelHMr4wyPTjYFI_7QjOUslGn1wI4J4j8cmYikipYZ5fX0jchPJjaHBEyDpj86Hl9uTOv7OyFndOoIVM8ugfbAhe3N1_XJZvU4yuzSmU0dlmF1rZRKeIEHiBS760GKJKfo-6lkBg7-m7LqK6boco21QdLJb7D6Sn6p1gWaHBXqcTl9GNlDtZ">
</div>
</div>
</header>
<!-- Main Content -->
<main class="ml-sidebar-width pt-16 min-h-screen p-margin-desktop">
<div class="max-w-container-max-width mx-auto">
<div class="grid grid-cols-1 lg:grid-cols-12 gap-gutter">
<!-- Left Column (Wide) -->
<div class="lg:col-span-8 flex flex-col gap-gutter">
<!-- Welcome Card -->
<div class="relative overflow-hidden rounded-2xl bg-primary-container text-on-primary shadow-sm h-[200px] flex items-center p-8 group">
<!-- Abstract Tech Background -->
<div class="absolute inset-0 z-0 opacity-20 group-hover:opacity-30 transition-opacity duration-700" style="background-image: url(&quot;https://lh3.googleusercontent.com/aida-public/AB6AXuAq_hagSFzyCAqyb_WqxTQchyOvkGhlmG9ZFLbNB7HhY4P7G74PfZJBgfgq6MY3I32s6hJTV4W1E9iboCALA2bfYhL60ilB2tQve0BGyWxKRsk2YVDgK7--zV3Pjv845F-0PLT63R907Y_8noFY0sJs5GhOHDu5whDynOazqxHcYoRVhMJXx_9XTc-21vBBYhmUaUFkzdGRi8pdm0gb8gxFc85WrGpiY8q3McC13DN1sD1Fy0p5wvynzm6-cu9a5KM9avjndjqJR-6s&quot;); background-size: cover; background-position: center center;"></div>
<div class="absolute inset-0 z-0 bg-gradient-to-r from-primary-container via-primary-container/80 to-transparent"></div>
<div class="relative z-10">
<h2 class="font-display text-display mb-2">Chào Bình,</h2>
<p class="font-body-lg text-body-lg text-primary-fixed-dim">Hệ thống đang hoạt động ổn định. Có 1 lịch trình sắp tới.</p>
</div>
</div>
<!-- Upcoming Booking Card -->
<div class="bg-surface rounded-2xl shadow-sm border border-slate-200 p-6 flex flex-col sm:flex-row items-center gap-6">
<div class="w-16 h-16 rounded-xl bg-surface-container flex items-center justify-center shrink-0">
<span class="material-symbols-outlined text-3xl text-secondary">local_car_wash</span>
</div>
<div class="flex-1 w-full text-center sm:text-left">
<h3 class="font-title-lg text-title-lg text-on-surface mb-1">Upcoming Booking</h3>
<div class="flex flex-wrap items-center justify-center sm:justify-start gap-4 font-body-md text-on-surface-variant">
<span class="flex items-center gap-1"><span class="material-symbols-outlined text-[18px]">directions_car</span> Biển số: <strong class="text-on-surface font-label-md">30A-999.99</strong></span>
<span class="hidden sm:inline text-outline-variant">•</span>
<span class="flex items-center gap-1"><span class="material-symbols-outlined text-[18px]">event</span> Ngày mai, 09:00</span>
</div>
</div>
<div class="shrink-0 flex flex-col items-center sm:items-end gap-2">
<span class="px-3 py-1 bg-surface-container-high text-on-surface font-label-sm text-label-sm uppercase rounded-full border border-outline-variant">Pending</span>
<button class="text-secondary font-label-md text-label-md hover:underline">View Details</button>
</div>
</div>
</div>
<!-- Right Column (Narrow) -->
<div class="lg:col-span-4 flex flex-col gap-gutter">
<!-- Reward Wallet Card -->
<div class="bg-surface rounded-2xl shadow-sm border border-slate-200 p-6 relative overflow-hidden">
<div class="absolute -right-8 -top-8 w-32 h-32 bg-secondary/5 rounded-full blur-2xl pointer-events-none"></div>
<div class="flex justify-between items-start mb-4">
<h3 class="font-title-lg text-title-lg text-on-surface">Reward Wallet</h3>
<span class="material-symbols-outlined text-secondary">account_balance_wallet</span>
</div>
<div class="mb-1">
<span class="font-headline-lg text-headline-lg text-on-surface">1.500</span>
<span class="font-label-md text-label-md text-on-surface-variant">Điểm</span>
</div>
<p class="font-body-md text-body-md text-on-surface-variant">~ 150.000 VNĐ</p>
</div>
<!-- Next Reward Card -->
<div class="bg-surface rounded-2xl shadow-sm border border-slate-200 p-6">
<div class="flex justify-between items-center mb-6">
<h3 class="font-title-lg text-title-lg text-on-surface">Next Reward</h3>
<span class="material-symbols-outlined text-secondary">workspace_premium</span>
</div>
<div class="mb-4">
<div class="flex justify-between font-label-md text-label-md mb-2">
<span class="text-on-surface-variant">Current: Gold</span>
<span class="text-secondary font-bold">Target: Platinum</span>
</div>
<div class="h-3 w-full bg-surface-container rounded-full overflow-hidden">
<div class="h-full bg-gradient-to-r from-secondary to-blue-500 w-[50%] rounded-full shadow-[0_0_10px_rgba(0,104,122,0.5)]"></div>
</div>
</div>
<p class="font-body-md text-body-md text-on-surface-variant leading-relaxed">
                            Bạn chỉ còn cách hạng <strong class="text-on-surface">Platinum</strong> 15 lượt rửa hoặc 9M VNĐ nữa!
                        </p>
<button class="mt-4 w-full py-2 border border-secondary text-secondary font-label-md text-label-md rounded-xl hover:bg-secondary/5 transition-colors">
                            Learn more
                        </button>
</div>
</div>
</div>
</div>
</main>


</body></html>

<!DOCTYPE html><html lang="en"><head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<title>My Cars - Hydro-Precision</title>
<!-- Fonts & Icons -->
<link href="https://fonts.googleapis.com" rel="preconnect">
<link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect">
<link href="https://fonts.googleapis.com/css2?family=Hanken+Grotesk:wght@400;600;700&amp;family=JetBrains+Mono:wght@500&amp;display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet">
<!-- Tailwind CSS -->
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<!-- Tailwind Configuration -->
<script id="tailwind-config">
      tailwind.config = {
        darkMode: "class",
        theme: {
          extend: {
            "colors": {
                    "on-tertiary-container": "#b87500",
                    "tertiary-container": "#2a1700",
                    "on-tertiary-fixed-variant": "#653e00",
                    "inverse-surface": "#213145",
                    "secondary-container": "#57dffe",
                    "tertiary-fixed": "#ffddb8",
                    "surface-container": "#e5eeff",
                    "on-tertiary": "#ffffff",
                    "surface-container-lowest": "#ffffff",
                    "on-secondary-fixed": "#001f26",
                    "outline-variant": "#c6c6cd",
                    "inverse-primary": "#bec6e0",
                    "primary": "#000000",
                    "inverse-on-surface": "#eaf1ff",
                    "secondary": "#00687a",
                    "surface-container-highest": "#d3e4fe",
                    "on-background": "#0b1c30",
                    "error-container": "#ffdad6",
                    "surface-bright": "#f8f9ff",
                    "surface-dim": "#cbdbf5",
                    "surface-container-high": "#dce9ff",
                    "on-primary-fixed-variant": "#3f465c",
                    "on-secondary-fixed-variant": "#004e5c",
                    "surface-variant": "#d3e4fe",
                    "surface": "#f8f9ff",
                    "secondary-fixed-dim": "#4cd7f6",
                    "on-surface-variant": "#45464d",
                    "tertiary": "#000000",
                    "on-surface": "#0b1c30",
                    "on-primary-fixed": "#131b2e",
                    "surface-tint": "#565e74",
                    "on-secondary-container": "#006172",
                    "on-error-container": "#93000a",
                    "surface-container-low": "#eff4ff",
                    "tertiary-fixed-dim": "#ffb95f",
                    "outline": "#76777d",
                    "on-error": "#ffffff",
                    "primary-fixed": "#dae2fd",
                    "on-primary-container": "#7c839b",
                    "secondary-fixed": "#acedff",
                    "error": "#ba1a1a",
                    "primary-container": "#131b2e",
                    "on-primary": "#ffffff",
                    "background": "#f8f9ff",
                    "on-tertiary-fixed": "#2a1700",
                    "primary-fixed-dim": "#bec6e0",
                    "on-secondary": "#ffffff"
            },
            "borderRadius": {
                    "DEFAULT": "0.25rem",
                    "lg": "0.5rem",
                    "xl": "0.75rem",
                    "full": "9999px"
            },
            "spacing": {
                    "sidebar-width": "280px",
                    "gutter": "24px",
                    "container-max-width": "1440px",
                    "margin-mobile": "16px",
                    "margin-desktop": "32px",
                    "stack-md": "16px",
                    "stack-sm": "8px",
                    "stack-lg": "32px"
            },
            "fontFamily": {
                    "body-md": ["Hanken Grotesk"],
                    "label-sm": ["JetBrains Mono"],
                    "headline-lg-mobile": ["Hanken Grotesk"],
                    "label-md": ["JetBrains Mono"],
                    "display": ["Hanken Grotesk"],
                    "headline-lg": ["Hanken Grotesk"],
                    "title-lg": ["Hanken Grotesk"],
                    "headline-md": ["Hanken Grotesk"],
                    "body-lg": ["Hanken Grotesk"]
            },
            "fontSize": {
                    "body-md": ["16px", {"lineHeight": "24px", "fontWeight": "400"}],
                    "label-sm": ["12px", {"lineHeight": "16px", "letterSpacing": "0.05em", "fontWeight": "500"}],
                    "headline-lg-mobile": ["24px", {"lineHeight": "32px", "fontWeight": "600"}],
                    "label-md": ["14px", {"lineHeight": "20px", "letterSpacing": "0.02em", "fontWeight": "500"}],
                    "display": ["48px", {"lineHeight": "56px", "letterSpacing": "-0.02em", "fontWeight": "700"}],
                    "headline-lg": ["32px", {"lineHeight": "40px", "letterSpacing": "-0.01em", "fontWeight": "600"}],
                    "title-lg": ["20px", {"lineHeight": "28px", "fontWeight": "600"}],
                    "headline-md": ["24px", {"lineHeight": "32px", "fontWeight": "600"}],
                    "body-lg": ["18px", {"lineHeight": "28px", "fontWeight": "400"}]
            }
          },
        },
      }
    </script>
<style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }
        .icon-fill {
            font-variation-settings: 'FILL' 1;
        }
    </style>
</head>
<body class="bg-background text-on-background font-body-md text-body-md antialiased min-h-screen flex">
<!-- Shared Component: SideNavBar -->
<nav class="fixed left-0 top-0 h-full w-sidebar-width bg-primary-container dark:bg-primary-container border-r border-outline-variant shadow-md flex flex-col py-8 z-50">
<!-- Brand / Header -->
<div class="px-6 mb-10 flex flex-col gap-1">
<h1 class="font-headline-md text-headline-md font-bold text-on-primary dark:text-on-primary">HYDRO-PRECISION</h1>
</div>
<!-- Navigation Tabs -->
<div class="flex-1 flex flex-col">
<!-- Inactive: Dashboard -->
<a class="flex items-center gap-3 px-6 py-3 text-on-primary-container/70 hover:text-on-primary-container hover:bg-on-primary-fixed-variant/5 transition-colors cursor-pointer active:scale-95 duration-200" href="#">
<span class="material-symbols-outlined">dashboard</span>
<span class="font-body-md text-body-md">Dashboard</span>
</a>
<!-- Inactive: Booking -->
<a class="flex items-center gap-3 px-6 py-3 text-on-primary-container/70 hover:text-on-primary-container hover:bg-on-primary-fixed-variant/5 transition-colors cursor-pointer active:scale-95 duration-200" href="#">
<span class="material-symbols-outlined">calendar_month</span>
<span class="font-body-md text-body-md">Booking</span>
</a>
<!-- Active: My Cars -->
<a class="flex items-center gap-3 px-6 py-3 text-secondary-fixed border-l-4 border-secondary-fixed bg-on-primary-fixed-variant/10 cursor-pointer active:scale-95 duration-200" href="#">
<span class="material-symbols-outlined icon-fill">directions_car</span>
<span class="font-body-md text-body-md font-bold">My Cars</span>
</a>
<!-- Inactive: Notifications -->
<a class="flex items-center gap-3 px-6 py-3 text-on-primary-container/70 hover:text-on-primary-container hover:bg-on-primary-fixed-variant/5 transition-colors cursor-pointer active:scale-95 duration-200" href="#">
<span class="material-symbols-outlined">notifications</span>
<span class="font-body-md text-body-md">Notifications</span>
</a>
<div class="mt-auto mb-4 border-t border-outline-variant/30 pt-4">
<a class="flex items-center gap-3 px-6 py-3 text-on-primary-container/70 hover:text-on-primary-container hover:bg-on-primary-fixed-variant/5 transition-colors cursor-pointer active:scale-95 duration-200" href="#">
<span class="material-symbols-outlined">settings</span>
<span class="font-body-md text-body-md">Settings</span>
</a>
<a class="flex items-center gap-3 px-6 py-3 text-on-primary-container/70 hover:text-on-primary-container hover:bg-on-primary-fixed-variant/5 transition-colors cursor-pointer active:scale-95 duration-200" href="#">
<span class="material-symbols-outlined">help_outline</span>
<span class="font-body-md text-body-md">Support</span>
</a>
</div></div>
<!-- CTA -->
</nav>
<!-- Shared Component: TopNavBar (Adapted for specific prompt context) -->
<header class="fixed top-0 right-0 w-[calc(100%-280px)] h-16 bg-surface/80 backdrop-blur-md shadow-sm flex justify-between items-center px-gutter z-40 border-b border-outline-variant/30">
<!-- Left: Breadcrumbs -->
<div class="flex items-center gap-2 text-on-surface-variant font-label-md text-label-md">
<a class="hover:text-secondary transition-colors" href="#">Portal</a>
<span class="material-symbols-outlined text-[16px]">chevron_right</span>
<span class="text-on-surface font-bold">My Cars</span>
</div>
<!-- Right: Actions & Profile -->
<div class="flex items-center gap-4">
<button class="text-on-surface-variant hover:text-secondary transition-colors w-10 h-10 flex items-center justify-center rounded-full hover:bg-surface-variant/50">
<span class="material-symbols-outlined">notifications</span>
</button>
<button class="text-on-surface-variant hover:text-secondary transition-colors w-10 h-10 flex items-center justify-center rounded-full hover:bg-surface-variant/50">
<span class="material-symbols-outlined">help</span>
</button>
<div class="w-8 h-8 rounded-full bg-surface-variant overflow-hidden border border-outline-variant/50 ml-2 shadow-sm cursor-pointer hover:opacity-80 transition-opacity">
<!-- Profile Avatar Placeholder -->
<img alt="User Profile" class="w-full h-full object-cover" src="https://lh3.googleusercontent.com/aida-public/AB6AXuBBPhW44S6oOBjICOVlkOG9DkkwceXEkXLlS00c9jmdxrTC-8GAwOss76ixlgD6GqvlIFWlz_CzPX1zptcL7okgdYw_Cy8vbSvlCh4DkEuPujpcAtq6EBdtOFHMI_46uuhptA1mJeAZT77WNknHtkq__dbjUmboQk0mCypZLDD_b5ZBkA4JHAf40idOzD6CIyqT7jnS-8tPIIIEClcEcWD3APCD8dmelJKM3FWyeskCoGBxPe62hse85c9KQekMvVl5wZrxc5gqCCTT">
</div>
</div>
</header>
<!-- Main Content Canvas -->
<main class="ml-[280px] mt-16 flex-1 p-margin-desktop bg-background min-h-[calc(100vh-64px)] overflow-y-auto">
<div class="max-w-container-max-width mx-auto">
<!-- Page Header Row -->
<div class="flex justify-between items-end mb-8">
<div>
<h2 class="font-display text-display text-on-surface">My Fleet</h2>
<p class="font-body-lg text-body-lg text-on-surface-variant mt-2">Manage your registered vehicles and active wash plans.</p>
</div>
<button class="bg-secondary text-on-secondary font-label-md text-label-md px-5 py-3 rounded-xl hover:bg-on-secondary-container hover:text-secondary-fixed transition-colors shadow-md flex items-center gap-2">
<span class="material-symbols-outlined text-[18px]">add</span>
                    + Đăng ký xe mới
                </button>
</div>
<!-- Vehicle Grid (Bento/Card Style) -->
<div class="grid grid-cols-1 lg:grid-cols-2 xl:grid-cols-3 gap-gutter">
<!-- Card 1: VinFast VF8 -->
<article class="bg-surface border border-outline-variant rounded-xl shadow-sm hover:shadow-md transition-shadow duration-300 overflow-hidden flex flex-col group relative">
<!-- Status Badge -->
<div class="absolute top-4 right-4 z-10 bg-primary-fixed text-on-primary-fixed px-3 py-1.5 rounded-full font-label-sm text-label-sm uppercase flex items-center gap-1.5 shadow-sm backdrop-blur-md bg-opacity-90">
<span class="w-2 h-2 rounded-full bg-secondary"></span>
                        ACTIVE
                    </div>
<!-- Image Area -->
<div class="relative h-56 bg-surface-variant overflow-hidden">
<img alt="A sleek, modern electric SUV parked in a minimalist, well-lit indoor facility with polished concrete floors. The vehicle features smooth aerodynamic lines and is bathed in cool, high-key white lighting, emphasizing an advanced industrial tech aesthetic. The overall mood is clean, pristine, and sophisticated, perfectly matching a premium automated service environment." class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-700 ease-out" data-alt="A sleek, modern electric SUV parked in a minimalist, well-lit indoor facility with polished concrete floors. The vehicle features smooth aerodynamic lines and is bathed in cool, high-key white lighting, emphasizing an advanced industrial tech aesthetic. The overall mood is clean, pristine, and sophisticated, perfectly matching a premium automated service environment." src="https://lh3.googleusercontent.com/aida-public/AB6AXuCjqdpi_KRm2KwxXfVbPa3FCbEKgtWUWNKlZbGgmVz_9Nq5Z_4pTg_6gpxQmimh8UrSxznDeTV5mpYjqEtNYtJjWH9F2TlHOQFlZIR6i1eFGnpXZnIazbikFSZEiouseM7RtjyHVB9RyCfz-vcrc3AKPdT1FXiGfthADJYeh2ZbKzJLu95sJ_mQFo8CSHVObP0YGzrRGVCYPwEvy2_9uIyJFUVREYK0YBa-W1b73c5owVCNWk8XEEUHm-uZf6SsMKccG4fVtHQ6kOOw">
<div class="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent"></div>
<div class="absolute bottom-4 left-4">
<div class="font-label-md text-label-md text-surface-container-highest uppercase tracking-wider mb-1">License Plate</div>
<div class="font-headline-md text-headline-md text-on-primary bg-primary/40 backdrop-blur-md px-3 py-1 rounded-lg border border-white/20 inline-block font-mono tracking-widest">
                                30H - 123.45
                            </div>
</div>
</div>
<!-- Content Area -->
<div class="p-6 flex flex-col flex-1 gap-6">
<div>
<h3 class="font-title-lg text-title-lg text-on-surface mb-1">VinFast VF8</h3>
<p class="font-body-md text-body-md text-on-surface-variant flex items-center gap-1">
<span class="material-symbols-outlined text-[16px]">electric_car</span> Electric SUV
                            </p>
</div>
<!-- Plan Details (Glassmorphism touch) -->
<div class="mt-auto bg-surface-container-low rounded-lg border border-outline-variant/50 p-4 flex items-center justify-between">
<div>
<span class="font-label-sm text-label-sm text-on-surface-variant uppercase block mb-1">Current Plan</span>
<span class="font-headline-md text-headline-md text-secondary">Premium Wash</span>
</div>
<div class="w-12 h-12 rounded-full bg-secondary-container text-on-secondary-container flex items-center justify-center">
<span class="material-symbols-outlined icon-fill">water_drop</span>
</div>
</div>
</div>
</article>
<!-- Card 2: Toyota Camry -->
<article class="bg-surface border border-outline-variant rounded-xl shadow-sm hover:shadow-md transition-shadow duration-300 overflow-hidden flex flex-col group relative">
<!-- Status Badge -->
<div class="absolute top-4 right-4 z-10 bg-primary-fixed text-on-primary-fixed px-3 py-1.5 rounded-full font-label-sm text-label-sm uppercase flex items-center gap-1.5 shadow-sm backdrop-blur-md bg-opacity-90">
<span class="w-2 h-2 rounded-full bg-secondary"></span>
                        ACTIVE
                    </div>
<!-- Image Area -->
<div class="relative h-56 bg-surface-variant overflow-hidden">
<img alt="A luxurious silver sedan positioned dynamically in an ultra-clean, modern service bay. High-contrast lighting highlights the reflective metallic paint and sharp body contours against a muted, slate-toned architectural background. The scene conveys precision, professional maintenance, and a high-end corporate automotive atmosphere." class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-700 ease-out" data-alt="A luxurious silver sedan positioned dynamically in an ultra-clean, modern service bay. High-contrast lighting highlights the reflective metallic paint and sharp body contours against a muted, slate-toned architectural background. The scene conveys precision, professional maintenance, and a high-end corporate automotive atmosphere." src="https://lh3.googleusercontent.com/aida-public/AB6AXuB2hHBYIu_Fvf3O5fGFhqq63fvFvUEPERD5zX85AxQiEpcuiPJsTc5Lm4LdygQ-jPLsZSbOwK-F5Jf4_FNT5h9-CgSQ5Y2iZHDmERjrzMyPSlcFUCEC8aWXxS5kA3EeR32HBD91ps8Df5ft9Mj5GpL9UiODtQfBw8iK2TLCsQqi9UlkjYV44ooI42EIqL5Q0cxPajKMZ68eJiO4aBJ_hhhHbMNAHNwNRFRzZBsjkxzNrY6f9Hyu1mzMiegeqnE77Ld_GPjVfuuG-sSX">
<div class="absolute inset-0 bg-gradient-to-t from-black/60 to-transparent"></div>
<div class="absolute bottom-4 left-4">
<div class="font-label-md text-label-md text-surface-container-highest uppercase tracking-wider mb-1">License Plate</div>
<div class="font-headline-md text-headline-md text-on-primary bg-primary/40 backdrop-blur-md px-3 py-1 rounded-lg border border-white/20 inline-block font-mono tracking-widest">
                                51G - 888.88
                            </div>
</div>
</div>
<!-- Content Area -->
<div class="p-6 flex flex-col flex-1 gap-6">
<div>
<h3 class="font-title-lg text-title-lg text-on-surface mb-1">Toyota Camry</h3>
<p class="font-body-md text-body-md text-on-surface-variant flex items-center gap-1">
<span class="material-symbols-outlined text-[16px]">directions_car</span> Sedan
                            </p>
</div>
<!-- Plan Details -->
<div class="mt-auto bg-surface-container-low rounded-lg border border-outline-variant/50 p-4 flex items-center justify-between">
<div>
<span class="font-label-sm text-label-sm text-on-surface-variant uppercase block mb-1">Current Plan</span>
<span class="font-title-lg text-title-lg text-on-surface">Standard</span>
</div>
<div class="w-12 h-12 rounded-full bg-surface-variant text-on-surface flex items-center justify-center border border-outline-variant">
<span class="material-symbols-outlined">local_car_wash</span>
</div>
</div>
</div>
</article>
<!-- Card 3: Inactive/No Plan Example -->
<article class="bg-surface border border-outline-variant rounded-xl shadow-sm hover:shadow-md transition-shadow duration-300 overflow-hidden flex flex-col group relative opacity-80 hover:opacity-100">
<!-- Status Badge -->
<div class="absolute top-4 right-4 z-10 bg-surface-variant text-on-surface-variant px-3 py-1.5 rounded-full font-label-sm text-label-sm uppercase flex items-center gap-1.5 shadow-sm backdrop-blur-md bg-opacity-90 border border-outline-variant/30">
<span class="w-2 h-2 rounded-full bg-outline"></span>
                        INACTIVE
                    </div>
<!-- Image Area -->
<div class="relative h-56 bg-surface-variant overflow-hidden grayscale">
<img alt="A subtle view of a dark grey compact car parked in a shadowy, minimalist industrial garage. The lighting is subdued and cool-toned, creating a quiet, dormant atmosphere. The deep blacks and slate grays emphasize a sleek, dormant technological state within a sterile, professional environment." class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-700 ease-out" data-alt="A subtle view of a dark grey compact car parked in a shadowy, minimalist industrial garage. The lighting is subdued and cool-toned, creating a quiet, dormant atmosphere. The deep blacks and slate grays emphasize a sleek, dormant technological state within a sterile, professional environment." src="https://lh3.googleusercontent.com/aida-public/AB6AXuCoq6WQ-M30G0Q1Bds4adXgD8HKaa-OoOX0x2kvISXmLV0YcQ3RSBV_70XH3A1gs7xq2DH4w69RML77A0FmzBbuFg3BPoRVxJUCJ_DLqIYCnWkqj82Ty1FBvlDITwgqY1DKuY2ZhuX3sX-wSQAlYZCdD96hTw_hXx6Z_MXOsvFFBtyIS2EjqX3YnjB_r0RVSkZVgN9xWZltKPNxz1kmRs1y1wCzruYHCYc_vofgNVJUk8hAflQSW8fhIRHDxQBeMmLQjRqAC_Mh6C_k">
<div class="absolute inset-0 bg-gradient-to-t from-black/80 to-transparent"></div>
<div class="absolute bottom-4 left-4">
<div class="font-label-md text-label-md text-surface-container-highest uppercase tracking-wider mb-1 opacity-70">License Plate</div>
<div class="font-headline-md text-headline-md text-on-primary/70 bg-primary/40 backdrop-blur-md px-3 py-1 rounded-lg border border-white/10 inline-block font-mono tracking-widest">
                                29C - 567.89
                            </div>
</div>
</div>
<!-- Content Area -->
<div class="p-6 flex flex-col flex-1 gap-6">
<div>
<h3 class="font-title-lg text-title-lg text-on-surface mb-1">Ford Ranger</h3>
<p class="font-body-md text-body-md text-on-surface-variant flex items-center gap-1">
<span class="material-symbols-outlined text-[16px]">local_shipping</span> Pickup Truck
                            </p>
</div>
<!-- Action Area -->
<div class="mt-auto border-t border-outline-variant/30 pt-4">
<button class="w-full py-3 border border-outline-variant rounded-lg font-label-md text-label-md text-on-surface-variant hover:bg-surface-variant hover:text-on-surface transition-colors flex justify-center items-center gap-2">
<span class="material-symbols-outlined text-[18px]">add_circle</span>
                                Select a Plan
                            </button>
</div>
</div>
</article>
</div>
</div>
</main>
</body></html>