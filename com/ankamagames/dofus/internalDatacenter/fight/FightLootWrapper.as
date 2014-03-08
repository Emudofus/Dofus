package com.ankamagames.dofus.internalDatacenter.fight
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.network.types.game.context.fight.FightLoot;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import __AS3__.vec.*;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
   
   public class FightLootWrapper extends Object implements IDataCenter
   {
      
      public function FightLootWrapper(loot:FightLoot) {
         super();
         this.objects = new Array();
         var i:uint = 0;
         while(i < loot.objects.length)
         {
            this.objects.push(ItemWrapper.create(63,0,loot.objects[i],loot.objects[i + 1],new Vector.<ObjectEffect>(),false));
            i = i + 2;
         }
         this.kamas = loot.kamas;
      }
      
      public var objects:Array;
      
      public var kamas:uint;
   }
}
