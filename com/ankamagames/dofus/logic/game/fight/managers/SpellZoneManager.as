package com.ankamagames.dofus.logic.game.fight.managers
{
    import com.ankamagames.jerakine.interfaces.IDestroyable;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.types.Color;
    import com.ankamagames.atouin.types.Selection;
    import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
    import com.ankamagames.jerakine.utils.errors.SingletonError;
    import com.ankamagames.atouin.renderers.ZoneDARenderer;
    import com.ankamagames.atouin.enums.PlacementStrataEnums;
    import com.ankamagames.jerakine.types.positions.MapPoint;
    import com.ankamagames.atouin.managers.SelectionManager;
    import com.ankamagames.dofus.datacenter.effects.EffectInstance;
    import com.ankamagames.jerakine.utils.display.spellZone.SpellShapeEnum;
    import com.ankamagames.jerakine.types.zones.IZone;
    import com.ankamagames.jerakine.types.zones.Cross;
    import com.ankamagames.jerakine.types.zones.Square;
    import com.ankamagames.atouin.utils.DataMapProvider;
    import com.ankamagames.jerakine.types.zones.Line;
    import com.ankamagames.jerakine.types.zones.Lozenge;
    import com.ankamagames.jerakine.types.zones.Cone;
    import com.ankamagames.jerakine.types.zones.HalfLozenge;

    public class SpellZoneManager implements IDestroyable 
    {

        private static var _log:Logger = Log.getLogger(getQualifiedClassName(SpellZoneManager));
        private static var _self:SpellZoneManager;
        private static const ZONE_COLOR:Color = new Color(10929860);
        private static const SELECTION_ZONE:String = "SpellCastZone";

        private var _targetSelection:Selection;
        private var _spellWrapper:SpellWrapper;

        public function SpellZoneManager()
        {
            if (_self != null)
            {
                throw (new SingletonError("SpellZoneManager is a singleton and should not be instanciated directly."));
            };
        }

        public static function getInstance():SpellZoneManager
        {
            if (_self == null)
            {
                _self = new (SpellZoneManager)();
            };
            return (_self);
        }


        public function destroy():void
        {
            _self = null;
        }

        public function displaySpellZone(casterId:int, targetCellId:int, sourceCellId:int, spellId:uint, spellLevelId:uint):void
        {
            this._spellWrapper = SpellWrapper.create(0, spellId, spellLevelId, false, casterId);
            if (((((this._spellWrapper) && (!((targetCellId == -1))))) && (!((sourceCellId == -1)))))
            {
                this._targetSelection = new Selection();
                this._targetSelection.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA);
                this._targetSelection.color = ZONE_COLOR;
                this._targetSelection.zone = this.getSpellZone(this._spellWrapper);
                this._targetSelection.zone.direction = MapPoint.fromCellId(sourceCellId).advancedOrientationTo(MapPoint.fromCellId(targetCellId), false);
                SelectionManager.getInstance().addSelection(this._targetSelection, SELECTION_ZONE);
                SelectionManager.getInstance().update(SELECTION_ZONE, targetCellId);
            }
            else
            {
                this.removeTarget();
            };
        }

        public function removeSpellZone():void
        {
            this.removeTarget();
        }

        private function removeTarget():void
        {
            var s:Selection = SelectionManager.getInstance().getSelection(SELECTION_ZONE);
            if (s)
            {
                s.remove();
            };
        }

        public function getSpellZone(spell:*, ignoreShapeA:Boolean=false):IZone
        {
            var fx:EffectInstance;
            var shape:uint = 88;
            var ray:uint;
            var minRay:uint;
            if (!(spell.hasOwnProperty("shape")))
            {
                for each (fx in spell.effects)
                {
                    if (((((!((fx.zoneShape == 0))) && ((fx.zoneSize < 63)))) && ((((fx.zoneSize > ray)) || ((((fx.zoneSize == ray)) && ((shape == SpellShapeEnum.P))))))))
                    {
                        shape = fx.zoneShape;
                        ray = uint(fx.zoneSize);
                        minRay = uint(fx.zoneMinSize);
                    };
                };
            }
            else
            {
                shape = spell.shape;
                ray = spell.ray;
            };
            return (this.getZone(shape, ray, minRay, ignoreShapeA));
        }

        public function getZone(pShape:uint, pZoneSize:uint, pMinZoneSize:uint, pIgnoreShapeA:Boolean=false):IZone
        {
            var _local_5:Cross;
            var _local_6:Square;
            var _local_7:Cross;
            var _local_8:Cross;
            var _local_9:Cross;
            var _local_10:Cross;
            switch (pShape)
            {
                case SpellShapeEnum.X:
                    return (new Cross(0, pZoneSize, DataMapProvider.getInstance()));
                case SpellShapeEnum.L:
                    return (new Line(pZoneSize, DataMapProvider.getInstance()));
                case SpellShapeEnum.T:
                    _local_5 = new Cross(0, pZoneSize, DataMapProvider.getInstance());
                    _local_5.onlyPerpendicular = true;
                    return (_local_5);
                case SpellShapeEnum.D:
                    return (new Cross(0, pZoneSize, DataMapProvider.getInstance()));
                case SpellShapeEnum.C:
                    return (new Lozenge(pMinZoneSize, pZoneSize, DataMapProvider.getInstance()));
                case SpellShapeEnum.O:
                    return (new Lozenge(pZoneSize, pZoneSize, DataMapProvider.getInstance()));
                case SpellShapeEnum.Q:
                    return (new Cross(((pMinZoneSize) ? pMinZoneSize : 1), pZoneSize, DataMapProvider.getInstance()));
                case SpellShapeEnum.V:
                    return (new Cone(0, pZoneSize, DataMapProvider.getInstance()));
                case SpellShapeEnum.W:
                    _local_6 = new Square(0, pZoneSize, DataMapProvider.getInstance());
                    _local_6.diagonalFree = true;
                    return (_local_6);
                case SpellShapeEnum.plus:
                    _local_7 = new Cross(0, pZoneSize, DataMapProvider.getInstance());
                    _local_7.diagonal = true;
                    return (_local_7);
                case SpellShapeEnum.sharp:
                    _local_8 = new Cross(pMinZoneSize, pZoneSize, DataMapProvider.getInstance());
                    _local_8.diagonal = true;
                    return (_local_8);
                case SpellShapeEnum.slash:
                    return (new Line(pZoneSize, DataMapProvider.getInstance()));
                case SpellShapeEnum.star:
                    _local_9 = new Cross(0, pZoneSize, DataMapProvider.getInstance());
                    _local_9.allDirections = true;
                    return (_local_9);
                case SpellShapeEnum.minus:
                    _local_10 = new Cross(0, pZoneSize, DataMapProvider.getInstance());
                    _local_10.onlyPerpendicular = true;
                    _local_10.diagonal = true;
                    return (_local_10);
                case SpellShapeEnum.G:
                    return (new Square(0, pZoneSize, DataMapProvider.getInstance()));
                case SpellShapeEnum.I:
                    return (new Lozenge(pZoneSize, 63, DataMapProvider.getInstance()));
                case SpellShapeEnum.U:
                    return (new HalfLozenge(0, pZoneSize, DataMapProvider.getInstance()));
                case SpellShapeEnum.A:
                    if (!(pIgnoreShapeA))
                    {
                        return (new Lozenge(0, 63, DataMapProvider.getInstance()));
                    };
                case SpellShapeEnum.P:
                default:
                    return (new Cross(0, 0, DataMapProvider.getInstance()));
            };
        }


    }
}//package com.ankamagames.dofus.logic.game.fight.managers

