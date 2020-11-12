SELECT MAX(r.expiry) AS expiry
  FROM responses AS r
 WHERE r.code BETWEEN 200 AND 399;
