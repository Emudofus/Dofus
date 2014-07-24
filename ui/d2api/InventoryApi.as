package d2api
{
   import d2data.ItemWrapper;
   import d2data.QuantifiedItemWrapper;
   import d2data.SimpleTextureWrapper;
   
   public class InventoryApi extends Object
   {
      
      public function InventoryApi() {
         super();
      }
      
      public function destroy() : void {
      }
      
      public function getStorageObjectGID(pObjectGID:uint, quantity:uint = 1) : Object {
         return null;
      }
      
      public function getStorageObjectsByType(objectType:uint) : Object {
         return null;
      }
      
      public function getItemQty(pObjectGID:uint, pObjectUID:uint = 0) : uint {
         return 0;
      }
      
      public function getItemByGID(objectGID:uint) : ItemWrapper {
         return null;
      }
      
      public function getQuantifiedItemByGIDInInventoryOrMakeUpOne(objectGID:uint) : QuantifiedItemWrapper {
         return null;
      }
      
      public function getItem(objectUID:uint) : ItemWrapper {
         return null;
      }
      
      public function getEquipementItemByPosition(pPosition:uint) : ItemWrapper {
         return null;
      }
      
      public function getEquipement() : Object {
         return null;
      }
      
      public function getEquipementForPreset() : Object {
         return null;
      }
      
      public function getVoidItemForPreset(index:int) : SimpleTextureWrapper {
         return null;
      }
      
      public function getCurrentWeapon() : ItemWrapper {
         return null;
      }
      
      public function getPresets() : Object {
         return null;
      }
      
      public function removeSelectedItem() : Boolean {
         return false;
      }
   }
}
