package d2actions
{
   public class PartyKickRequest extends Object implements IAction
   {
      
      public function PartyKickRequest(partyId:int, playerId:uint) {
         super();
         this._params = [partyId,playerId];
      }
      
      public static const NEED_INTERACTION:Boolean = false;
      
      public static const NEED_CONFIRMATION:Boolean = false;
      
      public static const MAX_USE_PER_FRAME:int = 8;
      
      public static const DELAY:int = 0;
      
      private var _params:Array;
      
      public function get parameters() : Array {
         return this._params;
      }
   }
}
