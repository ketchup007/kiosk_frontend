import unittest
from unittest.mock import patch
from services.database import Database
from app.errors import DatabaseError

class TestDatabase(unittest.TestCase):
    def setUp(self):
        self.db = Database()

    @patch('services.database.SupabaseClientManager.get_local_client')
    def test_get_menu(self, mock_client):
        mock_client.return_value.rpc().execute.return_value.data = [{'id': 1, 'name': 'Test Item'}]
        result = self.db.get_menu(1)
        self.assertEqual(result, [{'id': 1, 'name': 'Test Item'}])

    @patch('services.database.SupabaseClientManager.get_local_client')
    def test_get_menu_error(self, mock_client):
        mock_client.return_value.rpc().execute.side_effect = Exception("Test error")
        with self.assertRaises(DatabaseError):
            self.db.get_menu(1)

if __name__ == '__main__':
    unittest.main()
