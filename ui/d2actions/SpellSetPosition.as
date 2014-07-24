package d2actions
{
   public class SpellSetPosition extends Object implements IAction
   {
      
      public function SpellSetPosition(spellID:uint, position:uint) {
         super();
         this._params = [spellID,position];
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
