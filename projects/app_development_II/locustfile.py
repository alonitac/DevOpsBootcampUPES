from locust import HttpUser, between, task


class PredictImageUser(HttpUser):
    wait_time = between(1, 3)

    @task
    def upload_file(self):
        with open('cars.jpeg', 'rb') as file:
            self.client.post('/', files={'file': file})
