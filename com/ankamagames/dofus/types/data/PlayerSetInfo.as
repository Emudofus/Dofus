package com.ankamagames.dofus.types.data
{
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
   import com.ankamagames.dofus.datacenter.items.ItemSet;
   import com.ankamagames.dofus.misc.ObjectEffectAdapter;
   
   public class PlayerSetInfo extends Object
   {
      
      public function PlayerSetInfo(id:uint, items:Vector.<uint>, effects:Vector.<ObjectEffect>) {
         this.setObjects = new Vector.<uint>();
         super();
         var itemSet:ItemSet = ItemSet.getItemSetById(id);
         this.setName = itemSet.name;
         this.allItems = itemSet.items;
         this.setId = id;
         this.setObjects = items;
         var nEffect:int = effects.length;
         this.setEffects = new Vector.<EffectInstance>(nEffect);
         var i:int = 0;
         while(i < nEffect)
         {
            this.setEffects[i] = ObjectEffectAdapter.fromNetwork(effects[i]);
            i++;
         }
      }
      
      public var setId:uint = 0;
      
      public var setName:String;
      
      public var allItems:Vector.<uint>;
      
      public var setObjects:Vector.<uint>;
      
      public var setEffects:Vector.<EffectInstance>;
   }
}
