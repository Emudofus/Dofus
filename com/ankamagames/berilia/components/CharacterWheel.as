package com.ankamagames.berilia.components
{
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.enums.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.event.*;
    import com.ankamagames.berilia.types.graphic.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.sequencer.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.display.*;
    import com.ankamagames.tiphon.display.*;
    import com.ankamagames.tiphon.sequence.*;
    import com.ankamagames.tiphon.types.*;
    import com.ankamagames.tiphon.types.look.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class CharacterWheel extends GraphicContainer implements FinalizableUIComponent
    {
        private var _nSelectedChara:int;
        private var _nNbCharacters:uint = 1;
        private var _aCharactersList:Object;
        private var _aEntitiesLook:Array;
        private var _ctrDepth:Array;
        private var _uiClass:UiRootContainer;
        private var _aMountainsCtr:Array;
        private var _aSprites:Array;
        private var _charaSelCtr:Object;
        private var _midZCtr:Object;
        private var _frontZCtr:Object;
        private var _sMountainUri:String;
        private var _nWidthEllipsis:int = 390;
        private var _nHeightEllipsis:int = 200;
        private var _nXCenterEllipsis:int = 540;
        private var _nYCenterEllipsis:int = 360;
        private var _nRotationStep:Number = 0;
        private var _nRotation:Number = 0;
        private var _nRotationPieceTrg:Number;
        private var _sens:int;
        private var _bMovingMountains:Boolean = false;
        private var _finalized:Boolean = false;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(CharacterWheel));
        public static var animationModifier:IAnimationModifier;
        private static const _subEntitiesBehaviors:Dictionary = new Dictionary();

        public function CharacterWheel()
        {
            this._aEntitiesLook = new Array();
            this._aMountainsCtr = new Array();
            this._aSprites = new Array();
            this._ctrDepth = new Array();
            return;
        }// end function

        public function get widthEllipsis() : int
        {
            return this._nWidthEllipsis;
        }// end function

        public function set widthEllipsis(param1:int) : void
        {
            this._nWidthEllipsis = param1;
            return;
        }// end function

        public function get heightEllipsis() : int
        {
            return this._nHeightEllipsis;
        }// end function

        public function set heightEllipsis(param1:int) : void
        {
            this._nHeightEllipsis = param1;
            return;
        }// end function

        public function get xEllipsis() : int
        {
            return this._nXCenterEllipsis;
        }// end function

        public function set xEllipsis(param1:int) : void
        {
            this._nXCenterEllipsis = param1;
            return;
        }// end function

        public function get yEllipsis() : int
        {
            return this._nYCenterEllipsis;
        }// end function

        public function set yEllipsis(param1:int) : void
        {
            this._nYCenterEllipsis = param1;
            return;
        }// end function

        public function get charaCtr() : Object
        {
            return this._charaSelCtr;
        }// end function

        public function set charaCtr(param1:Object) : void
        {
            this._charaSelCtr = param1;
            return;
        }// end function

        public function get frontCtr() : Object
        {
            return this._frontZCtr;
        }// end function

        public function set frontCtr(param1:Object) : void
        {
            this._frontZCtr = param1;
            return;
        }// end function

        public function get midCtr() : Object
        {
            return this._midZCtr;
        }// end function

        public function set midCtr(param1:Object) : void
        {
            this._midZCtr = param1;
            return;
        }// end function

        public function get mountainUri() : String
        {
            return this._sMountainUri;
        }// end function

        public function set mountainUri(param1:String) : void
        {
            this._sMountainUri = param1;
            return;
        }// end function

        public function get selectedChara() : int
        {
            return this._nSelectedChara;
        }// end function

        public function set selectedChara(param1:int) : void
        {
            this._nSelectedChara = param1;
            return;
        }// end function

        public function get isWheeling() : Boolean
        {
            return this._bMovingMountains;
        }// end function

        public function set entities(param1) : void
        {
            if (!this.isIterable(param1))
            {
                throw new ArgumentError("entities must be either Array or Vector.");
            }
            this._aEntitiesLook = SecureCenter.unsecure(param1);
            return;
        }// end function

        public function get entities()
        {
            return SecureCenter.secure(this._aEntitiesLook);
        }// end function

        public function set dataProvider(param1) : void
        {
            if (!this.isIterable(param1))
            {
                throw new ArgumentError("dataProvider must be either Array or Vector.");
            }
            this._aCharactersList = param1;
            this.finalize();
            return;
        }// end function

        public function get dataProvider()
        {
            return this._aCharactersList;
        }// end function

        public function get finalized() : Boolean
        {
            return this._finalized;
        }// end function

        public function set finalized(param1:Boolean) : void
        {
            this._finalized = param1;
            return;
        }// end function

        public function finalize() : void
        {
            this._uiClass = getUi();
            if (this._aCharactersList)
            {
                this._nNbCharacters = this._aCharactersList.length;
                this._nSelectedChara = 0;
                if (this._nNbCharacters > 0)
                {
                    this.charactersDisplay();
                }
            }
            this._finalized = true;
            if (getUi())
            {
                getUi().iAmFinalized(this);
            }
            return;
        }// end function

        override public function remove() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            if (!__removed)
            {
                for each (_loc_1 in this._aMountainsCtr)
                {
                    
                    _loc_1.remove();
                }
                _loc_2 = this._aSprites.length;
                _loc_3 = 0;
                while (_loc_3 < _loc_2)
                {
                    
                    _loc_5 = this._aSprites[_loc_3];
                    _loc_5.destroy();
                    _loc_3++;
                }
                if (this._charaSelCtr)
                {
                    _loc_6 = this._charaSelCtr.numChildren;
                    while (_loc_6 > 0)
                    {
                        
                        this._charaSelCtr.removeChildAt(0);
                        _loc_6 = _loc_6 - 1;
                    }
                }
                this._aCharactersList = null;
                this._aEntitiesLook = null;
                this._ctrDepth = null;
                this._uiClass = null;
                this._aMountainsCtr = null;
                this._aSprites = null;
                this._charaSelCtr = null;
                this._midZCtr = null;
                this._frontZCtr = null;
                for each (_loc_4 in _subEntitiesBehaviors)
                {
                    
                    if (_loc_4)
                    {
                        _loc_4.remove();
                    }
                }
            }
            super.remove();
            return;
        }// end function

        public function wheel(param1:int) : void
        {
            this.rotateMountains(param1);
            return;
        }// end function

        public function wheelChara(param1:int) : void
        {
            var _loc_2:* = IAnimated(this._aSprites[this._nSelectedChara]).getDirection() + param1;
            _loc_2 = _loc_2 == 8 ? (0) : (_loc_2);
            _loc_2 = _loc_2 < 0 ? (7) : (_loc_2);
            IAnimated(this._aSprites[this._nSelectedChara]).setDirection(_loc_2);
            return;
        }// end function

        public function setAnimation(param1:String, param2:int = 0) : void
        {
            var _loc_3:* = new SerialSequencer();
            var _loc_4:* = this._aSprites[this._nSelectedChara];
            if (param1 == "AnimStatique")
            {
                _loc_4.setAnimationAndDirection("AnimStatique", param2);
            }
            else
            {
                _loc_3.addStep(new SetDirectionStep(_loc_4, param2));
                _loc_3.addStep(new PlayAnimationStep(_loc_4, param1, false));
                _loc_3.addStep(new SetAnimationStep(_loc_4, "AnimStatique"));
                _loc_3.start();
            }
            return;
        }// end function

        public function equipCharacter(param1:Array, param2:int = 0) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_3:* = this._aSprites[this._nSelectedChara];
            var _loc_4:* = _loc_3.look.toString().split("|");
            if (param1.length)
            {
                param1.unshift(_loc_4[1].split(","));
                _loc_4[1] = param1.join(",");
            }
            else
            {
                _loc_6 = _loc_4[1].split(",");
                _loc_7 = 0;
                while (_loc_7 < param2)
                {
                    
                    _loc_6.pop();
                    _loc_7++;
                }
                _loc_4[1] = _loc_6.join(",");
            }
            var _loc_5:* = TiphonEntityLook.fromString(_loc_4.join("|"));
            _loc_3.look.updateFrom(_loc_5);
            return;
        }// end function

        public function getMountainCtr(param1:int) : Object
        {
            return this._aMountainsCtr[param1];
        }// end function

        private function charactersDisplay() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = NaN;
            var _loc_8:* = 0;
            var _loc_9:* = NaN;
            var _loc_10:* = NaN;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = undefined;
            var _loc_15:* = null;
            var _loc_16:* = null;
            var _loc_1:* = this._aSprites.length;
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                _loc_4 = this._aSprites.shift();
                _loc_4.destroy();
                _loc_2++;
            }
            for each (_loc_3 in this._aMountainsCtr)
            {
                
                _loc_3.remove();
            }
            if (this._aMountainsCtr.length > 0)
            {
                _loc_5 = this._aMountainsCtr.numChildren;
                _loc_6 = _loc_5 - 1;
                while (_loc_6 >= 0)
                {
                    
                    this._aMountainsCtr.removeChild(this._aMountainsCtr.getChildAt(_loc_6));
                    _loc_6 = _loc_6 - 1;
                }
                this._aMountainsCtr = new Array();
                this._ctrDepth = new Array();
            }
            if (this._nNbCharacters == 0)
            {
                _log.error("Error : The character list is empty.");
            }
            else
            {
                _loc_7 = 2 * Math.PI / this._nNbCharacters;
                this._nRotation = 0;
                this._nRotationPieceTrg = 0;
                _loc_8 = 0;
                while (_loc_8 < this._nNbCharacters)
                {
                    
                    if (this._aCharactersList[_loc_8])
                    {
                        _loc_9 = _loc_7 * _loc_8 % (2 * Math.PI);
                        _loc_10 = Math.abs(_loc_9 - Math.PI) / Math.PI;
                        _loc_11 = new GraphicContainer();
                        _loc_11.x = this._nWidthEllipsis * Math.cos(_loc_9 + Math.PI / 2) + this._nXCenterEllipsis;
                        _loc_11.y = this._nHeightEllipsis * Math.sin(_loc_9 + Math.PI / 2) + this._nYCenterEllipsis;
                        _loc_12 = new CBI(this._aCharactersList[_loc_8].id, this._aCharactersList[_loc_8].gfxId, this._aCharactersList[_loc_8].breed, new Array());
                        this._aEntitiesLook[_loc_8].look = SecureCenter.unsecure(this._aEntitiesLook[_loc_8].look);
                        _loc_13 = new TiphonEntity(this._aEntitiesLook[_loc_8].id, this._aEntitiesLook[_loc_8].look);
                        _loc_13.addAnimationModifier(CharacterWheel.animationModifier);
                        for (_loc_14 in _subEntitiesBehaviors)
                        {
                            
                            if (_subEntitiesBehaviors[_loc_14])
                            {
                                _loc_13.setSubEntityBehaviour(_loc_14, _subEntitiesBehaviors[_loc_14]);
                            }
                        }
                        if (_loc_13.look.getBone() == 1)
                        {
                            _loc_13.setAnimationAndDirection("AnimStatique", 2);
                        }
                        else
                        {
                            _loc_13.setAnimationAndDirection("AnimStatique", 3);
                        }
                        _loc_13.x = -5;
                        _loc_13.y = -64;
                        _loc_13.scaleX = 2.2;
                        _loc_13.scaleY = 2.2;
                        _loc_13.cacheAsBitmap = true;
                        this._aSprites[_loc_8] = _loc_13;
                        var _loc_17:* = Math.max(0.3, _loc_10);
                        _loc_11.scaleY = Math.max(0.3, _loc_10);
                        _loc_11.scaleX = _loc_17;
                        _loc_11.alpha = Math.max(0.3, _loc_10);
                        _loc_11.useHandCursor = true;
                        _loc_11.buttonMode = true;
                        if (this._nNbCharacters == 2)
                        {
                            if (_loc_8 == 1)
                            {
                                _loc_11.x = this._nWidthEllipsis * Math.cos(_loc_9 + Math.PI / 6 + Math.PI / 2) + this._nXCenterEllipsis;
                                _loc_11.y = this._nHeightEllipsis * Math.sin(_loc_9 + Math.PI / 6 + Math.PI / 2) + this._nYCenterEllipsis;
                            }
                        }
                        if (this._nNbCharacters == 4)
                        {
                            if (_loc_8 == 2)
                            {
                                _loc_11.x = this._nWidthEllipsis * Math.cos(_loc_9 + Math.PI / 6 + Math.PI / 2) + this._nXCenterEllipsis;
                                _loc_11.y = this._nHeightEllipsis * Math.sin(_loc_9 + Math.PI / 6 + Math.PI / 2) + this._nYCenterEllipsis;
                            }
                        }
                        _loc_15 = new Texture();
                        _loc_15.scale = 1.2;
                        _loc_15.y = -62;
                        _loc_15.uri = new Uri(this._sMountainUri + "assets.swf|base_" + _loc_12.breed);
                        _loc_15.finalize();
                        _loc_16 = new InstanceEvent(_loc_11, this._uiClass.uiClass);
                        _loc_16.push(EventEnums.EVENT_ONRELEASE_MSG);
                        _loc_16.push(EventEnums.EVENT_ONDOUBLECLICK_MSG);
                        UIEventManager.getInstance().registerInstance(_loc_16);
                        if (_loc_8 == 0)
                        {
                            this._charaSelCtr.addChild(this._midZCtr);
                        }
                        _loc_11.addChild(_loc_15);
                        _loc_11.addChild(_loc_13);
                        if (this._aEntitiesLook[_loc_8].disabled)
                        {
                            _loc_11.transform.colorTransform = new ColorTransform(0.6, 0.6, 0.6, 1);
                        }
                        this._charaSelCtr.addChild(_loc_11);
                        this._ctrDepth.push(this._charaSelCtr.getChildIndex(_loc_11));
                        this._aMountainsCtr[_loc_8] = _loc_11;
                    }
                    _loc_8++;
                }
                this._charaSelCtr.addChild(this._frontZCtr);
            }
            return;
        }// end function

        private function endRotationMountains() : void
        {
            EnterFrameDispatcher.removeEventListener(this.onRotateMountains);
            this._bMovingMountains = false;
            return;
        }// end function

        private function rotateMountains(param1:int) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            this._nSelectedChara = this._nSelectedChara - param1;
            if (this._nSelectedChara >= this._aCharactersList.length)
            {
                this._nSelectedChara = this._nSelectedChara - this._aCharactersList.length;
            }
            if (this._nSelectedChara < 0)
            {
                this._nSelectedChara = this._aCharactersList.length + this._nSelectedChara;
            }
            var _loc_2:* = 2 * Math.PI / this._nNbCharacters;
            this._sens = param1;
            this._nRotationStep = _loc_2;
            if (isNaN(this._nRotationPieceTrg))
            {
                this._nRotationPieceTrg = this._nRotation + this._nRotationStep * this._sens;
            }
            else
            {
                this._nRotationPieceTrg = this._nRotationPieceTrg + this._nRotationStep * this._sens;
            }
            if (param1 == 1)
            {
                for each (_loc_3 in Berilia.getInstance().UISoundListeners)
                {
                    
                    _loc_3.playUISound("16079");
                }
            }
            else
            {
                for each (_loc_4 in Berilia.getInstance().UISoundListeners)
                {
                    
                    _loc_4.playUISound("16080");
                }
            }
            EnterFrameDispatcher.addEventListener(this.onRotateMountains, "mountainsRotation", StageShareManager.stage.frameRate);
            return;
        }// end function

        private function isIterable(param1) : Boolean
        {
            if (param1 is Array)
            {
                return true;
            }
            if (param1["length"] != null && param1["length"] != 0 && !isNaN(param1["length"]) && param1[0] != null && !(param1 is String))
            {
                return true;
            }
            return false;
        }// end function

        override public function process(param1:Message) : Boolean
        {
            return false;
        }// end function

        public function eventOnRelease(param1:DisplayObject) : void
        {
            return;
        }// end function

        public function eventOnDoubleClick(param1:DisplayObject) : void
        {
            if (!this._bMovingMountains)
            {
            }
            return;
        }// end function

        public function eventOnRollOver(param1:DisplayObject) : void
        {
            return;
        }// end function

        public function eventOnRollOut(param1:DisplayObject) : void
        {
            return;
        }// end function

        public function eventOnShortcut(param1:String) : Boolean
        {
            return false;
        }// end function

        private function onRotateMountains(event:Event) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = NaN;
            var _loc_6:* = NaN;
            this._bMovingMountains = true;
            if (this._nRotationStep == 0)
            {
                this.endRotationMountains();
            }
            if (Math.abs(this._nRotationPieceTrg - this._nRotation) < 0.01)
            {
                this._nRotation = this._nRotationPieceTrg;
            }
            else
            {
                this._nRotation = this._nRotation + (this._nRotationPieceTrg - this._nRotation) / 3;
            }
            var _loc_2:* = new Array();
            var _loc_3:* = 0;
            for each (_loc_4 in this._aMountainsCtr)
            {
                
                _loc_5 = (this._nRotation + this._nRotationStep * _loc_3) % (2 * Math.PI);
                _loc_6 = Math.abs(Math.PI - (_loc_5 < 0 ? (_loc_5 + 2 * Math.PI) : (_loc_5)) % (2 * Math.PI)) / Math.PI;
                _loc_2.push({ctr:_loc_4, z:_loc_6});
                _loc_4.x = this._nWidthEllipsis * Math.cos(_loc_5 + Math.PI / 2) + this._nXCenterEllipsis;
                _loc_4.y = this._nHeightEllipsis * Math.sin(_loc_5 + Math.PI / 2) + this._nYCenterEllipsis;
                if (this._nNbCharacters == 2)
                {
                    if (_loc_4.y < 300)
                    {
                        _loc_4.x = this._nWidthEllipsis * Math.cos(_loc_5 + Math.PI / 6 + Math.PI / 2) + this._nXCenterEllipsis;
                        _loc_4.y = this._nHeightEllipsis * Math.sin(_loc_5 + Math.PI / 6 + Math.PI / 2) + this._nYCenterEllipsis;
                    }
                }
                if (this._nNbCharacters == 4)
                {
                    if (_loc_4.y < 300)
                    {
                        _loc_4.x = this._nWidthEllipsis * Math.cos(_loc_5 + Math.PI / 6 + Math.PI / 2) + this._nXCenterEllipsis;
                        _loc_4.y = this._nHeightEllipsis * Math.sin(_loc_5 + Math.PI / 6 + Math.PI / 2) + this._nYCenterEllipsis;
                    }
                }
                var _loc_9:* = Math.max(0.3, _loc_6);
                _loc_4.scaleY = Math.max(0.3, _loc_6);
                _loc_4.scaleX = _loc_9;
                _loc_4.alpha = Math.max(0.3, _loc_6);
                _loc_3++;
            }
            _loc_2.sortOn("z", Array.NUMERIC);
            _loc_3 = 0;
            while (_loc_3 < _loc_2.length)
            {
                
                _loc_2[_loc_3].ctr.parent.addChildAt(_loc_2[_loc_3].ctr, this._ctrDepth[_loc_3]);
                _loc_3++;
            }
            this._charaSelCtr.setChildIndex(this._frontZCtr, (this._charaSelCtr.numChildren - 1));
            if (this._nRotationPieceTrg == this._nRotation)
            {
                this.endRotationMountains();
            }
            return;
        }// end function

        public static function setSubEntityDefaultBehavior(param1:uint, param2:ISubEntityBehavior) : void
        {
            _subEntitiesBehaviors[param1] = param2;
            return;
        }// end function

    }
}

