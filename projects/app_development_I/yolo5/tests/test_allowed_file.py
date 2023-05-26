import unittest
from app import allowed_file, ALLOWED_EXTENSIONS


class TestBacklogPerInstanceMetric(unittest.TestCase):
    def test_valid_filename(self):
        for ext in ALLOWED_EXTENSIONS:
            self.assertTrue(allowed_file(f'test.{ext}'))

    def test_invalid_filename(self):
        self.assertFalse(allowed_file(f'file'))
        self.assertFalse(allowed_file(f'file.csv'))

