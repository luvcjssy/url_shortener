### Potential attack vectors

- Rate limit: we can use `rack-attack` gem to prevent a huge of requests to server

### Scale up

- Generate the unique shortened url
    - URL encoding through random string from [0–9][a-z][A-Z], and I get 7 characters. So, we have 62^7 ≈ 3.5 trillion unique slugs.
    - In duplicated slug case 
      - For new record, the `set_slug` method will re-run in 5 times to generate unique slug. 
      - Most of new records with slug is null value in many time, we will change some logic 
        - Move `UNIQUE_SLUG_LENGTH` constant to setting in DB, and increase the value, then we have more slugs with new length
        - Build more with `expired` field to check the shortener url. We also have a cron tab to delete expired shortener urls
   
- Web server scaling
  - Add more servers and build load balancer to the request to web servers
  - Build cache server to reduce DB execution

- Database scaling
  - Apply database replication and sharding
