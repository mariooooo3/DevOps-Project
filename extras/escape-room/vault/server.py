import http.server, socketserver

class Handler(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "text/plain")
        self.end_headers()
        self.wfile.write(b"""
==========================================
  FELICITARI! AI TERMINAT ESCAPE ROOM-UL!
==========================================

  FLAG FINAL: FLAG{y0u_3sc4p3d_th3_d0ck3r}

  Ai demonstrat ca stii:
  [x] Sa cauti fisiere ascunse
  [x] Sa decodezi mesaje Base64
  [x] Sa gasesti date in variabile de mediu
  [x] Sa faci requesturi HTTP intre containere

  Bine ai venit in lumea DevOps!
==========================================
""")
    def log_message(self, fmt, *args):
        pass

with socketserver.TCPServer(("", 8888), Handler) as s:
    s.serve_forever()
