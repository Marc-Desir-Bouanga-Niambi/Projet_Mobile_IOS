import Testing
@testable import SwiftFirstApp

struct SwiftFirstAppTests {

    @Test
    func testRegisterUser() {
        // GIVEN
        PersistenceService.deleteUser()
        let authVM = AuthViewModel()

        // WHEN
        authVM.register(
            name: "Alice",
            email: "alice@test.com",
            password: "1234"
        )

        // THEN
        #expect(authVM.isAuthenticated == true)
        #expect(authVM.currentUser != nil)
        #expect(authVM.currentUser?.email == "alice@test.com")
    }

    @Test
    func testLoginUser() {
        // GIVEN
        PersistenceService.deleteUser()

        let authVM = AuthViewModel()
        authVM.register(
            name: "Bob",
            email: "bob@test.com",
            password: "abcd"
        )

        // Nouvelle instance = simulation redémarrage app
        let authVM2 = AuthViewModel()

        // WHEN
        authVM2.login(email: "bob@test.com", password: "abcd")

        // THEN
        #expect(authVM2.isAuthenticated == true)
        #expect(authVM2.currentUser?.email == "bob@test.com")
    }

    @Test
    func testUpdateUser() {
        // GIVEN
        PersistenceService.deleteUser()

        let authVM = AuthViewModel()
        authVM.register(
            name: "Charlie",
            email: "charlie@test.com",
            password: "pass123"
        )

        // WHEN
        authVM.updateUser(
            name: "Charlie Updated",
            email: "charlie2@test.com",
            password: "newpass"
        )

        // THEN
        #expect(authVM.currentUser?.name == "Charlie Updated")
        #expect(authVM.currentUser?.email == "charlie2@test.com")
        #expect(authVM.currentUser?.password == "newpass")
    }
}
