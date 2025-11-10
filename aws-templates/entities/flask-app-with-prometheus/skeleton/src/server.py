from flask import Response, Flask, request
import prometheus_client
from prometheus_client.core import CollectorRegistry
from prometheus_client import Summary, Counter, Histogram, Gauge
import time
import logging

app = Flask(__name__)

# Configuración básica de logging a stdout
# Promtail descubrirá automáticamente estos logs
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)

logger = logging.getLogger(__name__)

logger.info("Aplicación Flask iniciada")

_INF = float("inf")

graphs = {}
graphs['c'] = Counter('python_request_operations_total', 'The total number of processed requests')
graphs['h'] = Histogram('python_request_duration_seconds', 'Histogram for the duration in seconds.', buckets=(1, 2, 5, 6, 10, _INF))

@app.route("/")
def hello():
    start = time.time()
    graphs['c'].inc()
    
    logger.info(f"Request recibido en / desde {request.remote_addr}")
    
    time.sleep(0.600)
    end = time.time()
    duration = end - start
    graphs['h'].observe(duration)
    
    logger.info(f"Request completado en {duration:.3f} segundos")
    return "Hello World!"

@app.route("/metrics")
def requests_count():
    logger.debug("Métricas de Prometheus solicitadas")
    res = []
    for k,v in graphs.items():
        res.append(prometheus_client.generate_latest(v))
    return Response(res, mimetype="text/plain")
