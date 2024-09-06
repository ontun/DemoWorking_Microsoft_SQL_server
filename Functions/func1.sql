CREATE FUNCTION GetClientInfoById (@client_id int)
RETURNS TABLE
AS
RETURN (
    SELECT Client_first_name, Client_last_name, client_birthday
    FROM Client
    WHERE Client_id = @client_id
)