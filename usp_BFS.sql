/* EXECUTE usp_BFS; */
CREATE PROCEDURE usp_BFS
AS
BEGIN
DECLARE @ROOT INT = 1;
SET NOCOUNT ON;
 WITH RLoop AS
 (
  SELECT 
	null Parent, 
	@ROOT leaf, 
	0 AS row
  UNION
  SELECT  
	g.ParentNodeID, 
	g.NodeID , 
	1 as row
   FROM GenericTree AS g
   WHERE g.ParentNodeID = @ROOT
  UNION ALL
  SELECT 
	g.ParentNodeID, 
	g.NodeID , 
	r.row + 1
	FROM GenericTree AS g 
	JOIN RLoop AS r
	ON g.ParentNodeID = r.leaf
  ) 
  SELECT distinct leaf AS NodeID
  FROM RLoop
  order by leaf
  END;
  GO