package com.ankamagames.dofus.misc.utils
{
   import com.ankamagames.tiphon.types.ISkinPartTransformProvider;
   import com.ankamagames.tiphon.types.Skin;
   import com.ankamagames.dofus.datacenter.appearance.SkinPosition;
   
   public class SkinPartTransformProvider extends Object implements ISkinPartTransformProvider
   {
      
      public function SkinPartTransformProvider() {
         super();
      }
      
      public function init(param1:Skin) : void {
         var _loc2_:uint = 0;
         var _loc3_:SkinPosition = null;
         var _loc4_:uint = 0;
         for each (_loc2_ in param1.skinList)
         {
            _loc3_ = SkinPosition.getSkinPositionById(_loc2_);
            if(_loc3_)
            {
               _loc4_ = 0;
               while(_loc4_ < _loc3_.skin.length)
               {
                  param1.addTransform(_loc3_.clip[_loc4_],_loc3_.skin[_loc4_],_loc3_.transformation[_loc4_]);
                  _loc4_++;
               }
            }
         }
      }
   }
}
