package com.ankamagames.dofus.datacenter.spells
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   
   public class SpellBomb extends Object implements IDataCenter
   {
      
      public function SpellBomb() {
         super();
      }
      
      public static const MODULE:String = "SpellBombs";
      
      public static function getSpellBombById(param1:int) : SpellBomb {
         return GameData.getObject(MODULE,param1) as SpellBomb;
      }
      
      public var id:int;
      
      public var chainReactionSpellId:int;
      
      public var explodSpellId:int;
      
      public var wallId:int;
      
      public var instantSpellId:int;
      
      public var comboCoeff:int;
   }
}
