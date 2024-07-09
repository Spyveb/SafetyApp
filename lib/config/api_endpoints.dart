class Endpoints {
  Endpoints._();

  static const baseUrl = "https://royalblue-mandrill-559334.hostingersite.com/public/";

  // Authentication Endpoints
  static const signIn = "${baseUrl}api/login"; // Endpoint for user sign in
  static const signUp = "${baseUrl}api/signup"; // Endpoint for user sign up
  static const forgotPassword = "${baseUrl}auth/forgot-password"; // Endpoint for forgot password functionality
  static const logout = "${baseUrl}user/logout"; // Endpoint for logout user
  static const deleteAccount = "${baseUrl}user/delete"; // Endpoint for delete user
  static const signUpPartner = "${baseUrl}auth/partner"; // Endpoint for delete user

  // Profile Endpoints
  static const changePassword = "${baseUrl}user/reset-password"; // Endpoint to change user's password
  static const getUserDetails = "${baseUrl}user/me"; // Endpoint to get details of the currently authenticated user
  static const editUser = "${baseUrl}user/edit"; // Endpoint to edit user profile details
  static const addEvents = "${baseUrl}event/add"; // Endpoint to edit user profile details
  static const editEvent = "${baseUrl}event/update"; // Endpoint to edit user event details
  static const deleteEvent = "${baseUrl}event/delete"; // Endpoint to delete user event details
  static const getEvent = "${baseUrl}event/list"; // Endpoint to edit user profile details

  // Home Endpoints
  static const getBannerList = "${baseUrl}banners/list"; // Endpoint to retrieve list of banners for home screen
  static const getStoreList = "${baseUrl}store/list"; // Endpoint to retrieve list of stores
  static const getCategoryList = "${baseUrl}categories/list"; // Endpoint to retrieve list of categories
  static const getAppSettings = "${baseUrl}user/get-settings"; // Endpoint to retrieve app settings

  // Send Gifts Endpoints
  static const getGiftCategoryList = "${baseUrl}gift-categories/list"; // Endpoint to retrieve list of gift categories
  static const productList = "${baseUrl}products/list"; // Endpoint to retrieve list of products
  static const productDetails = "${baseUrl}products/product-details"; // Endpoint to retrieve details of a product
  static const addToCart = "${baseUrl}cart/add"; // Endpoint to add item to cart
  static const cartDetails = "${baseUrl}cart/list-cart-items"; // Endpoint to retrieve cart details
  static const addCustomMessage = "${baseUrl}cart/add-custom-message"; // Endpoint to add custom message to cart item
  static const removeCartItem = "${baseUrl}cart/delete"; // Endpoint to remove item from cart
  static const addAddress = "${baseUrl}address/add"; // Endpoint to add a new address
  static const addressList = "${baseUrl}address/list"; // Endpoint to retrieve list of addresses
  static const updateAddress = "${baseUrl}address/update"; // Endpoint to update address
  static const deleteAddress = "${baseUrl}address/delete"; // Endpoint to delete address
  static const selectAddress = "${baseUrl}address/select-address"; // Endpoint to select a shipping address
  static const checkout = "${baseUrl}order/add"; // Endpoint to place an order
  static const transaction = "${baseUrl}wallet/transaction"; // Endpoint to perform wallet transactions
  static const syncContacts = "${baseUrl}circle/sync-contacts"; // Endpoint to synchronize contacts
  static const circleSendRequest = "${baseUrl}circle/send-request"; // Endpoint to send request to join circle
  static const circleList = "${baseUrl}circle/users"; // Endpoint to retrieve list of circle members
  static const removeFromCircle = "${baseUrl}circle/remove-from-circle"; // Endpoint to remove user from circle
  static const userList = "${baseUrl}user/list"; // Endpoint to retrieve list of users

  // Order Endpoints
  static const orderList = "${baseUrl}order/order-history"; // Endpoint to retrieve order history
  static const orderDetail = "${baseUrl}order/order-details"; // Endpoint to retrieve order details

  // Wallet Endpoints`
  static const getWalletData = "${baseUrl}wallet/data"; // Endpoint to retrieve wallet data
  static const addWalletBalance = "${baseUrl}wallet/add-balance"; // Endpoint to add balance to wallet
  static const getWalletHistory = "${baseUrl}wallet/history"; // Endpoint to retrieve wallet transaction history
  static const redeemPoint = "${baseUrl}wallet/redeem-points"; // Endpoint to redeem point

  // Notification Endpoints
  static const getNotificationList = "${baseUrl}notifications/list"; // Endpoint to retrieve notification list
  static const readNotification = "${baseUrl}notifications/read-notification"; // Endpoint to read notification
  static const changeNotificationCircleRequest =
      "${baseUrl}circle/change-request-status"; // Endpoint to change notification circle request

  // Group Endpoints
  static const createGroup = "${baseUrl}group/add"; // Endpoint to add group
  static const getMyGroupList = "${baseUrl}group/my-groups"; // Endpoint to retrieve my group list
  static const getInvitedGroupList = "${baseUrl}group/invited-to-join"; // Endpoint to retrieve my group list
  static const getGroupDetails = "${baseUrl}group/details"; // Endpoint to retrieve group details
  static const payForVoucher = "${baseUrl}group/pay-for-voucher"; // Endpoint to pay for voucher
  static const deleteGroup = "${baseUrl}group/delete"; // Endpoint to delete group
  static const updateGroup = "${baseUrl}group/update"; // Endpoint to update group
  static const exitGroup = "${baseUrl}group/leave"; // Endpoint to exit group
  static const sendVoucher = "${baseUrl}group/send-voucher"; // Endpoint to send voucher
  static const removeMember = "${baseUrl}group/remove-members"; // Endpoint to remove member
  static const addMembers = "${baseUrl}group/add-members"; // Endpoint to add members
  static const changeNotificationGroupRequest =
      "${baseUrl}group/change-request-status"; // Endpoint to change notification group request

  static const downloadUrl = "${baseUrl}downloads"; // Endpoint to download the app
}
