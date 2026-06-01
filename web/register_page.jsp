<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html class="light" lang="en">
<head>
    <meta charset="utf-8"/>
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <title>AutoWash Pro - Đăng Ký Thành Viên</title>
    <!-- Google Fonts & Tailwind -->
    <link href="https://fonts.googleapis.com" rel="preconnect"/>
    <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect"/>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&amp;display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Hanken+Grotesk:wght@400;500;600;700&amp;family=JetBrains+Mono:wght@400;500&amp;display=swap" rel="stylesheet"/>
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
                        "margin-mobile": "16px",
                        "stack-lg": "32px",
                        "margin-desktop": "32px"
                },
                "fontFamily": {
                        "title-lg": ["Hanken Grotesk"],
                        "headline-lg": ["Hanken Grotesk"],
                        "body-lg": ["Hanken Grotesk"],
                        "label-sm": ["JetBrains Mono"],
                        "label-md": ["JetBrains Mono"],
                        "display": ["Hanken Grotesk"],
                        "headline-lg-mobile": ["Hanken Grotesk"],
                        "headline-md": ["Hanken Grotesk"],
                        "body-md": ["Hanken Grotesk"]
                }
              }
            }
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
    
    <!-- Right Column: Registration Card -->
    <div class="w-full md:w-1/2 bg-surface-container-lowest flex items-center justify-center p-margin-mobile md:p-margin-desktop relative">
        <!-- Main Form Container -->
        <div class="w-full max-w-[440px] bg-surface-container-lowest border border-outline-variant shadow-sm rounded-2xl p-6 md:p-8 flex flex-col gap-stack-lg">
            <!-- Header -->
            <div class="text-center md:text-left">
                <h2 class="font-headline-lg text-headline-lg text-on-background mb-stack-sm">Đăng Ký</h2>
                <p class="font-body-md text-body-md text-on-surface-variant">Tạo tài khoản khách hàng mới của hệ thống AutoWash Pro.</p>
            </div>
            
            <!-- Error message if any -->
            <%
               String msg = (String) request.getAttribute("ERROR");
               if(msg != null) {
            %>
               <div class="bg-red-50 text-red-600 p-3 rounded-xl text-sm font-semibold border border-red-200 text-center">
                   <%= msg %>
               </div>
            <%
               }
            %>
            
            <!-- Form -->
            <form class="flex flex-col gap-stack-md" action="MainController" method="post" onsubmit="return validateRegisterForm()">
                <input type="hidden" name="action" value="Register">
                
                <!-- Full Name Input -->
                <div class="flex flex-col gap-stack-sm">
                    <label class="font-label-md text-label-md text-on-surface" for="txtfullname">Họ và tên</label>
                    <div class="relative">
                        <span class="absolute left-4 top-1/2 -translate-y-1/2 material-symbols-outlined text-outline-variant select-none pointer-events-none">person</span>
                        <input class="w-full pl-12 pr-4 py-3 bg-[#F1F5F9] border-transparent focus:border-secondary focus:bg-surface-container-lowest focus:ring-1 focus:ring-secondary rounded-xl font-body-md text-body-md text-on-surface transition-colors outline-none" 
                               id="txtfullname" name="txtfullname" placeholder="Nguyễn Văn A" type="text" required=""/>
                    </div>
                </div>

                <!-- Phone Number Input -->
                <div class="flex flex-col gap-stack-sm">
                    <label class="font-label-md text-label-md text-on-surface" for="txtphone">Số điện thoại</label>
                    <div class="relative">
                        <span class="absolute left-4 top-1/2 -translate-y-1/2 material-symbols-outlined text-outline-variant select-none pointer-events-none">phone</span>
                        <input class="w-full pl-12 pr-4 py-3 bg-[#F1F5F9] border-transparent focus:border-secondary focus:bg-surface-container-lowest focus:ring-1 focus:ring-secondary rounded-xl font-body-md text-body-md text-on-surface transition-colors outline-none" 
                               id="txtphone" name="txtphone" placeholder="Ví dụ: 0923456789" type="tel" required=""/>
                    </div>
                </div>

                <!-- Password Input -->
                <div class="flex flex-col gap-stack-sm">
                    <label class="font-label-md text-label-md text-on-surface" for="txtpassword">Mật khẩu</label>
                    <div class="relative">
                        <span class="absolute left-4 top-1/2 -translate-y-1/2 material-symbols-outlined text-outline-variant select-none pointer-events-none">lock</span>
                        <input class="w-full pl-12 pr-12 py-3 bg-[#F1F5F9] border-transparent focus:border-secondary focus:bg-surface-container-lowest focus:ring-1 focus:ring-secondary rounded-xl font-body-md text-body-md text-on-surface transition-colors outline-none" 
                               id="txtpassword" name="txtpassword" placeholder="••••••••" type="password" required=""/>
                    </div>
                </div>

                <!-- Action Button -->
                <button class="w-full mt-6 py-4 bg-secondary hover:bg-on-secondary-fixed-variant text-on-secondary font-label-md text-label-md rounded-xl transition-all active:scale-[0.98] shadow-sm flex items-center justify-center gap-2" type="submit">
                    ĐĂNG KÝ
                    <span class="material-symbols-outlined" style="font-variation-settings: 'FILL' 1;">how_to_reg</span>
                </button>
            </form>
            <!-- Footer Links -->
            <div class="text-center mt-stack-md pt-stack-md border-t border-surface-variant">
                <p class="font-body-md text-body-md text-on-surface-variant">
                    Đã có tài khoản? 
                    <a class="text-secondary font-semibold hover:text-on-secondary-fixed-variant transition-colors ml-1" href="MainController?action=LoginPage">Đăng nhập ngay</a>
                </p>
            </div>
        </div>
    </div>
    
    <!-- JavaScript for client-side validations -->
    <script>
        function validateRegisterForm() {
            const phone = document.getElementById('txtphone').value.trim();
            
            // Regex cho số điện thoại Việt Nam (bắt đầu bằng 0, gồm đúng 10 chữ số)
            const phoneRegex = /^0[0-9]{9}$/;
            if (!phoneRegex.test(phone)) {
                alert("Số điện thoại không hợp lệ! Phải bắt đầu bằng số 0 và có đúng 10 chữ số (ví dụ: 0923456789).");
                return false;
            }
            
            return true;
        }
    </script>
</body>
</html>