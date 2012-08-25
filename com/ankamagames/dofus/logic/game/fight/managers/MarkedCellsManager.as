package com.ankamagames.dofus.logic.game.fight.managers
{
    import __AS3__.vec.*;
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.enums.*;
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.atouin.renderers.*;
    import com.ankamagames.atouin.types.*;
    import com.ankamagames.atouin.utils.*;
    import com.ankamagames.dofus.datacenter.spells.*;
    import com.ankamagames.dofus.logic.game.fight.types.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.types.game.actions.fight.*;
    import com.ankamagames.dofus.types.entities.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.jerakine.types.zones.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import flash.utils.*;

    public class MarkedCellsManager extends Object implements IDestroyable
    {
        private var _marks:Dictionary;
        private var _glyphs:Dictionary;
        private var _markUid:uint;
        private static const MARK_SELECTIONS_PREFIX:String = "FightMark";
        private static var _log:Logger = Log.getLogger(getQualifiedClassName(MarkedCellsManager));
        private static var _self:MarkedCellsManager;

        public function MarkedCellsManager()
        {
            if (_self != null)
            {
                throw new SingletonError("MarkedCellsManager is a singleton and should not be instanciated directly.");
            }
            this._marks = new Dictionary(true);
            this._glyphs = new Dictionary(true);
            this._markUid = 0;
            return;
        }// end function

        public function addMark(param1:int, param2:int, param3:Spell, param4:Vector.<GameActionMarkedCell>) : void
        {
            var _loc_5:MarkInstance = null;
            var _loc_6:GameActionMarkedCell = null;
            var _loc_7:Selection = null;
            var _loc_8:uint = 0;
            if (!this._marks[param1] || this._marks[param1].cells.length == 0)
            {
                _loc_5 = new MarkInstance();
                _loc_5.markId = param1;
                _loc_5.markType = param2;
                _loc_5.associatedSpell = param3;
                _loc_5.selections = new Vector.<Selection>(0, false);
                _loc_5.cells = new Vector.<uint>(0, false);
                for each (_loc_6 in param4)
                {
                    
                    _loc_7 = new Selection();
                    _loc_7.color = new Color(_loc_6.cellColor);
                    _loc_7.renderer = new TrapZoneRenderer(PlacementStrataEnums.STRATA_NO_Z_ORDER);
                    if (_loc_6.cellsType == GameActionMarkCellsTypeEnum.CELLS_CROSS)
                    {
                        _loc_7.zone = new Cross(0, _loc_6.zoneSize, DataMapProvider.getInstance());
                    }
                    else
                    {
                        _loc_7.zone = new Lozenge(0, _loc_6.zoneSize, DataMapProvider.getInstance());
                    }
                    SelectionManager.getInstance().addSelection(_loc_7, this.getSelectionUid(), _loc_6.cellId);
                    for each (_loc_8 in _loc_7.cells)
                    {
                        
                        _loc_5.cells.push(_loc_8);
                    }
                    _loc_5.selections.push(_loc_7);
                }
                this._marks[param1] = _loc_5;
                this.updateDataMapProvider();
            }
            return;
        }// end function

        public function getMarkDatas(param1:int) : MarkInstance
        {
            return this._marks[param1];
        }// end function

        public function removeMark(param1:int) : void
        {
            var _loc_3:Selection = null;
            var _loc_2:* = (this._marks[param1] as MarkInstance).selections;
            for each (_loc_3 in _loc_2)
            {
                
                _loc_3.remove();
            }
            delete this._marks[param1];
            this.updateDataMapProvider();
            return;
        }// end function

        public function addGlyph(param1:Glyph, param2:int) : void
        {
            this._glyphs[param2] = param1;
            return;
        }// end function

        public function getGlyph(param1:int) : Glyph
        {
            return this._glyphs[param1] as Glyph;
        }// end function

        public function removeGlyph(param1:int) : void
        {
            if (this._glyphs[param1])
            {
                Glyph(this._glyphs[param1]).remove();
                delete this._glyphs[param1];
            }
            return;
        }// end function

        public function destroy() : void
        {
            var _loc_2:String = null;
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            var _loc_5:String = null;
            var _loc_1:* = new Array();
            for (_loc_2 in this._marks)
            {
                
                _loc_1.push(int(_loc_2));
            }
            _loc_3 = -1;
            _loc_4 = _loc_1.length;
            while (++_loc_3 < _loc_4)
            {
                
                this.removeMark(_loc_1[_loc_3]);
            }
            _loc_1.length = 0;
            for (_loc_5 in this._glyphs)
            {
                
                _loc_1.push(int(_loc_5));
            }
            ++_loc_3 = -1;
            _loc_4 = _loc_1.length;
            while (++_loc_3 < _loc_4)
            {
                
                this.removeGlyph(_loc_1[++_loc_3]);
            }
            _self = null;
            return;
        }// end function

        private function getSelectionUid() : String
        {
            var _loc_1:String = this;
            _loc_1._markUid = this._markUid + 1;
            return MARK_SELECTIONS_PREFIX + this._markUid++;
        }// end function

        private function updateDataMapProvider() : void
        {
            var _loc_2:MarkInstance = null;
            var _loc_3:DataMapProvider = null;
            var _loc_4:MapPoint = null;
            var _loc_5:uint = 0;
            var _loc_6:uint = 0;
            var _loc_1:Array = [];
            for each (_loc_2 in this._marks)
            {
                
                for each (_loc_6 in _loc_2.cells)
                {
                    
                    _loc_1[_loc_6] = _loc_1[_loc_6] | _loc_2.markType;
                }
            }
            _loc_3 = DataMapProvider.getInstance();
            _loc_5 = 0;
            while (_loc_5 < AtouinConstants.MAP_CELLS_COUNT)
            {
                
                _loc_4 = MapPoint.fromCellId(_loc_5);
                _loc_3.setSpecialEffects(_loc_5, (_loc_3.pointSpecialEffects(_loc_4.x, _loc_4.y) | 3) ^ 3);
                if (_loc_1[_loc_5])
                {
                    _loc_3.setSpecialEffects(_loc_5, _loc_3.pointSpecialEffects(_loc_4.x, _loc_4.y) | _loc_1[_loc_5]);
                }
                _loc_5 = _loc_5 + 1;
            }
            return;
        }// end function

        public static function getInstance() : MarkedCellsManager
        {
            if (_self == null)
            {
                _self = new MarkedCellsManager;
            }
            return _self;
        }// end function

    }
}
