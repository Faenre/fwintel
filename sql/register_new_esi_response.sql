INSERT INTO esi_responses
  (endpoint_id, response_code)
VALUES (%{id}, %{response}) ;

SELECT id FROM esi_responses
ORDER BY id DESC
LIMIT 1;
