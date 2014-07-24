package d2actions
{
   public class ObjectDrop extends Object implements IAction
   {
      
      public function ObjectDrop(pObjectUID:uint, pObjectGID:uint, pQuantity:uint) {
         super();
         this._params = [pObjectUID,pObjectGID,pQuantity];
      }
      
      public static const NEED_INTERACTION:Boolean = true;
      
      public static const NEED_CONFIRMATION:Boolean = true;
      
      public static const MAX_USE_PER_FRAME:int = 1;
      
      public static const DELAY:int = 0;
      
      private var _params:Array;
      
      public function get parameters() : Array {
         return this._params;
      }
   }
}
