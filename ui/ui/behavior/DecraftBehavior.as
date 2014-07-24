package ui.behavior
{
   import ui.AbstractStorageUi;
   
   public class DecraftBehavior extends CraftBehavior
   {
      
      public function DecraftBehavior() {
         super();
      }
      
      override public function attach(storageUi:AbstractStorageUi) : void {
         _showFilter = false;
         super.attach(storageUi);
      }
   }
}
