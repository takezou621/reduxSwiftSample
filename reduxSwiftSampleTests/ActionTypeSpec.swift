import Quick
import Nimble
import RxSwift
import SwiftRedux

class ActionTypeSpec: QuickSpec {
    override func spec() {
        describe("ActionTypeSpec") {
            beforeEach{
            }
            
            it("should successfully retrieve payload from actionType"){
                // Arrange
                let incrementAction = IncrementAction() as Action
                let addRowAction = AddRowAction(payload: nil) as Action
                
                // Act
                let incrementPayload = incrementAction.payload
                let addRowPayload = addRowAction.payload
                
                // Assert
                expect(incrementPayload is Int).to(beTruthy())
                expect(addRowPayload is AddRowAction.Country).to(beTruthy())
            }
        }

    }
}
