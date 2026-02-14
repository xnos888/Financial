#!/bin/bash
# Compound Interest Comparison — Local Server
# วิธีใช้: double-click ไฟล์นี้ หรือรัน ./start.sh ใน Terminal

cd "$(dirname "$0")"
PORT=8080

echo "============================================"
echo "  Compound Interest Comparison"
echo "  เปรียบเทียบแผนการลงทุน"
echo "============================================"
echo ""
echo "  Server running at: http://localhost:$PORT"
echo "  กด Ctrl+C เพื่อหยุด server"
echo ""

# Open browser automatically
open "http://localhost:$PORT" 2>/dev/null || xdg-open "http://localhost:$PORT" 2>/dev/null &

# Start HTTP server
python3 -m http.server $PORT
