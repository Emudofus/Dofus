package com.ankamagames.tiphon.types
{
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.tiphon.engine.*;
    import flash.display.*;
    import flash.geom.*;

    public interface IAnimationSpriteHandler extends ISubEntityContainer
    {

        public function IAnimationSpriteHandler();

        function registerColoredSprite(param1:ColoredSprite, param2:uint) : void;

        function registerInfoSprite(param1:DisplayInfoSprite, param2:String) : void;

        function getSkinSprite(param1:EquipmentSprite) : Sprite;

        function onAnimationEvent(param1:String, param2:String = "") : void;

        function getColorTransform(param1:uint) : ColorTransform;

        function get tiphonEventManager() : TiphonEventsManager;

        function get maxFrame() : uint;

        function getAnimation() : String;

        function getDirection() : uint;

    }
}
