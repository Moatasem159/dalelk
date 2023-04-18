
abstract class CategoryStates {}

class CategoryInitialState extends CategoryStates {}
class PickImageSuccessState extends CategoryStates {}
class PickImageErrorState extends CategoryStates {}
class AddCategoryLoadingState extends CategoryStates {}
class AddCategorySuccessState extends CategoryStates {}
class AddCategoryErrorState extends CategoryStates {}
class AddImageSuccessState extends CategoryStates {}
class AddImageErrorState extends CategoryStates {}
class GetCatItemsLoadingState extends CategoryStates {}
class GetCatItemsSuccessState extends CategoryStates {}
class GetCatItemsErrorState extends CategoryStates {}
class DeleteItemLoadingState extends CategoryStates {}
class DeleteItemSuccessState extends CategoryStates {}
class DeleteItemErrorState extends CategoryStates {}
class EditItemLoadingState extends CategoryStates {}
class EditItemSuccessState extends CategoryStates {}
class EditItemErrorState extends CategoryStates {}