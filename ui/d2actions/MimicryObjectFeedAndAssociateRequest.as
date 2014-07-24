package d2actions
{
   public class MimicryObjectFeedAndAssociateRequest extends Object implements IAction
   {
      
      public function MimicryObjectFeedAndAssociateRequest(mimicryUID:uint, mimicryPos:uint, foodUID:uint, foodPos:uint, hostUID:uint, hostPos:uint, preview:Boolean) {
         super();
         this._params = [mimicryUID,mimicryPos,foodUID,foodPos,hostUID,hostPos,preview];
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
