package d2actions
{
   public class MountToggleRidingRequest extends Object implements IAction
   {
      
      public function MountToggleRidingRequest() {
         super();
         this._params = [];
      }
      
      public static const NEED_INTERACTION:Boolean = false;
      
      public static const NEED_CONFIRMATION:Boolean = false;
      
      public static const MAX_USE_PER_FRAME:int = 1;
      
      public static const DELAY:int = 1000;
      
      private var _params:Array;
      
      public function get parameters() : Array {
         return this._params;
      }
   }
}
