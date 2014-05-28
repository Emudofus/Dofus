package com.ankamagames.dofus.types.entities
{
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   
   public class Glyph extends Projectile
   {
      
      public function Glyph(nId:int, look:TiphonEntityLook, postInit:Boolean = false, startPlayingOnlyWhenDisplayed:Boolean = true, glyphType:uint = 0) {
         super(nId,look,postInit,startPlayingOnlyWhenDisplayed);
         this.glyphType = glyphType;
      }
      
      public var glyphType:uint;
   }
}
