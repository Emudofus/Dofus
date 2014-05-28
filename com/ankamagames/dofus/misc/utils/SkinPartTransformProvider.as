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
      
      public function init(skin:Skin) : void {
         var skinId:uint = 0;
         var sp:SkinPosition = null;
         var i:uint = 0;
         for each(skinId in skin.skinList)
         {
            sp = SkinPosition.getSkinPositionById(skinId);
            if(sp)
            {
               i = 0;
               while(i < sp.skin.length)
               {
                  skin.addTransform(sp.clip[i],sp.skin[i],sp.transformation[i]);
                  i++;
               }
            }
         }
      }
   }
}
