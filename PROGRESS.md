# Progress & Decisions Log

## Decision Log

| # | Decision | Reason | Date |
|---|---|---|---|
| 1 | เปลี่ยนจาก Vite+React เป็น Single HTML + CDN | ไม่มี Node.js ในเครื่อง, Single file เปิดใช้งานได้ทันทีไม่ต้อง build | 2026-02-14 |
| 2 | ใช้ React 18 + Recharts ผ่าน UMD — **ล้มเหลว** | Recharts UMD ต้องการ prop-types dependency ที่ load ไม่ได้บน file:// | 2026-02-14 |
| 3 | **เปลี่ยนเป็น Vanilla JS + Chart.js** | Chart.js เป็น standalone, ไม่ต้อง React, UMD ทำงาน 100% ทุก protocol | 2026-02-14 |
| 4 | ใช้ Tailwind CSS ผ่าน Play CDN | ไม่ต้อง build step, ใช้งานได้ครบทุก utility class | 2026-02-14 |
| 5 | ใช้ chartjs-plugin-annotation สำหรับเส้นเกษียณ | Plugin เดียวที่ต้องเพิ่ม, ทำ vertical reference line ได้สมบูรณ์ | 2026-02-14 |
| 6 | ใส่ 3 default scenarios มาให้ | ให้ผู้ใช้เห็นตัวอย่างทันที: เงินฝาก 1.5%, กองทุนรวม 5%, หุ้น/ETF 8% | 2026-02-14 |
| 7 | ใช้ Google Fonts: Inter + Noto Sans Thai | รองรับทั้งภาษาไทยและอังกฤษ, modern look | 2026-02-14 |
| 8 | Share Link ใช้ URL hash (#) encoding | ไม่ต้องมี backend, compact format, รองรับ browser back/forward | 2026-02-14 |
| 9 | ต้องเปิดผ่าน HTTP server (python3 -m http.server) | Tailwind Play CDN ต้องการ HTTP protocol, ใช้ start.sh สำหรับความสะดวก | 2026-02-14 |

## Progress

- [x] สร้าง Requirements document (REQUIREMENTS.md)
- [x] ตัดสินใจ tech approach (Single HTML + CDN)
- [x] v1: React + Recharts — **failed** (Recharts UMD dependency issue)
- [x] v2: เปลี่ยนเป็น Vanilla JS + Chart.js — **success**
- [x] สร้าง calculation engine (compound interest, monthly compounding)
- [x] สร้าง UI components (Scenario Cards with inputs)
- [x] สร้าง Line Chart visualization (Chart.js + annotation plugin)
- [x] สร้าง Summary Cards (ข้อมูลครบ + progress bar)
- [x] รวม components + responsive design
- [x] เพิ่ม Share Link feature (URL hash encoding)
- [x] เพิ่ม Copy Link button + toast notification
- [x] v2 Complete — พร้อมใช้งาน

## Architecture (v2 — Current)

```
index.html (Single File ~550 lines)
├── <head>
│   ├── Tailwind CSS (cdn.tailwindcss.com)
│   ├── Chart.js 4.4.7 UMD (cdn.jsdelivr.net)
│   ├── chartjs-plugin-annotation 3.1.0 (cdn.jsdelivr.net)
│   └── Google Fonts (Inter + Noto Sans Thai)
├── <body>
│   ├── Header (title + subtitle)
│   ├── Global Settings (retirement age + share button)
│   ├── Scenario Grid (dynamic cards)
│   ├── Chart (canvas element)
│   ├── Summary Grid (dynamic cards)
│   └── Toast notification
└── <script>
    ├── State (scenarios array, chart instance)
    ├── calculate() — monthly compounding engine
    ├── getAtAge() — interpolation for any age
    ├── fmt() / fmtAxis() / fmtInput() — formatting
    ├── renderScenarios() — build scenario cards
    ├── field() — reusable input field generator
    ├── Input handlers (focus/blur/input with comma formatting)
    ├── refreshChart() — Chart.js line chart + annotation
    ├── renderSummary() — summary cards at retirement
    ├── URL State (stateToHash/loadFromHash/updateHash)
    ├── copyShareLink() — copy URL to clipboard
    └── Init (load from URL, event listeners, first render)
```

## Features Implemented

| Feature | Status |
|---|---|
| Scenario management (1-5 scenarios, add/remove) | Done |
| Input: เงินเริ่มต้น, ต่อเดือน, %, ปี, อายุ | Done |
| Compound interest calculation (monthly) | Done |
| Line Chart with multiple scenarios | Done |
| Retirement age reference line (เส้นประ) | Done |
| Global retirement age setting | Done |
| Tooltip on chart hover | Done |
| Summary Cards at retirement age | Done |
| Progress bar (เงินต้น vs ดอกเบี้ย) | Done |
| Number formatting (comma separator, ฿) | Done |
| Responsive design (mobile/tablet/desktop) | Done |
| Real-time calculation (no submit button) | Done |
| Thai language UI | Done |
| **Share Link (URL hash encoding)** | **Done** |
| **Copy Link button + toast** | **Done** |
| **Browser back/forward support** | **Done** |

## Files

| File | Description |
|---|---|
| `REQUIREMENTS.md` | Full requirements document |
| `PROGRESS.md` | This file — decisions & progress tracking |
| `index.html` | The complete application (single file) |
| `start.sh` | Launch script (starts HTTP server + opens browser) |

## Bug Fixes

| Bug | Root Cause | Fix |
|---|---|---|
| หน้าขาวเปล่า (v1) | Recharts UMD ต้องการ `prop-types` เป็น global, ไม่ได้โหลดให้ | เปลี่ยนจาก React+Recharts เป็น Vanilla JS+Chart.js ทั้งหมด |
