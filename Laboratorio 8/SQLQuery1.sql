--1
DECLARE @id_orden int, 
		@order_date datetime, 
		@year int, 
		@monto_total money

DECLARE @monto_anual money = 0
DECLARE @Años_pasados int = NULL

DECLARE OrderCursor CURSOR FOR
    SELECT Ord.OrderID, 
			Ord.OrderDate, 
			SUM(OD.UnitPrice * OD.Quantity) AS total
    FROM Orders Ord
    INNER JOIN [dbo].[Order_Details] OD ON Ord.OrderID = OD.OrderID
    GROUP BY Ord.OrderID, Ord.OrderDate
    ORDER BY Ord.OrderDate

OPEN OrderCursor

FETCH NEXT FROM OrderCursor INTO @id_orden, @order_date, @monto_total

WHILE @@FETCH_STATUS = 0
begin
    SET @year = YEAR(@order_date)

    IF @Años_pasados IS NOT NULL AND @Años_pasados != @year
    BEGIN
        PRINT 'Total Amount for ' + CAST(@Años_pasados AS varchar) + ': ' + CAST(@monto_anual AS varchar)
        SET @monto_anual = 0
    END

    SET @monto_anual = @monto_anual + @monto_total
    PRINT 'Order ID: ' + CAST(@id_orden AS varchar) + ', Amount: ' + CAST(@monto_total AS varchar)
    
    SET @Años_pasados = @year

    FETCH NEXT FROM OrderCursor INTO @id_orden, @order_date, @monto_total
end

PRINT 'Total Amount for ' + CAST(@Años_pasados AS varchar) + ': ' + CAST(@monto_anual AS varchar)

CLOSE OrderCursor
DEALLOCATE OrderCursor

--2

CREATE PROC List_Orders_By_Empley
    @EmployeeID int
AS
BEGIN
    PRINT 'Inicio del procedimiento para el empleado ID: ' + CAST(@EmployeeID AS varchar)

    DECLARE @id_orden int, @order_date datetime, @year int, @monto_total money
    DECLARE @monto_anual money = 0
    DECLARE @Años_pasados int = NULL

    DECLARE EmployeeOrderCursor CURSOR FOR
        SELECT O.OrderID, 
				O.OrderDate, 
				SUM(OD.UnitPrice * OD.Quantity) AS Total
        FROM Orders O
        INNER JOIN [dbo].[Order_Details] OD ON O.OrderID = OD.OrderID
        WHERE O.EmployeeID = @EmployeeID
        GROUP BY O.OrderID, O.OrderDate
        ORDER BY O.OrderDate

    OPEN EmployeeOrderCursor
    PRINT 'Cursor abierto.'

    FETCH NEXT FROM EmployeeOrderCursor INTO @id_orden, @order_date, @monto_total
    PRINT 'Primera b squeda en el cursor.'

    WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT 'Procesando orden: ' + CAST(@id_orden AS varchar)

        SET @year = YEAR(@order_date)

        IF @Años_pasados IS NOT NULL AND @Años_pasados != @year
        BEGIN
            PRINT 'Total Amount for ' + CAST(@Años_pasados AS varchar) + ': ' + CAST(@monto_anual AS varchar)
            SET @monto_anual = 0
        END

        SET @monto_anual = @monto_anual + @monto_total
        PRINT 'Order ID: ' + CAST(@id_orden AS varchar) + ', Amount: ' + CAST(@monto_total AS varchar)
        
        SET @Años_pasados = @year

        FETCH NEXT FROM EmployeeOrderCursor INTO @id_orden, @order_date, @monto_total
    END

    IF @Años_pasados IS NOT NULL
    BEGIN
        PRINT 'Total Amount for ' + CAST(@Años_pasados AS varchar) + ': ' + CAST(@monto_anual AS varchar)
    END

    CLOSE EmployeeOrderCursor
    DEALLOCATE EmployeeOrderCursor

    PRINT 'Fin del procedimiento.'
END

EXEC List_Orders_By_Empley @EmployeeID = 5