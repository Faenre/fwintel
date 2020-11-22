SELECT f.solar_system_id,
       f.victory_points,
       f.victory_points_threshold,
       f.occupier_faction_id
  FROM fw_system_statuses AS f
 WHERE f.id IN (SELECT r.id
                  FROM esi_responses AS r
                 WHERE r.code BETWEEN 200 AND 399
                 GROUP BY r.last_modified
                 ORDER BY r.id DESC
                 LIMIT %{size});
