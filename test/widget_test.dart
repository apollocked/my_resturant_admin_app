import 'package:flutter_test/flutter_test.dart';

import 'package:my_rest_admin/utils/format.dart';

void main() {
  test('avatarInitials strips the email domain', () {
    expect(avatarInitials('hamabarznji1990@gmail.com'), 'H');
    expect(avatarInitials('john.doe@example.com'), 'JD');
  });

  test('pluralDays handles singular and plural', () {
    expect(pluralDays(1), '1 day');
    expect(pluralDays(5), '5 days');
  });
}
