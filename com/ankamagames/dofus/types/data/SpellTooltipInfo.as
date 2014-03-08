package com.ankamagames.dofus.types.data
{
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   
   public class SpellTooltipInfo extends Object
   {
      
      public function SpellTooltipInfo(param1:SpellWrapper, param2:String=null) {
         super();
         this.spellWrapper = param1;
         this.shortcutKey = param2;
      }
      
      public var spellWrapper:SpellWrapper;
      
      public var shortcutKey:String;
   }
}
