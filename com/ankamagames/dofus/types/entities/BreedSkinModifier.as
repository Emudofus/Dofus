package com.ankamagames.dofus.types.entities
{
   import com.ankamagames.tiphon.types.ISkinModifier;
   import com.ankamagames.tiphon.types.Skin;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   
   public class BreedSkinModifier extends Object implements ISkinModifier
   {
      
      public function BreedSkinModifier() {
         super();
      }
      
      public function getModifiedSkin(skin:Skin, requestedPart:String, look:TiphonEntityLook) : String {
         var newPart:String = null;
         if((!look) || (!look.skins) || (!requestedPart) || (!skin))
         {
            return requestedPart;
         }
         var partInfo:Array = requestedPart.split("_");
         var i:int = look.skins.length - 1;
         while(i >= 0)
         {
            newPart = partInfo[0] + "_" + look.skins[i] + "_" + partInfo[1];
            if(skin.getPart(newPart) != null)
            {
               return newPart;
            }
            i--;
         }
         return requestedPart;
      }
   }
}
