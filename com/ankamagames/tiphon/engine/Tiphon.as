package com.ankamagames.tiphon.engine
{
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import com.ankamagames.tiphon.*;
    import com.ankamagames.tiphon.display.*;
    import com.ankamagames.tiphon.events.*;
    import com.ankamagames.tiphon.types.*;
    import flash.events.*;
    import flash.utils.*;

    final public class Tiphon extends EventDispatcher implements IFLAEventHandler
    {
        protected var coloredSprite:ColoredSprite;
        protected var advancedColoredSprite:AdvancedColoredSprite;
        protected var carriedSprite:CarriedSprite;
        protected var equipmentSprite:EquipmentSprite;
        protected var scriptedAnimation:ScriptedAnimation;
        private var _rasterizedAnimationNameList:Array;
        private var _toOptions:Object;
        private var _waitForInit:Boolean;
        private static const _log:Logger = Log.getLogger(getQualifiedClassName(Tiphon));
        private static var _self:Tiphon;
        public static const skullLibrary:LibrariesManager = TiphonLibraries.skullLibrary;
        public static const skinLibrary:LibrariesManager = TiphonLibraries.skinLibrary;

        public function Tiphon()
        {
            this._rasterizedAnimationNameList = new Array();
            if (_self != null)
            {
                throw new SingletonError("Tiphon is a singleton and should not be instanciated directly.");
            }
            return;
        }// end function

        public function addRasterizeAnimation(param1:String) : void
        {
            return;
        }// end function

        public function isRasterizeAnimation(param1:String) : Boolean
        {
            return this._rasterizedAnimationNameList[param1];
        }// end function

        public function get options()
        {
            return this._toOptions;
        }// end function

        public function init(param1:String, param2:String, param3:String = null) : void
        {
            if (param1.split("://").length == 1)
            {
                param1 = "file://" + param1;
            }
            if (param2.split("://").length == 1)
            {
                param2 = "file://" + param2;
            }
            TiphonConstants.SWF_SKULL_PATH = param1;
            TiphonConstants.SWF_SKIN_PATH = param2;
            if (param3)
            {
                this._waitForInit = true;
                BoneIndexManager.getInstance().addEventListener(Event.INIT, this.onBoneIndexManagerInit);
                BoneIndexManager.getInstance().init(param3);
            }
            TiphonFpsManager.init();
            TiphonEventsManager.addListener(this, TiphonEvent.PLAYANIM_EVENT);
            if (!this._waitForInit)
            {
                dispatchEvent(new Event(Event.INIT));
            }
            return;
        }// end function

        public function setDisplayOptions(param1) : void
        {
            this._toOptions = param1;
            return;
        }// end function

        public function handleFLAEvent(param1:String, param2:String, param3:String, param4:Object = null) : void
        {
            var _loc_5:* = param4 as TiphonSprite;
            if (param3 == TiphonEvent.EVENT_SHOT)
            {
                _loc_5.onAnimationEvent(TiphonEvent.EVENT_SHOT);
            }
            else if (param3 == TiphonEvent.EVENT_END)
            {
                _loc_5.onAnimationEvent(TiphonEvent.EVENT_END);
            }
            else if (param3 == TiphonEvent.PLAYER_STOP)
            {
                _loc_5.onAnimationEvent(TiphonEvent.PLAYER_STOP);
            }
            else if (param2 == TiphonEvent.PLAYANIM_EVENT)
            {
                _loc_5.onAnimationEvent(TiphonEvent.PLAYANIM_EVENT, param3);
            }
            return;
        }// end function

        public function removeEntitySound(param1:IEntity) : void
        {
            return;
        }// end function

        private function onBoneIndexManagerInit(event:Event) : void
        {
            dispatchEvent(new Event(Event.INIT));
            return;
        }// end function

        public static function getInstance() : Tiphon
        {
            if (_self == null)
            {
                _self = new Tiphon;
            }
            return _self;
        }// end function

    }
}
