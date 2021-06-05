import Foundation

final class CallStation{
    var userDB: Array<User> = []
    var callDB:[Call] = []
}

extension CallStation: Station {
    func users() -> [User] {
        Array(userDB)
    }
    
    func add(user: User) {
        if self.userDB.contains(user) == false{
            userDB.insert(user, at: 0)
        }
    }
    
    func remove(user: User) {
        let userIndex = userDB.firstIndex(where: {$0.id == user.id})
        if userIndex != nil{
            userDB.remove(at: userIndex ?? -1)
        }
    }
    
    func execute(action: CallAction) -> CallID? {
        
        switch action{
        
        case .start(from: let incomingUser, to: let outgoingUser):
            if userDB.contains(incomingUser) == false || userDB.contains(outgoingUser) == false{
                return nil
            }
            
            else if self.currentCall(user: outgoingUser) != nil{
                let busyCall = Call(id: UUID.init(), incomingUser: incomingUser, outgoingUser: outgoingUser, status: .ended(reason: .userBusy))
                callDB.append(busyCall)
                return busyCall.id
            }
            
            let call = UUID.init()
            let incomingCall = Call(id: call, incomingUser: incomingUser, outgoingUser: outgoingUser, status: .calling)
            
            self.callDB.append(incomingCall)
            
            return call
            
            
        case .answer(from: let incomingUser):
            
            let callingId = callDB.filter{ call in
                call.outgoingUser.id == incomingUser.id}.first?.id
            
            let callIndex = self.callDB.firstIndex(where: {$0.id == callingId && $0.status == .calling})
            
            guard let index = callIndex else {
                return nil
            }
            
            guard userDB.contains(callDB[index].outgoingUser) else {
                
                callDB[index].status = .ended(reason: .error)
                return nil
            }
            
            callDB[index].status = .talk
            
            return callingId
            
            
        case .end(from: let incomingUser):
            
            if var endedCall = callDB.filter {caller in
                caller.incomingUser == incomingUser || caller.outgoingUser == incomingUser
            }.first {
                
                if endedCall.status == .calling{
                    endedCall.status = .ended(reason: .cancel)
                }
                
                else if endedCall.status == .talk{
                    endedCall.status = .ended(reason: .end)
                }
                else{
                    break
                }

                if let index = calls().firstIndex(where: {$0.id == endedCall.id} ) {
                    callDB.remove(at: index)
                    callDB.insert(endedCall, at: index)
                    return endedCall.id
                }
                return endedCall.id
            }
        }
        return nil
    }
    
    func calls() -> [Call] {
        return callDB
    }
    
    func calls(user: User) -> [Call] {
        return callDB.filter{ history in
            history.incomingUser.id == user.id || history.outgoingUser.id == user.id
        }
    }
    
    func call(id: CallID) -> Call? {
        return callDB.filter{ callId in
            callId.id == id
        }.first ?? nil
    }
    
    func currentCall(user: User) -> Call? {
        return callDB.filter{ current in
            (current.status == .calling || current.status == .talk) && (current.incomingUser.id == user.id || current.outgoingUser.id == user.id)
        }.first ?? nil
    }
}
