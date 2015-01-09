package com.ankamagames.tiphon.types
{
    import com.ankamagames.jerakine.entities.interfaces.ISubEntityContainer;
    import flash.display.Sprite;
    import flash.geom.ColorTransform;
    import com.ankamagames.tiphon.engine.TiphonEventsManager;

    public interface IAnimationSpriteHandler extends ISubEntityContainer 
    {

        function registerColoredSprite(_arg_1:ColoredSprite, _arg_2:uint):void;
        function registerInfoSprite(_arg_1:DisplayInfoSprite, _arg_2:String):void;
        function getSkinSprite(_arg_1:EquipmentSprite):Sprite;
        function onAnimationEvent(_arg_1:String, _arg_2:String=""):void;
        function getColorTransform(_arg_1:uint):ColorTransform;
        function get tiphonEventManager():TiphonEventsManager;
        function get maxFrame():uint;
        function getAnimation():String;
        function getDirection():uint;

    }
}//package com.ankamagames.tiphon.types