import com.ankamagames.berilia.*;

import com.ankamagames.berilia.enums.*;

import com.ankamagames.berilia.managers.*;

import com.ankamagames.berilia.types.event.*;

import com.ankamagames.berilia.types.graphic.*;

import com.ankamagames.jerakine.entities.interfaces.*;

import com.ankamagames.jerakine.interfaces.*;

import com.ankamagames.jerakine.logger.*;

import com.ankamagames.jerakine.messages.*;

import com.ankamagames.jerakine.sequencer.*;

import com.ankamagames.jerakine.types.*;

import com.ankamagames.jerakine.utils.display.*;

import com.ankamagames.tiphon.display.*;

import com.ankamagames.tiphon.sequence.*;

import com.ankamagames.tiphon.types.*;

import com.ankamagames.tiphon.types.look.*;

import flash.display.*;

import flash.events.*;

import flash.geom.*;

import flash.utils.*;

class CBI extends Object
{
    public var id:int;
    public var gfxId:int;
    public var breed:int;
    public var colors:Array;

    function CBI(param1:uint, param2:int, param3:int, param4:Array)
    {
        this.colors = new Array();
        this.id = param1;
        this.gfxId = param2;
        this.breed = param3;
        this.colors = param4;
        return;
    }// end function

}


import com.ankamagames.berilia.*;

