# tests/test_auth.py
import json
from app import app

client = app.test_client()

def test_login_success():
    response = client.post('/login', json={'username': 'admin', 'password': 'admin123'})
    assert response.status_code == 200
    assert 'token' in response.get_json()

def test_login_failure():
    response = client.post('/login', json={'username': 'wrong', 'password': 'user'})
    assert response.status_code == 401
