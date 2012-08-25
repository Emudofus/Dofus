package com.ankamagames.dofus.logic.game.roleplay.types
{
    import com.ankamagames.dofus.datacenter.houses.*;
    import com.ankamagames.dofus.datacenter.world.*;
    import com.ankamagames.dofus.network.types.game.house.*;
    import com.ankamagames.dofus.network.types.game.paddock.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class Estate extends Object
    {
        public var name:String;
        public var area:String;
        public var price:uint;
        public var infos:Object;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(Estate));

        public function Estate(param1:Object)
        {
            var _loc_2:HouseInformationsForSell = null;
            var _loc_3:SubArea = null;
            var _loc_4:House = null;
            var _loc_5:Area = null;
            var _loc_6:PaddockInformationsForSell = null;
            var _loc_7:SubArea = null;
            var _loc_8:Area = null;
            if (param1 is HouseInformationsForSell)
            {
                _loc_2 = param1 as HouseInformationsForSell;
                _loc_3 = SubArea.getSubAreaById(_loc_2.subAreaId);
                _loc_4 = House.getGuildHouseById(_loc_2.modelId);
                if (!_loc_4)
                {
                    this.name = "-";
                }
                else
                {
                    this.name = _loc_4.name;
                }
                if (_loc_3)
                {
                    _loc_5 = Area.getAreaById(_loc_3.areaId);
                    if (!_loc_5)
                    {
                        this.area = "-";
                    }
                    else
                    {
                        this.area = _loc_5.name;
                    }
                }
                else
                {
                    this.area = "-";
                }
                this.price = _loc_2.price;
                this.infos = _loc_2;
            }
            else if (param1 is PaddockInformationsForSell)
            {
                _loc_6 = param1 as PaddockInformationsForSell;
                _loc_7 = SubArea.getSubAreaById(_loc_6.subAreaId);
                this.name = I18n.getUiText("ui.mount.paddockWithRoom", [_loc_6.nbMount]);
                if (_loc_7)
                {
                    _loc_8 = Area.getAreaById(_loc_7.areaId);
                    if (!_loc_8)
                    {
                        this.area = "-";
                    }
                    else
                    {
                        this.area = _loc_8.name;
                    }
                }
                else
                {
                    this.area = "-";
                }
                this.price = _loc_6.price;
                this.infos = _loc_6;
            }
            return;
        }// end function

    }
}
