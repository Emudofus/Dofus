package com.ankamagames.dofus.types.data
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.datacenter.effects.*;
    import com.ankamagames.dofus.datacenter.items.*;
    import com.ankamagames.dofus.misc.*;

    public class PlayerSetInfo extends Object
    {
        public var setId:uint = 0;
        public var setName:String;
        public var allItems:Vector.<uint>;
        public var setObjects:Vector.<uint>;
        public var setEffects:Vector.<EffectInstance>;

        public function PlayerSetInfo(param1:uint, param2:Vector.<uint>, param3:Vector.<ObjectEffect>)
        {
            this.setObjects = new Vector.<uint>;
            var _loc_4:* = ItemSet.getItemSetById(param1);
            this.setName = _loc_4.name;
            this.allItems = _loc_4.items;
            this.setId = param1;
            this.setObjects = param2;
            var _loc_5:* = param3.length;
            this.setEffects = new Vector.<EffectInstance>(_loc_5);
            var _loc_6:int = 0;
            while (_loc_6 < _loc_5)
            {
                
                this.setEffects[_loc_6] = ObjectEffectAdapter.fromNetwork(param3[_loc_6]);
                _loc_6++;
            }
            return;
        }// end function

    }
}

class ItemSet extends Object
{
    public var item:ItemWrapper;
    public var masks:Dictionary;

    function ItemSet()
    {
        return;
    }// end function

}

