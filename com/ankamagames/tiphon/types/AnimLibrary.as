package com.ankamagames.tiphon.types
{
   import com.ankamagames.jerakine.types.Swl;
   import com.ankamagames.tiphon.engine.BoneIndexManager;
   
   public class AnimLibrary extends GraphicLibrary
   {
      
      public function AnimLibrary(param1:uint, param2:Boolean=false) {
         super(param1,param2);
      }
      
      override public function addSwl(param1:Swl, param2:String) : void {
         var _loc3_:String = null;
         var _loc4_:Array = null;
         super.addSwl(param1,param2);
         for each (_loc3_ in param1.getDefinitions())
         {
            if(_loc3_.indexOf("_to_") != -1)
            {
               _loc4_ = _loc3_.split("_");
               BoneIndexManager.getInstance().addTransition(gfxId,_loc4_[0],_loc4_[2],parseInt(_loc4_[3]),_loc4_[0] + "_to_" + _loc4_[2]);
            }
         }
      }
   }
}
