package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class MapCharactersItemCriterion extends ItemCriterion implements IDataCenter
    {
        private var _mapId:int;
        private var _nbCharacters:uint;

        public function MapCharactersItemCriterion(param1:String)
        {
            super(param1);
            var _loc_2:* = _criterionValueText.split(",");
            if (_loc_2.length == 1)
            {
                this._mapId = PlayedCharacterManager.getInstance().currentMap.mapId;
                this._nbCharacters = uint(_loc_2[0]);
            }
            else if (_loc_2.length == 2)
            {
                this._mapId = int(_loc_2[0]);
                this._nbCharacters = uint(_loc_2[1]);
            }
            return;
        }// end function

        override public function get text() : String
        {
            var _loc_1:* = I18n.getUiText("ui.criterion.MK", [this._mapId]);
            return _loc_1 + " " + _operator.text + " " + this._nbCharacters;
        }// end function

        override public function clone() : IItemCriterion
        {
            var _loc_1:* = new MapCharactersItemCriterion(this.basicText);
            return _loc_1;
        }// end function

        override protected function getCriterion() : int
        {
            return PlayedCharacterManager.getInstance().infos.level;
        }// end function

    }
}
