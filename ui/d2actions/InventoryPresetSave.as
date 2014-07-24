package d2actions
{
   public class InventoryPresetSave extends Object implements IAction
   {
      
      public function InventoryPresetSave(presetId:uint, symbolId:uint, saveEquipment:Boolean) {
         super();
         this._params = [presetId,symbolId,saveEquipment];
      }
      
      public static const NEED_INTERACTION:Boolean = false;
      
      public static const NEED_CONFIRMATION:Boolean = false;
      
      public static const MAX_USE_PER_FRAME:int = 0;
      
      public static const DELAY:int = 0;
      
      private var _params:Array;
      
      public function get parameters() : Array {
         return this._params;
      }
   }
}
