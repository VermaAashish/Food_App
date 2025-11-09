

class AppStrings {
  static final AppStrings _appStrings = AppStrings._internal();
  factory AppStrings() {
    return _appStrings;
  }
  AppStrings._internal();

  String get yam => "Yam";
  String get zi => 'zi';
  String get yamzi => 'Yamzi';
  String get searchYourFavoriteThali => 'Search your favorite Thali';
  String get addedToOrders => 'Added to Orders';
  String get addedSuccessfully => 'added successfully!';
  String get order => 'Order';
  String get customizeThali => 'Customize Thali';
  String get selectThaliType => "Select Thali Type";
  String get logIn => "Log In";
  String get vegetarian => "Vegetarian";
  String get signUp => "Sign up";
  String get nonVegetarian => "Non-Vegetarian";
    String get mix => "Mix";
  String get selectItems => "Select Items";

  String get selectedItems => "Selected Items";
  String get noItemsSelected => "No items selected";
  String get totalPrice => "Total Price:";
  String get pleaseSelectAtLeastOneItem => "Please select at least one item";
  String get thaliAddedToYourOrders => "Thali added to your orders!";
  String get addToCart => "Add to Cart";



  String get myOrders => "My Orders";
  String get noOrdersYet => "No orders yet.";
  String get customizedThali => "Customized Thali";
  String get totalRs => " Total: ₹";
  String get remove   => "remove ";
  String get youMayAlsoLike => "You may also like";

  String get orderSummary => "Order Summary";
  String get total => "Total";
  String get continueToPayment => "Continue to Payment";
  String get userName => "User Name";
  String get dontHaveAnAccount => "Don't have an account?";
  String get yumzi2025 => "© 2025 Yumzi";
  String get password => "Password";
  String get emailUsername => "Email/Username";
  String get welcomeBackFoodie => "Welcome back, foodie!";
  String get signUpWithGoogle => "Sign Up with Google";
  String get signIn => "Sign in";
  String get alreadyHaveAnAccount=> "Already have an account?";
  String get noPostsYet => "No posts yet";
  String get reelsVideos => "Reels / Videos";
  String get taggedPosts => "Tagged Posts";
  String get defaultProfileTitle => "User_Name01";
  String get searchWithMetaAI => "Search with Meta AI";


}

AppStrings appStrings = AppStrings();
