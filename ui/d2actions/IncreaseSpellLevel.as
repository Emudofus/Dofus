package d2actions
{
   public class IncreaseSpellLevel extends Object implements IAction
   {
      
      public function IncreaseSpellLevel(pSpellId:uint, pSpellLevel:uint) {
         super();
         this._params = [pSpellId,pSpellLevel];
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
