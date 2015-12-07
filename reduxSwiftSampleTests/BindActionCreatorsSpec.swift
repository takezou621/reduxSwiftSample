import Quick
import Nimble
import RxSwift
import SwiftRedux

class BindActionCreatorsSpec: QuickSpec {
    override func spec() {
        
        beforeSuite {
        }
        
        afterSuite {
        }
        
        describe("BindActionCreators") {
            var defaultState: AppState!
            var store: TypedStore<AppState>!
            
            beforeEach{
                store = createTypedStore()(createStore)(applicationReducer, nil)
                defaultState = store.getState()
            }
            
            it("should successfully create an action method that calls the store's dispatch with nil value") {
                
                // Arrange
                var state: AppState!
                store.subscribe{ newState in
                    state = newState
                }
                
                // Act
                let increment = bindActionCreators(IncrementAction.self, dispatch: store.dispatch)
                
                increment(payload: nil)
                
                // Assert
                expect(state.counter).toNot(equal(defaultState.counter))
                expect(state.counter).to(equal(defaultState.counter+1))
            }
            
            it("should succesfully create an action method that calls the store's dispatch with an actual value") {
                
                // Arrange
                var state: AppState!
                let textMessage = "test"
                store.subscribe{ newState in
                    state = newState
                }
                
                // Act
                let push = bindActionCreators(AddRowAction.self, dispatch: store.dispatch)
                
                push(payload: AddRowAction.Country(name: textMessage))
                
                // Assert
                expect(defaultState.countries).toNot(contain(textMessage))
                expect(state.countries).to(contain(textMessage))
            }
        }
    }
}
