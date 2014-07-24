package d2actions
{
   public class TeleportToBuddyAnswer extends Object implements IAction
   {
      
      public function TeleportToBuddyAnswer(dungeonId:int, buddyId:int, accept:Boolean) {
         super();
         this._params = [dungeonId,buddyId,accept];
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
