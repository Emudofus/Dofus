package d2actions
{
   public class PlayerFightRequest extends Object implements IAction
   {
      
      public function PlayerFightRequest(targetedPlayerId:uint, ava:Boolean, friendly:Boolean = true, launch:Boolean = false, cellId:int = -1) {
         super();
         this._params = [targetedPlayerId,ava,friendly,launch,cellId];
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
