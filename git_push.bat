@echo off
echo ===================================================
echo CHUAN BI DAY DU AN LEN GITHUB (Nguyen-Van-Gia-Binh/WS1)
echo ===================================================

:: Khoi tao git neu chua co
if not exist .git (
    echo [1/5] Khoi tao Git repository...
    git init
) else (
    echo [*] Git da duoc khoi tao truoc do.
)

:: Them tat ca cac file
echo [2/5] Them tat ca file vao git...
git add .

:: Commit
echo [3/5] Commit thay doi...
git commit -m "Initial commit - Demo1"

:: Cau hinh remote
echo [4/5] Cau hinh remote origin...
:: Xoa remote origin cu neu co de tranh bi trung lap
git remote remove origin 2>nul
git remote add origin https://github.com/Nguyen-Van-Gia-Binh/WS1.git
git branch -M main

:: Push code
echo [5/5] Day code len Github (main branch)...
git push -u origin main

echo ===================================================
echo HOAN THANH!
echo ===================================================
pause
