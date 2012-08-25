package com.ankamagames.dofus.logic.game.fight.managers
{
    import com.ankamagames.atouin.enums.*;
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.atouin.renderers.*;
    import com.ankamagames.atouin.types.*;
    import com.ankamagames.atouin.utils.*;
    import com.ankamagames.dofus.datacenter.effects.*;
    import com.ankamagames.dofus.internalDatacenter.spells.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.jerakine.types.zones.*;
    import com.ankamagames.jerakine.utils.display.spellZone.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import flash.utils.*;

    public class SpellZoneManager extends Object implements IDestroyable
    {
        private var _targetSelection:Selection;
        private var _spellWrapper:Object;
        private static var _log:Logger = Log.getLogger(getQualifiedClassName(SpellZoneManager));
        private static var _self:SpellZoneManager;
        private static const ZONE_COLOR:Color = new Color(10929860);
        private static const SELECTION_ZONE:String = "SpellCastZone";

        public function SpellZoneManager()
        {
            if (_self != null)
            {
                throw new SingletonError("SpellZoneManager is a singleton and should not be instanciated directly.");
            }
            return;
        }// end function

        public function destroy() : void
        {
            _self = null;
            return;
        }// end function

        public function displaySpellZone(param1:int, param2:int, param3:int, param4:uint, param5:uint) : void
        {
            this._spellWrapper = SpellWrapper.create(0, param4, param5, false, param1);
            if (this._spellWrapper && param2 != -1 && param3 != -1)
            {
                this._targetSelection = new Selection();
                this._targetSelection.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_NO_Z_ORDER);
                this._targetSelection.color = ZONE_COLOR;
                this._targetSelection.zone = this.getSpellZone();
                this._targetSelection.zone.direction = MapPoint.fromCellId(param3).advancedOrientationTo(MapPoint.fromCellId(param2), false);
                SelectionManager.getInstance().addSelection(this._targetSelection, SELECTION_ZONE);
                SelectionManager.getInstance().update(SELECTION_ZONE, param2);
            }
            else
            {
                this.removeTarget();
            }
            return;
        }// end function

        public function removeSpellZone() : void
        {
            this.removeTarget();
            return;
        }// end function

        private function removeTarget() : void
        {
            var _loc_1:* = SelectionManager.getInstance().getSelection(SELECTION_ZONE);
            if (_loc_1)
            {
                _loc_1.remove();
            }
            return;
        }// end function

        private function getSpellZone() : IZone
        {
            var _loc_2:uint = 0;
            var _loc_3:EffectInstance = null;
            var _loc_4:Cross = null;
            var _loc_5:Square = null;
            var _loc_6:Cross = null;
            var _loc_7:Cross = null;
            var _loc_8:Cross = null;
            var _loc_9:Cross = null;
            var _loc_1:uint = 88;
            _loc_2 = 666;
            for each (_loc_3 in this._spellWrapper["effects"])
            {
                
                if (_loc_3.zoneShape != 0 && _loc_3.zoneSize > 0)
                {
                    _loc_2 = Math.min(_loc_2, _loc_3.zoneSize);
                    _loc_1 = _loc_3.zoneShape;
                }
            }
            if (_loc_2 == 666)
            {
                _loc_2 = 0;
            }
            switch(_loc_1)
            {
                case SpellShapeEnum.X:
                {
                    return new Cross(0, _loc_2, DataMapProvider.getInstance());
                }
                case SpellShapeEnum.L:
                {
                    return new Line(_loc_2, DataMapProvider.getInstance());
                }
                case SpellShapeEnum.T:
                {
                    _loc_4 = new Cross(0, _loc_2, DataMapProvider.getInstance());
                    _loc_4.onlyPerpendicular = true;
                    return _loc_4;
                }
                case SpellShapeEnum.D:
                {
                    return new Cross(0, _loc_2, DataMapProvider.getInstance());
                }
                case SpellShapeEnum.C:
                {
                    return new Lozenge(0, _loc_2, DataMapProvider.getInstance());
                }
                case SpellShapeEnum.I:
                {
                    return new Lozenge(_loc_2, 63, DataMapProvider.getInstance());
                }
                case SpellShapeEnum.O:
                {
                    return new Lozenge(_loc_2, _loc_2, DataMapProvider.getInstance());
                }
                case SpellShapeEnum.Q:
                {
                    return new Cross(1, _loc_2, DataMapProvider.getInstance());
                }
                case SpellShapeEnum.G:
                {
                    return new Square(0, _loc_2, DataMapProvider.getInstance());
                }
                case SpellShapeEnum.V:
                {
                    return new Cone(0, _loc_2, DataMapProvider.getInstance());
                }
                case SpellShapeEnum.W:
                {
                    _loc_5 = new Square(0, _loc_2, DataMapProvider.getInstance());
                    _loc_5.diagonalFree = true;
                    return _loc_5;
                }
                case SpellShapeEnum.plus:
                {
                    _loc_6 = new Cross(0, _loc_2, DataMapProvider.getInstance());
                    _loc_6.diagonal = true;
                    return _loc_6;
                }
                case SpellShapeEnum.sharp:
                {
                    _loc_7 = new Cross(1, _loc_2, DataMapProvider.getInstance());
                    _loc_7.diagonal = true;
                    return _loc_7;
                }
                case SpellShapeEnum.star:
                {
                    _loc_8 = new Cross(0, _loc_2, DataMapProvider.getInstance());
                    _loc_8.allDirections = true;
                    return _loc_8;
                }
                case SpellShapeEnum.slash:
                {
                    return new Line(_loc_2, DataMapProvider.getInstance());
                }
                case SpellShapeEnum.minus:
                {
                    _loc_9 = new Cross(0, _loc_2, DataMapProvider.getInstance());
                    _loc_9.onlyPerpendicular = true;
                    _loc_9.diagonal = true;
                    return _loc_9;
                }
                case SpellShapeEnum.U:
                {
                    return new HalfLozenge(0, _loc_2, DataMapProvider.getInstance());
                }
                case SpellShapeEnum.A:
                {
                    return new Lozenge(0, 63, DataMapProvider.getInstance());
                }
                case SpellShapeEnum.P:
                {
                }
                default:
                {
                    _log.debug("spell shape : " + _loc_1);
                    return new Cross(0, 0, DataMapProvider.getInstance());
                    break;
                }
            }
        }// end function

        public static function getInstance() : SpellZoneManager
        {
            if (_self == null)
            {
                _self = new SpellZoneManager;
            }
            return _self;
        }// end function

    }
}
