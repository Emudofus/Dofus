package ui.behavior
{
   import ui.StorageUi;
   import ui.AbstractStorageUi;
   import d2hooks.*;
   import com.ankamagames.dofusModuleLibrary.enum.interfaces.UIEnum;
   import ui.enum.StorageState;
   
   public class TokenShopBehavior extends Object implements IStorageBehavior
   {
      
      public function TokenShopBehavior() {
         super();
      }
      
      private var _storage:StorageUi;
      
      public function filterStatus(enabled:Boolean) : void {
      }
      
      public function dropValidator(target:Object, data:Object, source:Object) : Boolean {
         return false;
      }
      
      public function processDrop(target:Object, data:Object, source:Object) : void {
      }
      
      public function onValidQtyDrop(qty:Number) : void {
      }
      
      public function onValidQty(qty:Number) : void {
      }
      
      public function onRelease(target:Object) : void {
      }
      
      public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void {
      }
      
      public function attach(storageUi:AbstractStorageUi) : void {
         if(!(storageUi is StorageUi))
         {
            throw new Error("Can\'t attach a BidHouseBehavior to a non StorageUi storage");
         }
         else
         {
            this._storage = storageUi as StorageUi;
            if(this._storage.playerLook)
            {
               this._storage.playerLook.look = Api.player.getPlayedCharacterInfo().entityLook;
            }
            this._storage.setDropAllowed(false,"behavior");
            this._storage.btnMoveAll.visible = false;
            this._storage.saveCategory = false;
            this._storage.categoryFilter = AbstractStorageUi.QUEST_CATEGORY;
            this._storage.subFilter = AbstractStorageUi.SUBFILTER_ID_TOKEN;
            this._storage.saveCategory = true;
            return;
         }
      }
      
      public function detach() : void {
         this._storage.setDropAllowed(true,"behavior");
         this._storage.btnMoveAll.visible = true;
         Api.ui.unloadUi(UIEnum.NPC_STOCK);
      }
      
      public function onUnload() : void {
      }
      
      public function getStorageUiName() : String {
         return UIEnum.STORAGE_UI;
      }
      
      public function getName() : String {
         return StorageState.TOKEN_SHOP_MOD;
      }
      
      public function get replacable() : Boolean {
         return false;
      }
   }
}
