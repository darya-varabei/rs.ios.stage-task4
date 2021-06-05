import Foundation

public extension Int {
    
    var roman: String? {
        var result: String = ""
        var buffer: Int = 0
        var input = self
        
        if input < 1 || input > 3999{
            return nil
        }
        
        buffer = input % 10
        
        switch buffer{
        case 0:
            break
        case 1:
            result.append("I")
            break
        case 2:
            result.append("II")
            break
        case 3:
            result.append("III")
            break
        case 4:
            result.append("VI")
            break
        case 5:
            result.append("V")
            break
        case 6:
            result.append("IV")
            break
        case 7:
            result.append("IIV")
            break
        case 8:
            result.append("IIIV")
            break
        case 9:
            result.append("XI")
            break
        default:
            break
        }
        
        input = input - buffer
        
        if input == 0{
            let reversed = String(result.reversed())
            return reversed
        }
        
        buffer = input % 100
        
        switch buffer{
        case 0:
            result.append("")
            break
        case 10:
            result.append("X")
            break
        case 20:
            result.append("XX")
            break
        case 30:
            result.append("XXX")
            break
        case 40:
            result.append("LX")
            break
        case 50:
            result.append("L")
            break
        case 60:
            result.append("XL")
            break
        case 70:
            result.append("XXL")
            break
        case 80:
            result.append("XXXL")
            break
        case 90:
            result.append("CX")
            break
        default:
            break
        }
        
        input = input - buffer
        
        if input == 100{
            result.append("C")
        }
        
        if input == 0 || input == 100{
            let reversed = String(result.reversed())
            return reversed
        }
        
        buffer = input % 1000
        
        switch buffer{
        case 0:
            result.append("M")
            break
        case 100:
            result.append("CM")
            break
        case 200:
            result.append("CCM")
            break
        case 300:
            result.append("CCCM")
            break
        case 400:
            result.append("DCM")
            break
        case 500:
            result.append("DM")
            break
        case 600:
            result.append("CDM")
            break
        case 700:
            result.append("CCDM")
            break
        case 800:
            result.append("CCCDM")
            break
        case 900:
            result.append("MCM")
            break
        default:
            break
        }
        
        input = input - buffer
        
        if input == 2000{
            result.append("M")
        }
        
        if input == 3000{
            result.append("MM")
        }
        
        let reversed = String(result.reversed())
        return reversed
    }
}
