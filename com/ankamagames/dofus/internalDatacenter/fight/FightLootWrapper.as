package com.ankamagames.dofus.internalDatacenter.fight
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
    import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
    import com.ankamagames.dofus.network.types.game.context.fight.FightLoot;
    import __AS3__.vec.*;

    public class FightLootWrapper implements IDataCenter 
    {

        public var objects:Array;
        public var kamas:uint;

        public function FightLootWrapper(loot:FightLoot)
        {
            this.objects = new Array();
            var i:uint;
            while (i < loot.objects.length)
            {
                this.objects.push(ItemWrapper.create(63, 0, loot.objects[i], loot.objects[(i + 1)], new Vector.<ObjectEffect>(), false));
                i = (i + 2);
            };
            this.kamas = loot.kamas;
        }

    }
}//package com.ankamagames.dofus.internalDatacenter.fight

