import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:user_directory_app/main.dart';
import 'package:user_directory_app/models/user_model.dart';
import 'package:user_directory_app/screens/home_screen.dart';
import 'package:user_directory_app/services/api_service.dart';

class FakeSuccessApiService extends ApiService {
  @override
  Future<List<User>> fetchUsers() async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    return const [
      User(
        id: 1,
        name: 'Leanne Graham',
        username: 'Bret',
        email: 'Sincere@april.biz',
        address: Address(
          street: 'Kulas Light',
          suite: 'Apt. 556',
          city: 'Gwenborough',
          zipcode: '92998-3874',
          geo: Geo(lat: '-37.3159', lng: '81.1496'),
        ),
        phone: '1-770-736-8031 x56442',
        website: 'hildegard.org',
        company: Company(
          name: 'Romaguera-Crona',
          catchPhrase: 'Multi-layered client-server neural-net',
          bs: 'harness real-time e-markets',
        ),
      ),
    ];
  }
}

class FakeErrorApiService extends ApiService {
  @override
  Future<List<User>> fetchUsers() async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    throw const ApiException('Unable to connect to the server.');
  }
}

void main() {
  testWidgets('Login screen renders properly', (WidgetTester tester) async {
    await tester.pumpWidget(const UserDirectoryApp());

    expect(find.text('Welcome Back'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
  });

  testWidgets('Home screen displays loading, user list, and navigates to details on tap',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: HomeScreen(apiService: FakeSuccessApiService()),
      ),
    );

    // Loading state
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Wait for fetch completion
    await tester.pumpAndSettle();

    // User list item rendered
    expect(find.text('Leanne Graham'), findsOneWidget);
    expect(find.text('@Bret • Sincere@april.biz'), findsOneWidget);

    // Tap user to navigate to details screen
    await tester.tap(find.text('Leanne Graham'));
    await tester.pumpAndSettle();

    // Verify User Detail Screen content
    expect(find.text('Contact Information'), findsOneWidget);
    expect(find.text('hildegard.org'), findsOneWidget);
    expect(find.text('Kulas Light, Apt. 556'), findsOneWidget);
  });

  testWidgets('Home screen handles API errors gracefully',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: HomeScreen(apiService: FakeErrorApiService()),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Oops! Something went wrong'), findsOneWidget);
    expect(find.text('Unable to connect to the server.'), findsOneWidget);
    expect(find.text('Try Again'), findsOneWidget);
  });
}