import com.ankamagames.berilia.enums.*;

import com.ankamagames.berilia.managers.*;

import com.ankamagames.berilia.types.event.*;

import com.ankamagames.berilia.types.graphic.*;

import com.ankamagames.jerakine.entities.interfaces.*;

import com.ankamagames.jerakine.interfaces.*;

import com.ankamagames.jerakine.logger.*;

import com.ankamagames.jerakine.messages.*;

import com.ankamagames.jerakine.sequencer.*;

import com.ankamagames.jerakine.types.*;

import com.ankamagames.jerakine.utils.display.*;

import com.ankamagames.tiphon.display.*;

import com.ankamagames.tiphon.sequence.*;

import com.ankamagames.tiphon.types.*;

import com.ankamagames.tiphon.types.look.*;

import flash.display.*;

import flash.events.*;

import flash.geom.*;

import flash.utils.*;

class TiphonEntity extends TiphonSprite implements IEntity
{
    private var _id:uint;

    function TiphonEntity(param1:uint, param2:TiphonEntityLook)
    {
        super(param2);
        this._id = param1;
        mouseEnabled = false;
        mouseChildren = false;
        return;
    }// end function

    public function get id() : int
    {
        return this._id;
    }// end function

    public function set id(param1:int) : void
    {
        this._id = param1;
        return;
    }// end function

    public function get position() : MapPoint
    {
        return null;
    }// end function

    public function set position(param1:MapPoint) : void
    {
        return;
    }// end function

}

