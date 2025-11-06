import sys
import os
import pytest

# Add project root to sys.path
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from app import app  # Now this import will work

@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

def test_login_success(client):
    response = client.post('/login', json={'username': 'admin', 'password': 'admin123'})
    assert response.status_code == 200
    assert 'token' in response.get_json()

def test_login_failure(client):
    response = client.post('/login', json={'username': 'wrong', 'password': 'wrong'})
    assert response.status_code == 401
