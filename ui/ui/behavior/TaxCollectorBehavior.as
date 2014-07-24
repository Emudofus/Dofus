package ui.behavior
{
   import ui.AbstractStorageUi;
   import ui.enum.StorageState;
   
   public class TaxCollectorBehavior extends BankBehavior
   {
      
      public function TaxCollectorBehavior() {
         super();
      }
      
      override public function attach(storageUi:AbstractStorageUi) : void {
         super.attach(storageUi);
         _storage.btnMoveAll.visible = false;
      }
      
      override public function detach() : void {
         super.detach();
         _storage.btnMoveAll.visible = true;
      }
      
      override public function getName() : String {
         return StorageState.TAXCOLLECTOR_MOD;
      }
   }
}
