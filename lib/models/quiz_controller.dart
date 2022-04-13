// ignore_for_file: prefer_final_fields, unnecessary_this, prefer_const_constructors, non_constant_identifier_names, deprecated_member_use

import 'package:goaltube/components/quiz_score_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'questions.dart';

class QuestionController extends GetxController
    with SingleGetTickerProviderMixin {
  late AnimationController _animationController;
  late Animation _animation;
  Animation get animation => this._animation;
  late PageController _pageController;
  PageController get pageController => this._pageController;

  List<Question> _question = sampleData
      .map((question) => Question(
          id: question['id'],
          question: question['question'],
          options: question['options'],
          answer: question['answer_index']))
      .toList();

  List<Question> get questions => this._question;
  bool _isAnswered = false;
  bool get isAnswered => this._isAnswered;

  late int _correctAns;
  int get correctAns => this._correctAns;

  late int _selectAns;
  int get SelectAns => this._selectAns;

  RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => this._questionNumber;

  int _numofCorrectAns = 0;
  int get numberofCOrrectAnd => this._numofCorrectAns;

  @override
  void onInit() {
    _animationController =
        AnimationController(duration: Duration(seconds: 60), vsync: this);
    _animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController)
      ..addListener(() {
        update();
      });
    _animationController.forward();
    _pageController = PageController();
    _animationController.forward().whenComplete(() => nextQuestion());
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    _pageController.dispose();
    _animationController.dispose();
  }

  void checkAns(Question question, int slect_index) {
    _isAnswered = true;
    _correctAns = question.answer;
    _selectAns = slect_index;

    if (slect_index == _correctAns) _numofCorrectAns++;

    _animationController.stop();
    update();

    Future.delayed(Duration(seconds: 3), () {
      nextQuestion();
    });
  }

  void nextQuestion() {
    if (_questionNumber.value != questions.length) {
      _isAnswered = false;
      _pageController.nextPage(
          duration: Duration(milliseconds: 200), curve: Curves.easeIn);

      _animationController.reset();
      _animationController.forward();

      _animationController.forward().whenComplete(nextQuestion);
    } else {
      // Get.offAndToNamed(Scores());
      Get.off(QuizScoreView(),
          arguments: numberofCOrrectAnd,
          transition: Transition.rightToLeft,
          duration: Duration(seconds: 1));
    }
  }

  void updateQnumber(int ind) {
    _questionNumber.value = ind + 1;
  }
}
