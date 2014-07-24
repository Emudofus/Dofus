package ui.behavior
{
   import ui.AbstractStorageUi;
   import d2hooks.*;
   import com.ankamagames.dofusModuleLibrary.enum.interfaces.UIEnum;
   import ui.enum.StorageState;
   
   public class SmithMagicCoopBehavior extends SmithMagicBehavior
   {
      
      public function SmithMagicCoopBehavior() {
         super();
      }
      
      override public function attach(storageUi:AbstractStorageUi) : void {
         super.attach(storageUi);
         var uiObject:Object = Api.ui.getUi("smithMagic");
         if(!uiObject)
         {
            throw new Error("On attach un SmithMagicCoopBehavior sur une UI pas chargé");
         }
         else
         {
            if(uiObject.uiClass.isCrafter)
            {
               _storage.btnEquipable.disabled = true;
               _storage.btnConsumables.disabled = true;
               _storage.categoryFilter = AbstractStorageUi.RESSOURCES_CATEGORY;
            }
            return;
         }
      }
      
      override public function detach() : void {
         super.detach();
         _storage.btnEquipable.disabled = false;
         _storage.btnConsumables.disabled = false;
      }
      
      override public function getMainUiName() : String {
         return UIEnum.SMITH_MAGIC;
      }
      
      override public function getName() : String {
         return StorageState.SMITH_MAGIC_COOP_MOD;
      }
   }
}
