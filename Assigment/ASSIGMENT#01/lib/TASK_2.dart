import 'dart:io';

void main() {
  // Get user name and age
  stdout.write('Enter your name: ');
  String name = stdin.readLineSync()!;

  stdout.write('Enter your age: ');
  int age = int.parse(stdin.readLineSync()!);

  // Check eligibility
  if (age < 18) {
    print('Sorry $name, you are not eligible to register.');
    return;
  }

  // Get numbers from user
  stdout.write('How many numbers do you want to enter? ');
  int n = int.parse(stdin.readLineSync()!);

  List<int> numbers = [];
  for (int i = 0; i < n; i++) {
    stdout.write('Enter number ${i + 1}: ');
    int num = int.parse(stdin.readLineSync()!);
    numbers.add(num);
  }

  // Calculate results
  int evenSum = 0;
  int oddSum = 0;
  int largest = numbers[0];
  int smallest = numbers[0];

  for (int num in numbers) {
    if (num % 2 == 0) {
      evenSum += num;
    } else {
      oddSum += num;
    }

    if (num > largest) {
      largest = num;
    }

    if (num < smallest) {
      smallest = num;
    }
  }

  // Print results
  print('\n--- Results ---');
  print('Numbers entered: $numbers');
  print('Sum of even numbers: $evenSum');
  print('Sum of odd numbers: $oddSum');
  print('Largest number: $largest');
  print('Smallest number: $smallest');
}