# --- Stage 1: Build Stage ---
FROM node:20-alpine AS builder

WORKDIR /app

# نسخ ملفات الإعدادات لتثبيت المكتبات
COPY package*.json tsconfig.json ./

# تثبيت كل المكتبات بما فيها الخاصة بالـ TypeScript
RUN npm install

# نسخ فولدر الكود وباقي الملفات
COPY . .

# عمل Build لتحويل الـ TS إلى JS (غالباً بيطلع الفولدر في مجلد اسمه dist أو build)
RUN npm run build


# --- Stage 2: Run Stage ---
FROM node:20-alpine

WORKDIR /app

# نسخ الـ package.json لتثبيت مكتبات التشغيل فقط
COPY package*.json ./

# تثبيت مكتبات الـ Production فقط لتوفير المساحة
RUN npm install --only=production

# نسخ الملفات التي تم عمل Build لها من المرحلة الأولى
COPY --from=builder /app/dist ./dist

EXPOSE 3000

# تشغيل الملف الرئيسي بعد تحويله (تأكد أن الـ outDir في tsconfig هو dist)
CMD ["node", "dist/app.js"]