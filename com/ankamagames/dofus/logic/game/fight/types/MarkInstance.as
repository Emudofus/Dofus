package com.ankamagames.dofus.logic.game.fight.types
{
   import com.ankamagames.dofus.datacenter.spells.Spell;
   import __AS3__.vec.Vector;
   import com.ankamagames.atouin.types.Selection;
   
   public class MarkInstance extends Object
   {
      
      public function MarkInstance() {
         super();
      }
      
      public var markId:int;
      
      public var markType:int;
      
      public var associatedSpell:Spell;
      
      public var selections:Vector.<Selection>;
      
      public var cells:Vector.<uint>;
   }
}
