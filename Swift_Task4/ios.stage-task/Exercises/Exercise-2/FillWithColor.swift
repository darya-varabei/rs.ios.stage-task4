import Foundation

final class FillWithColor {
    
    func fillWithColor(_ image: [[Int]], _ row: Int, _ column: Int, _ newColor: Int) -> [[Int]] {
        
        var imageResult = image
        var buffer = 0
        let columnVar = column
        let rowVar = row
        
        if image.count == 1 && image[0].count == 1{
            imageResult[0][0] = newColor
            return imageResult
        }
        
        buffer = image[row][column]
        imageResult[row][column] = newColor
        
        imageResult = colorCells(imageResult, rowVar, columnVar, newColor, buffer)

        return imageResult
    }
    
    func colorCells(_ image: [[Int]], _ row: Int, _ column: Int, _ newColor: Int, _ buffer: Int) -> [[Int]]{
        var imageResult = image
        let columnVar = column
        let rowVar = row
        
        let countRows = image.count
        let countColumns = image[row].count
        
        imageResult[row][column] = newColor
        
        if columnVar != 0{
            if imageResult[rowVar][columnVar-1] == buffer{
                imageResult[rowVar][columnVar-1] = newColor
                if columnVar > 0{
                    imageResult = colorCells(imageResult, rowVar, columnVar-1, newColor, buffer)
                }
            }
        }
        if columnVar != countColumns - 1{
            if imageResult[rowVar][columnVar+1] == buffer{
                imageResult[rowVar][columnVar+1] = newColor
                if columnVar < countColumns+1{
                    imageResult = colorCells(imageResult, rowVar, columnVar+1, newColor, buffer)
                }
            }
        }
        
        if rowVar != 0{
            if imageResult[rowVar-1][columnVar] == buffer{
                imageResult[rowVar-1][columnVar] = newColor
                if rowVar > 0{
                    imageResult = colorCells(imageResult, rowVar-1, columnVar, newColor, buffer)
                }
            }
        }
        if rowVar != countRows - 1{
            if imageResult[rowVar+1][columnVar] == buffer{
                imageResult[rowVar+1][columnVar] = newColor
                if rowVar < countRows+1{
                    imageResult = colorCells(imageResult, rowVar+1, columnVar, newColor, buffer)
                }
            }
        }
        return imageResult
    }
}
