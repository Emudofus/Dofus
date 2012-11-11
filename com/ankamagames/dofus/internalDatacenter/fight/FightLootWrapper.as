package com.ankamagames.dofus.internalDatacenter.fight
{
    import com.ankamagames.dofus.internalDatacenter.items.*;
    import com.ankamagames.dofus.network.types.game.context.fight.*;
    import com.ankamagames.dofus.network.types.game.data.items.effects.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class FightLootWrapper extends Object implements IDataCenter
    {
        public var objects:Array;
        public var kamas:uint;

        public function FightLootWrapper(param1:FightLoot)
        {
            this.objects = new Array();
            var _loc_2:* = 0;
            while (_loc_2 < param1.objects.length)
            {
                
                this.objects.push(ItemWrapper.create(63, 0, param1.objects[_loc_2], param1.objects[(_loc_2 + 1)], new Vector.<ObjectEffect>, false));
                _loc_2 = _loc_2 + 2;
            }
            this.kamas = param1.kamas;
            return;
        }// end function

    }
}
