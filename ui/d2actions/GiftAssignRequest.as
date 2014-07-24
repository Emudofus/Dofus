package d2actions
{
   public class GiftAssignRequest extends Object implements IAction
   {
      
      public function GiftAssignRequest(giftId:uint, characterId:uint) {
         super();
         this._params = [giftId,characterId];
      }
      
      public static const NEED_INTERACTION:Boolean = false;
      
      public static const NEED_CONFIRMATION:Boolean = false;
      
      public static const MAX_USE_PER_FRAME:int = 1;
      
      public static const DELAY:int = 0;
      
      private var _params:Array;
      
      public function get parameters() : Array {
         return this._params;
      }
   }
}
