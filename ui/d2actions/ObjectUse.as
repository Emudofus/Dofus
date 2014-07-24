package d2actions
{
   public class ObjectUse extends Object implements IAction
   {
      
      public function ObjectUse(objectUID:uint, quantity:int = 1, useOnCell:Boolean = false) {
         super();
         this._params = [objectUID,quantity,useOnCell];
      }
      
      public static const NEED_INTERACTION:Boolean = false;
      
      public static const NEED_CONFIRMATION:Boolean = true;
      
      public static const MAX_USE_PER_FRAME:int = 0;
      
      public static const DELAY:int = 0;
      
      private var _params:Array;
      
      public function get parameters() : Array {
         return this._params;
      }
   }
}
