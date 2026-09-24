from flask import Flask, jsonify
import os
import psycopg2

app = Flask(__name__)


def get_db_connection():
    return psycopg2.connect(
        host=os.getenv("DB_HOST", "terraform-postgres"),
        database=os.getenv("DB_NAME", "appdb"),
        user=os.getenv("DB_USER", "appuser"),
        password=os.getenv("DB_PASSWORD", "app_password"),
    )


@app.route("/")
def home():
    return jsonify({
        "message": "Terraform Docker Backend is running"
    })


@app.route("/health")
def health():
    try:
        conn = get_db_connection()
        conn.close()

        return jsonify({
            "status": "healthy",
            "database": "connected"
        }), 200

    except Exception as error:
        return jsonify({
            "status": "unhealthy",
            "database": "disconnected",
            "error": str(error)
        }), 500


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)