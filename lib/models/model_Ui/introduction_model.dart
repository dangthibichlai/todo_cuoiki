class IntroductionModel {
  String description;
  String image;
  IntroductionModel({required this.description, required this.image});
}

List<IntroductionModel> introductionList = [
  IntroductionModel(
    description: 'Simple and efficient management with a friendly, easy-to-use management model.',
    image: 'assets/images/welcome_page_issues.png',
  ),
  IntroductionModel(
    description: 'Flexible statistics with a variety of detailed and easy-to-understand statistical charts.',
    image: 'assets/images/welcome_page_queues.png',
  ),
  IntroductionModel(
    description: 'Stay in the loop with your team and never miss a thing.',
    image: 'assets/images/welcome_page_queues.png',
  ),
  IntroductionModel(
    description: 'Manage your SLA and keep track of your team\'s performance.',
    image: 'assets/images/welcome_page_stay_in_the_loop.png',
  ),
  IntroductionModel(
    description: 'Welcome to the world of efficient management.',
    image: 'assets/images/welcome_page_queues.png',
  ),
];
