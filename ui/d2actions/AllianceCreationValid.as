package d2actions
{
   public class AllianceCreationValid extends Object implements IAction
   {
      
      public function AllianceCreationValid(pAllianceName:String, pAllianceTag:String, pUpEmblemId:uint, pUpColorEmblem:uint, pBackEmblemId:uint, pBackColorEmblem:uint) {
         super();
         this._params = [pAllianceName,pAllianceTag,pUpEmblemId,pUpColorEmblem,pBackEmblemId,pBackColorEmblem];
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
