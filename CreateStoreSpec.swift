import Quick
import Nimble
import RxSwift
import SwiftRedux

class CreateStoreSpec: QuickSpec {
    override func spec() {
        describe("Create Store") {
            var defaultState: AppState!
            var store: TypedStore<AppState>!
            
            beforeEach {
                store = createTypedStore()(createStore)(applicationReducer, nil)
                defaultState = store.getState()
            }
            
            it("should be subscribable and successfully propagete one action dispatch") {
                var state: AppState!
                store.subscribe{ newState in
                    state = newState
                }
                store.dispatch(IncrementAction())
                
                // Assert
                expect(state.counter).toNot(equal(defaultState.counter))
            }
            
            it("should effectively run multiple dispatches") {
                // Arrange
                var state : AppState!
                let iterations = 3
                
                // Act
                store.subscribe{ newState in
                    state = newState
                }
                
                for(var i = 0; i < iterations; i++) {
                    store.dispatch(IncrementAction())
                }
                
                // Assert
                expect(state.counter).toNot(equal(defaultState.counter))
                expect(state.counter).to(equal(defaultState.counter+iterations))
            }
            
            it("should fetch the latest state") {
                // Arrange
                var state: AppState!
                
                // Act
                
                // Run dispatch multiple items
                store.dispatch(IncrementAction())
                state = store.getState()
                
                // Assert
                expect(state.counter).toNot(equal(defaultState.counter))
            }
            
            it("should work with multiple reducers") {
                // Arrange
                var state: AppState!
                let textMessage = "test"
                let iterations = 3
                
                store.subscribe{ newState in
                    state = newState
                }
                
                for(var i = 0; i < iterations; i++) {
                    store.dispatch(IncrementAction())
                    store.dispatch(AddRowAction(payload: AddRowAction.Country(name: textMessage)))
                }
                
                // Assert
                expect(state.counter).to(equal(defaultState.counter+iterations))
                expect(state.countries).to(contain(textMessage))
                expect(state.countries.count).to(equal(iterations))
            }
            
        }

    }
}
