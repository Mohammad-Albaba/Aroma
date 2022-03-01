abstract class ApexStates{}

class ApexInitialState extends ApexStates {}

class ApexChangeBottomNavState extends ApexStates {}

class ApexLoadingCategoriesState extends ApexStates {}

class ApexSuccessCategoriesState extends ApexStates {}

class ApexErrorCategoriesState extends ApexStates {
  final String error;
  ApexErrorCategoriesState(
      this.error,
);
}

class ApexSuccessProductState extends ApexStates {}

class ApexErrorProductState extends ApexStates {
  final String error;
  ApexErrorProductState(
      this.error,
      );
}

class ApexSuccessAddCartState extends ApexStates {}

class ApexErrorAddCartState extends ApexStates {
  final String error;
  ApexErrorAddCartState(
      this.error,
      );
}

class ApexSuccessGetCartState extends ApexStates {}

class ApexErrorGetCartState extends ApexStates {
  final String error;
  ApexErrorGetCartState(
      this.error,
      );
}