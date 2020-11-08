CREATE TABLE eve_universe (
  id integer UNIQUE NOT NULL,
  name varchar(50) NOT NULL,

  PRIMARY KEY (id)
);

CREATE TABLE endpoints (
  id serial,
  name varchar(50),

  PRIMARY KEY (id)
);

CREATE TABLE esi_responses (
  id serial,
  endpoint_id integer NOT NULL,
  response_code integer DEFAULT 200,
  timestamp timestamp NOT NULL DEFAULT now(),
  comment varchar(100),

  PRIMARY KEY (id),
  FOREIGN KEY (endpoint_id) REFERENCES endpoints(id)
);

CREATE TABLE fw_system_statuses (
  id serial,
  response_id integer NOT NULL,
  system_id integer NOT NULL,
  vp_current integer NOT NULL,
  vp_max integer NOT NULL DEFAULT 300,
  owning_faction integer NOT NULL,

  PRIMARY KEY (id),
  FOREIGN KEY (response_id) REFERENCES esi_responses(id),
  FOREIGN KEY (system_id) REFERENCES eve_universe(id),
  FOREIGN KEY (owning_faction) REFERENCES eve_universe(id)
);
