package com.ankamagames.dofus.scripts.api
{
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.utils.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.scripts.*;
    import com.ankamagames.dofus.types.entities.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.tiphon.display.*;
    import com.ankamagames.tiphon.events.*;
    import com.ankamagames.tiphon.types.look.*;
    import flash.display.*;
    import flash.utils.*;

    public class FxApi extends Object
    {
        static const _log:Logger = Log.getLogger(getQualifiedClassName(FxApi));
        public static const ANIMEVENT_SHOT:String = "SHOT";

        public function FxApi()
        {
            return;
        }// end function

        public static function GetCurrentTargetedCell(param1:FxRunner) : MapPoint
        {
            return param1.target;
        }// end function

        public static function GetCurrentCaster(param1:SpellFxRunner) : IEntity
        {
            return param1.caster;
        }// end function

        public static function IsCasterPlayer(param1:SpellFxRunner) : Boolean
        {
            return param1.caster.id == PlayedCharacterManager.getInstance().id;
        }// end function

        public static function GetOrientationTo(param1:MapPoint, param2:MapPoint, param3:Boolean = true) : uint
        {
            return param1.advancedOrientationTo(param2, param3);
        }// end function

        public static function GetAngleTo(param1:MapPoint, param2:MapPoint) : Number
        {
            var _loc_3:* = CellUtil.getPixelXFromMapPoint(param2) - CellUtil.getPixelXFromMapPoint(param1);
            var _loc_4:* = CellUtil.getPixelYFromMapPoint(param1) - CellUtil.getPixelYFromMapPoint(param2);
            return Math.acos(_loc_3 / Math.sqrt(Math.pow(_loc_3, 2) + Math.pow(_loc_4, 2))) * 180 / Math.PI * (CellUtil.getPixelYFromMapPoint(param2) > CellUtil.getPixelYFromMapPoint(param1) ? (1) : (-1));
        }// end function

        public static function SetGfxRotation(param1:DisplayObject, param2:Number) : void
        {
            param1.rotation = param2;
            return;
        }// end function

        public static function GetEntityCell(param1:IEntity) : MapPoint
        {
            return param1.position;
        }// end function

        public static function IsPositionsEquals(param1:MapPoint, param2:MapPoint) : Boolean
        {
            if (!param1 || !param2)
            {
                return false;
            }
            return param1.cellId == param2.cellId;
        }// end function

        public static function GetEntityOnCell(param1:MapPoint) : IEntity
        {
            return Atouin.getInstance().getEntityOnCell(param1.cellId);
        }// end function

        public static function GetEntityId(param1:IEntity) : int
        {
            return param1.id;
        }// end function

        public static function GetEntityPosition(param1:IEntity) : MapPoint
        {
            return param1.position;
        }// end function

        public static function CreateGfxEntity(param1:uint, param2:MapPoint, param3:Number = 0, param4:Number = 0, param5:Boolean = false, param6:Boolean = true) : IEntity
        {
            var _loc_7:int = -10000;
            while (DofusEntities.getEntity(_loc_7))
            {
                
                _loc_7 = -10000 + Math.random() * 10000;
            }
            var _loc_8:* = new Projectile(_loc_7, TiphonEntityLook.fromString("{" + param1 + "}"), false);
            new Projectile(_loc_7, TiphonEntityLook.fromString("{" + param1 + "}"), false).position = param2;
            _loc_8.rotation = Math.random() * (param4 - param3) + param3;
            if (param5 && Math.random() < 0.5)
            {
                _loc_8.scaleX = -1;
            }
            return _loc_8;
        }// end function

        public static function CreateTailEntity() : TailEntity
        {
            return new TailEntity();
        }// end function

        public static function SetEntityAnimation(param1:TiphonSprite, param2:String) : void
        {
            param1.setAnimation(param2);
            return;
        }// end function

        public static function SetSubEntity(param1:TiphonSprite, param2:DisplayObject, param3:uint, param4:uint) : void
        {
            if (param1)
            {
                param1.addSubEntity(param2, param3, param4);
            }
            return;
        }// end function

        public static function CreateParticlesEntity(param1:uint) : ParticuleEmitterEntity
        {
            var _loc_2:int = -10000;
            while (DofusEntities.getEntity(_loc_2))
            {
                
                _loc_2 = -10000 + Math.random() * 10000;
            }
            return new ParticuleEmitterEntity(_loc_2, param1);
        }// end function

    }
}
