package ui.behavior
{
   import ui.enum.StorageState;
   import d2enums.SelectMethodEnum;
   import d2hooks.*;
   import d2actions.ExchangeObjectMove;
   
   public class MountBehavior extends BankBehavior
   {
      
      public function MountBehavior() {
         super();
      }
      
      override public function getName() : String {
         return StorageState.MOUNT_MOD;
      }
      
      override public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void {
         var item:Object = null;
         var maxQuantity:uint = 0;
         var weightLeft:uint = 0;
         if(target == _storage.grid)
         {
            item = _storage.grid.selectedItem;
            if(selectMethod == SelectMethodEnum.CTRL_DOUBLE_CLICK)
            {
               if(Api.inventory.getItem(item.objectUID))
               {
                  maxQuantity = item.quantity;
                  weightLeft = Api.storage.dracoTurkyMaxInventoryWeight() - Api.storage.dracoTurkyInventoryWeight();
                  if(item.realWeight * item.quantity > weightLeft)
                  {
                     maxQuantity = Math.floor(weightLeft / item.realWeight);
                  }
                  Api.system.sendAction(new ExchangeObjectMove(item.objectUID,maxQuantity));
               }
            }
            else
            {
               super.onSelectItem(target,selectMethod,isNewSelection);
            }
         }
      }
   }
}
