package com.ankamagames.tiphon.types.cache
{
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   
   public class SpriteCacheInfo extends Object
   {
      
      public function SpriteCacheInfo(tiphonSprite:TiphonSprite, tiphonEntityLook:TiphonEntityLook) {
         super();
         this.sprite = tiphonSprite;
         this.look = tiphonEntityLook;
      }
      
      public var sprite:TiphonSprite;
      
      public var look:TiphonEntityLook;
   }
}
