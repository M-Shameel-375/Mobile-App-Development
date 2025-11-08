// lib/data/flashcard_data.dart
import 'dart:math';
import '../models/flashcard.dart';

class FlashcardData {
  static final List<Flashcard> initialFlashcards = [
    Flashcard(
      id: '1',
      question: 'What is Flutter?',
      answer: 'An open-source UI framework by Google for building natively compiled applications.',
    ),
    Flashcard(
      id: '2',
      question: 'What is Dart?',
      answer: 'A client-optimized programming language for apps on multiple platforms.',
    ),
    Flashcard(
      id: '3',
      question: 'What is a Widget in Flutter?',
      answer: 'Everything in Flutter is a widget - the basic building blocks of the UI.',
    ),
    Flashcard(
      id: '4',
      question: 'What is StatefulWidget?',
      answer: 'A widget that has mutable state and can rebuild when state changes.',
    ),
    Flashcard(
      id: '5',
      question: 'What is StatelessWidget?',
      answer: 'A widget that describes part of UI which doesn\'t change dynamically.',
    ),
    Flashcard(
      id: '6',
      question: 'What is BuildContext?',
      answer: 'A handle to the location of a widget in the widget tree.',
    ),
    Flashcard(
      id: '7',
      question: 'What is setState()?',
      answer: 'A method to notify the framework that internal state has changed.',
    ),
    Flashcard(
      id: '8',
      question: 'What is Hot Reload?',
      answer: 'A feature that injects updated source code into the running app instantly.',
    ),
    Flashcard(
      id: '9',
      question: 'What is MaterialApp?',
      answer: 'A widget that wraps multiple widgets for Material Design applications.',
    ),
    Flashcard(
      id: '10',
      question: 'What is Scaffold?',
      answer: 'A widget that implements basic Material Design layout structure.',
    ),
  ];

  static final List<Map<String, String>> _bonusQuestions = [
    {
      'question': 'What is Provider?',
      'answer': 'A state management solution that uses InheritedWidget internally.',
    },
    {
      'question': 'What is BLoC Pattern?',
      'answer': 'Business Logic Component - a design pattern for separating business logic.',
    },
    {
      'question': 'What is GetX?',
      'answer': 'A lightweight and powerful solution for state, dependency, and route management.',
    },
    {
      'question': 'What is Riverpod?',
      'answer': 'A complete rewrite of Provider with improved features and compile safety.',
    },
    {
      'question': 'What is FutureBuilder?',
      'answer': 'A widget that builds itself based on Future interaction snapshots.',
    },
    {
      'question': 'What is StreamBuilder?',
      'answer': 'A widget that builds itself based on Stream interaction snapshots.',
    },
  ];

  static Flashcard getRandomCard() {
    final random = Random();
    final cardData = _bonusQuestions[random.nextInt(_bonusQuestions.length)];

    return Flashcard(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      question: cardData['question']!,
      answer: cardData['answer']!,
    );
  }

  static List<Flashcard> getInitialCards() {
    return List.from(initialFlashcards);
  }
}