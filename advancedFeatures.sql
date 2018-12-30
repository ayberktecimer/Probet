-- VIEW(S)

-- *
DROP VIEW flaggedPosts;
CREATE VIEW flaggedPosts AS
  SELECT Post.date, Post.post_id, Post.pmessage, Customer.first_name, Customer.last_name
  FROM Post JOIN Flags ON Post.post_id = Flags.post_id NATURAL JOIN Customer;

-----------------------------------------------------------------------------------------
-- TRIGGER(S)

DROP TRIGGER after_betslip_update;
CREATE TRIGGER after_betslip_update
AFTER UPDATE ON BetSlip
WHEN OLD.status = "waiting" AND NEW.status = "win"
BEGIN
  UPDATE Customer SET rank = rank + 1 WHERE NEW.customer_id = Customer.customer_id;
END

-- for testing purposes
SELECT * FROM sqlite_master WHERE TYPE = 'trigger';
UPDATE BetSlip SET status = 'waiting' WHERE bet_slip_id = 6;