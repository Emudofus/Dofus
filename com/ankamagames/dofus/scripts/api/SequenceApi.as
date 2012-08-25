package com.ankamagames.dofus.scripts.api
{
    import __AS3__.vec.*;
    import com.ankamagames.atouin.types.sequences.*;
    import com.ankamagames.atouin.utils.*;
    import com.ankamagames.dofus.datacenter.effects.*;
    import com.ankamagames.dofus.logic.game.fight.steps.*;
    import com.ankamagames.dofus.scripts.*;
    import com.ankamagames.dofus.types.sequences.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.sequencer.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.jerakine.types.zones.*;
    import com.ankamagames.jerakine.utils.display.spellZone.*;
    import com.ankamagames.tiphon.display.*;
    import com.ankamagames.tiphon.sequence.*;
    import com.ankamagames.tiphon.types.*;
    import flash.display.*;

    public class SequenceApi extends Object
    {

        public function SequenceApi()
        {
            return;
        }// end function

        public static function CreateSerialSequencer() : ISequencer
        {
            return new SerialSequencer();
        }// end function

        public static function CreateParallelStartSequenceStep(param1:Array, param2:Boolean = true, param3:Boolean = false) : ISequencable
        {
            return new ParallelStartSequenceStep(param1, param2, param3);
        }// end function

        public static function CreateStartSequenceStep(param1:ISequencer) : ISequencable
        {
            return new StartSequenceStep(param1);
        }// end function

        public static function CreateAddGfxEntityStep(param1:FxRunner, param2:uint, param3:MapPoint, param4:Number = 0, param5:int = 0, param6:uint = 0, param7:MapPoint = null, param8:MapPoint = null, param9:Boolean = false) : ISequencable
        {
            return new AddGfxEntityStep(param2, param3.cellId, param4, (-DisplayObject(param1.caster).height) * param5 / 10, param6, param7, param8, param9);
        }// end function

        public static function CreateAddGlyphGfxStep(param1:SpellFxRunner, param2:uint, param3:MapPoint, param4:int) : ISequencable
        {
            return new AddGlyphGfxStep(param2, param3.cellId, param4, param1.castingSpell.markType);
        }// end function

        public static function CreatePlayAnimationStep(param1:TiphonSprite, param2:String, param3:Boolean, param4:Boolean, param5:String = "animation_event_end", param6:int = 1) : ISequencable
        {
            return new PlayAnimationStep(param1, param2, param3, param4, param5, param6);
        }// end function

        public static function CreateSetDirectionStep(param1:TiphonSprite, param2:uint) : ISequencable
        {
            return new SetDirectionStep(param1, param2);
        }// end function

        public static function CreateParableGfxMovementStep(param1:FxRunner, param2:IMovable, param3:MapPoint, param4:Number = 100, param5:Number = 0.5, param6:int = 0, param7:Boolean = true) : ParableGfxMovementStep
        {
            var _loc_8:int = 0;
            var _loc_9:* = TiphonSprite(param1.caster).parent;
            while (_loc_9)
            {
                
                if (_loc_9 is CarriedSprite)
                {
                    _loc_8 = _loc_8 + _loc_9.y;
                }
                _loc_9 = _loc_9.parent;
            }
            return new ParableGfxMovementStep(param2, param3, param4, param5, (-DisplayObject(param1.caster).height) * param6 / 10 + _loc_8, param7);
        }// end function

        public static function CreateAddGfxInLineStep(param1:SpellFxRunner, param2:uint, param3:MapPoint, param4:MapPoint, param5:Number = 0, param6:uint = 0, param7:Number = 0, param8:Number = 0, param9:Boolean = false, param10:Boolean = false, param11:Boolean = false, param12:Boolean = false, param13:Boolean = false) : AddGfxInLineStep
        {
            var _loc_16:Vector.<uint> = null;
            var _loc_17:uint = 0;
            var _loc_18:uint = 0;
            var _loc_19:EffectInstance = null;
            var _loc_20:IZone = null;
            var _loc_21:Cross = null;
            var _loc_14:* = param1.castingSpell.spell.spellLevels.indexOf(param1.castingSpell.spellRank.id);
            var _loc_15:* = 1 + (param7 + (param8 - param7) * _loc_14 / 6) / 10;
            if (param12)
            {
                _loc_17 = 88;
                _loc_18 = 666;
                for each (_loc_19 in param1.castingSpell.spellRank.effects)
                {
                    
                    if (_loc_19.zoneShape != 0 && _loc_19.zoneSize < _loc_18 && _loc_19.zoneSize > 0)
                    {
                        _loc_18 = _loc_19.zoneSize;
                        _loc_17 = _loc_19.zoneShape;
                    }
                }
                if (_loc_18 == 666)
                {
                    _loc_18 = 0;
                }
                switch(_loc_17)
                {
                    case SpellShapeEnum.X:
                    {
                        _loc_20 = new Cross(0, _loc_18, DataMapProvider.getInstance());
                        break;
                    }
                    case SpellShapeEnum.L:
                    {
                        _loc_20 = new Line(_loc_18, DataMapProvider.getInstance());
                        break;
                    }
                    case SpellShapeEnum.T:
                    {
                        _loc_21 = new Cross(0, _loc_18, DataMapProvider.getInstance());
                        _loc_21.onlyPerpendicular = true;
                        _loc_20 = _loc_21;
                        break;
                    }
                    case SpellShapeEnum.D:
                    {
                        _loc_20 = new Cross(0, _loc_18, DataMapProvider.getInstance());
                        break;
                    }
                    case SpellShapeEnum.C:
                    {
                        _loc_20 = new Lozenge(0, _loc_18, DataMapProvider.getInstance());
                        break;
                    }
                    case SpellShapeEnum.O:
                    {
                        _loc_20 = new Cross((_loc_18 - 1), _loc_18, DataMapProvider.getInstance());
                        break;
                    }
                    case SpellShapeEnum.P:
                    {
                    }
                    default:
                    {
                        _loc_20 = new Cross(0, 0, DataMapProvider.getInstance());
                        break;
                    }
                }
                _loc_20.direction = param3.advancedOrientationTo(param1.castingSpell.targetedCell);
                _loc_16 = _loc_20.getCells(param1.castingSpell.targetedCell.cellId);
            }
            return new AddGfxInLineStep(param2, param3, param4, (-DisplayObject(param1.caster).height) * param5 / 10, param6, _loc_15, param9, param10, _loc_16, param13, param11);
        }// end function

        public static function CreateAddWorldEntityStep(param1:IEntity) : AddWorldEntityStep
        {
            return new AddWorldEntityStep(param1);
        }// end function

        public static function CreateDestroyEntityStep(param1:IEntity) : DestroyEntityStep
        {
            return new FightDestroyEntityStep(param1);
        }// end function

        public static function CreateDebugStep(param1:String) : DebugStep
        {
            return new DebugStep(param1);
        }// end function

    }
}
