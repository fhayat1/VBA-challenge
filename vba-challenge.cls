Sub Ticker()

Dim ws As Worksheet

For Each ws In Worksheets

Dim Ticker_Name As String
Dim Ticker_Table_Row As Integer
Dim Row_Length As Double
Dim Year_Close As Double
Dim Year_Open As Double
Dim Yearly_Change As Double
Dim Vol As Double

    ' printing table headers
    ws.Range("I1").Value = "Ticker"
    ws.Range("J1").Value = "Yearly Change"
    ws.Range("K1").Value = "Percentage Change"
    ws.Range("L1").Value = "Total Stock Volume"
    

Ticker_Table_Row = 2

' finding last row
Row_Length = ws.Cells(Rows.Count, 1).End(xlUp).Row


For i = 2 To Row_Length
    
    If ws.Cells(i, 3).Value = 0 Then
    
        If ws.Cells(i + 1).Value <> ws.Cells(i, 1).Value Then
            Ticker_Name = ws.Cells(i, 1).Value
            
        End If

    ElseIf ws.Cells(i + 1, 1).Value = ws.Cells(i, 1).Value Then

        Vol = Vol + ws.Cells(i, 7).Value
        
        If ws.Cells(i - 1, 1).Value <> ws.Cells(i, 1).Value Then
            Year_Open = ws.Cells(i, 3).Value
        End If
        
    Else
        
        Ticker_Name = ws.Cells(i, 1).Value
        Vol = Vol + ws.Cells(i, 7).Value
        Year_Close = ws.Cells(i, 6).Value
        
        ws.Range("I" & Ticker_Table_Row).Value = Ticker_Name
        ws.Range("L" & Ticker_Table_Row).Value = Vol
        
        If Vol > 0 Then
        
            ws.Range("J" & Ticker_Table_Row).Value = Year_Close - Year_Open
        
        ' changing colour
            If ws.Range("J" & Ticker_Table_Row).Value > 0 Then
                ws.Range("J" & Ticker_Table_Row).Interior.ColorIndex = 4
                
            Else
                ws.Range("J" & Ticker_Table_Row).Interior.ColorIndex = 3
            
            End If
            
        ws.Range("K" & Ticker_Table_Row).Value = ws.Range("J" & Ticker_Table_Row) / Year_Open
        
        Else
        
        ws.Range("J" & Ticker_Table_Row) = 0
        ws.Range("K" & Ticker_Table_Row) = 0
        
    
    End If
    
        ws.Range("K" & Ticker_Table_Row).Style = "percent"
        
        Vol = 0
        Ticker_Table_Row = Ticker_Table_Row + 1
        
End If
    
Next i
        
        

Next ws

End Sub
