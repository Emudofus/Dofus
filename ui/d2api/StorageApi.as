package d2api
{
   import d2data.MountWrapper;
   
   public class StorageApi extends Object
   {
      
      public function StorageApi() {
         super();
      }
      
      public function itemSuperTypeToServerPosition(superTypeId:uint) : Object {
         return null;
      }
      
      public function getLivingObjectFood(itemType:int) : Object {
         return null;
      }
      
      public function getPetFood(id:int) : Object {
         return null;
      }
      
      public function getRideFoods() : Object {
         return null;
      }
      
      public function getViewContent(name:String) : Object {
         return null;
      }
      
      public function getShortcutBarContent(barType:uint) : Object {
         return null;
      }
      
      public function getFakeItemMount() : MountWrapper {
         return null;
      }
      
      public function getBestEquipablePosition(item:Object) : int {
         return 0;
      }
      
      public function addItemMask(itemUID:int, name:String, quantity:int) : void {
      }
      
      public function removeItemMask(itemUID:int, name:String) : void {
      }
      
      public function removeAllItemMasks(name:String) : void {
      }
      
      public function releaseHooks() : void {
      }
      
      public function releaseBankHooks() : void {
      }
      
      public function dracoTurkyInventoryWeight() : uint {
         return 0;
      }
      
      public function dracoTurkyMaxInventoryWeight() : uint {
         return 0;
      }
      
      public function getStorageTypes(category:int) : Object {
         return null;
      }
      
      public function getBankStorageTypes(category:int) : Object {
         return null;
      }
      
      public function setDisplayedCategory(category:int) : void {
      }
      
      public function setDisplayedBankCategory(category:int) : void {
      }
      
      public function getDisplayedCategory() : int {
         return 0;
      }
      
      public function getDisplayedBankCategory() : int {
         return 0;
      }
      
      public function setStorageFilter(typeId:int) : void {
      }
      
      public function setBankStorageFilter(typeId:int) : void {
      }
      
      public function getStorageFilter() : int {
         return 0;
      }
      
      public function getBankStorageFilter() : int {
         return 0;
      }
      
      public function updateStorageView() : void {
      }
      
      public function updateBankStorageView() : void {
      }
      
      public function sort(sortField:int, revert:Boolean) : void {
      }
      
      public function resetSort() : void {
      }
      
      public function sortBank(sortField:int, revert:Boolean) : void {
      }
      
      public function resetBankSort() : void {
      }
      
      public function getSortFields() : Object {
         return null;
      }
      
      public function getSortBankFields() : Object {
         return null;
      }
      
      public function unsort() : void {
      }
      
      public function unsortBank() : void {
      }
      
      public function enableBidHouseFilter(allowedTypes:Object, maxItemLevel:uint) : void {
      }
      
      public function disableBidHouseFilter() : void {
      }
      
      public function getIsBidHouseFilterEnabled() : Boolean {
         return false;
      }
      
      public function enableSmithMagicFilter(skill:Object) : void {
      }
      
      public function disableSmithMagicFilter() : void {
      }
      
      public function enableCraftFilter(skill:Object, slotCount:int) : void {
      }
      
      public function disableCraftFilter() : void {
      }
      
      public function getIsSmithMagicFilterEnabled() : Boolean {
         return false;
      }
      
      public function getItemMaskCount(objectUID:int, mask:String) : int {
         return 0;
      }
   }
}
