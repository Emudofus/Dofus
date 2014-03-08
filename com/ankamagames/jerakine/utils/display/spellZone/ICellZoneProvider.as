package com.ankamagames.jerakine.utils.display.spellZone
{
   import __AS3__.vec.Vector;
   
   public interface ICellZoneProvider
   {
      
      function get minimalRange() : uint;
      
      function get maximalRange() : uint;
      
      function get castZoneInLine() : Boolean;
      
      function get spellZoneEffects() : Vector.<IZoneShape>;
   }
}
