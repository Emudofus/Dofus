package com.ankamagames.tiphon.types.look
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.tiphon.types.look.*;
    import flash.utils.*;

    public class TiphonEntityLook extends Object implements EntityLookObserver
    {
        private var _observers:Dictionary;
        private var _locked:Boolean;
        private var _boneChangedWhileLocked:Boolean;
        private var _skinsChangedWhileLocked:Boolean;
        private var _colorsChangedWhileLocked:Boolean;
        private var _scalesChangedWhileLocked:Boolean;
        private var _subEntitiesChangedWhileLocked:Boolean;
        private var _bone:uint;
        private var _skins:Vector.<uint>;
        private var _colors:Array;
        private var _scaleX:Number = 1;
        private var _scaleY:Number = 1;
        private var _subEntities:Array;
        private var _defaultSkin:int = -1;
        public static var MEMORY_LOG:Dictionary = new Dictionary(true);
        static const _log:Logger = Log.getLogger(getQualifiedClassName(TiphonEntityLook));

        public function TiphonEntityLook()
        {
            MEMORY_LOG[this] = 1;
            return;
        }// end function

        public function get skins() : Vector.<uint>
        {
            return this._skins;
        }// end function

        public function set defaultSkin(param1:int) : void
        {
            if (this._defaultSkin != -1 && this._skins)
            {
                this._skins.shift();
            }
            if (!this._skins)
            {
                this._skins = new Vector.<uint>(0, false);
            }
            this._defaultSkin = param1;
            if (!this._skins.length || this._skins[0] != this._defaultSkin)
            {
                this._skins.unshift(param1);
            }
            return;
        }// end function

        public function get firstSkin() : uint
        {
            if (!this._skins || !this._skins.length)
            {
                return 0;
            }
            if (this._defaultSkin != -1)
            {
                return this._skins[1];
            }
            return this._skins[0];
        }// end function

        public function get defaultSkin() : int
        {
            return this._defaultSkin;
        }// end function

        public function getBone() : uint
        {
            return this._bone;
        }// end function

        public function setBone(param1:uint) : void
        {
            var _loc_2:* = null;
            if (this._bone == param1)
            {
                return;
            }
            this._bone = param1;
            if (!this._locked)
            {
                for (_loc_2 in this._observers)
                {
                    
                    _loc_2.boneChanged(this);
                }
            }
            else
            {
                this._boneChangedWhileLocked = true;
            }
            return;
        }// end function

        public function getSkins(param1:Boolean = false, param2:Boolean = true) : Vector.<uint>
        {
            if (!this._skins)
            {
                return null;
            }
            if (param1)
            {
                return this._skins;
            }
            var _loc_3:* = this._skins.length;
            var _loc_4:* = 0;
            if (!param2 && this._defaultSkin != -1)
            {
                _loc_4 = 1;
            }
            var _loc_5:* = new Vector.<uint>(_loc_3, true);
            var _loc_6:* = _loc_4;
            while (_loc_6 < _loc_3)
            {
                
                _loc_5[_loc_6 - _loc_4] = this._skins[_loc_6];
                _loc_6 = _loc_6 + 1;
            }
            return _loc_5;
        }// end function

        public function resetSkins() : void
        {
            var _loc_1:* = null;
            if (!this._skins || this._skins.length == 0)
            {
                return;
            }
            this._skins = null;
            if (!this._locked)
            {
                for (_loc_1 in this._observers)
                {
                    
                    _loc_1.skinsChanged(this);
                }
            }
            else
            {
                this._skinsChangedWhileLocked = true;
            }
            return;
        }// end function

        public function addSkin(param1:uint, param2:Boolean = false) : void
        {
            var _loc_3:* = null;
            if (!this._skins)
            {
                this._skins = new Vector.<uint>(0, false);
            }
            if (!param2)
            {
                this._skins.push(param1);
            }
            else
            {
                this._skins.unshift(param1);
            }
            if (!this._locked)
            {
                for (_loc_3 in this._observers)
                {
                    
                    _loc_3.skinsChanged(this);
                }
            }
            else
            {
                this._skinsChangedWhileLocked = true;
            }
            return;
        }// end function

        public function getColors(param1:Boolean = false) : Array
        {
            var _loc_3:* = null;
            if (!this._colors)
            {
                return null;
            }
            if (param1)
            {
                return this._colors;
            }
            var _loc_2:* = new Array();
            for (_loc_3 in this._colors)
            {
                
                _loc_2[uint(_loc_3)] = this._colors[_loc_3];
            }
            return _loc_2;
        }// end function

        public function getColor(param1:uint) : DefaultableColor
        {
            var _loc_2:* = null;
            if (!this._colors || !this._colors[param1])
            {
                _loc_2 = new DefaultableColor();
                _loc_2.isDefault = true;
                return _loc_2;
            }
            return new DefaultableColor(this._colors[param1]);
        }// end function

        public function hasColor(param1:uint) : Boolean
        {
            return this._colors && this._colors[param1];
        }// end function

        public function resetColor(param1:uint) : void
        {
            var _loc_2:* = null;
            if (!this._colors || !this._colors[param1])
            {
                return;
            }
            delete this._colors[param1];
            if (!this._locked)
            {
                for (_loc_2 in this._observers)
                {
                    
                    _loc_2.colorsChanged(this);
                }
            }
            else
            {
                this._colorsChangedWhileLocked = true;
            }
            return;
        }// end function

        public function resetColors() : void
        {
            var _loc_1:* = null;
            if (!this._colors)
            {
                return;
            }
            this._colors = null;
            if (!this._locked)
            {
                for (_loc_1 in this._observers)
                {
                    
                    _loc_1.colorsChanged(this);
                }
            }
            else
            {
                this._colorsChangedWhileLocked = true;
            }
            return;
        }// end function

        public function setColor(param1:uint, param2:uint) : void
        {
            var _loc_3:* = null;
            if (!this._colors)
            {
                this._colors = new Array();
            }
            if (this._colors[param1] && this._colors[param1] == param2)
            {
                return;
            }
            if (param2 == 0)
            {
                this._colors[param1] = 1;
            }
            else
            {
                this._colors[param1] = param2;
            }
            if (!this._locked)
            {
                for (_loc_3 in this._observers)
                {
                    
                    _loc_3.colorsChanged(this);
                }
            }
            else
            {
                this._colorsChangedWhileLocked = true;
            }
            return;
        }// end function

        public function getScaleX() : Number
        {
            return this._scaleX;
        }// end function

        public function setScaleX(param1:Number) : void
        {
            var _loc_2:* = null;
            if (this._scaleX == param1)
            {
                return;
            }
            this._scaleX = param1;
            if (!this._locked)
            {
                for (_loc_2 in this._observers)
                {
                    
                    _loc_2.scalesChanged(this);
                }
            }
            else
            {
                this._scalesChangedWhileLocked = true;
            }
            return;
        }// end function

        public function getScaleY() : Number
        {
            return this._scaleY;
        }// end function

        public function setScaleY(param1:Number) : void
        {
            var _loc_2:* = null;
            if (this._scaleY == param1)
            {
                return;
            }
            this._scaleY = param1;
            if (!this._locked)
            {
                for (_loc_2 in this._observers)
                {
                    
                    _loc_2.scalesChanged(this);
                }
            }
            else
            {
                this._scalesChangedWhileLocked = true;
            }
            return;
        }// end function

        public function setScales(param1:Number, param2:Number) : void
        {
            var _loc_3:* = null;
            if (this._scaleX == param1 && this._scaleY == param2)
            {
                return;
            }
            this._scaleX = param1;
            this._scaleY = param2;
            if (!this._locked)
            {
                for (_loc_3 in this._observers)
                {
                    
                    _loc_3.scalesChanged(this);
                }
            }
            else
            {
                this._scalesChangedWhileLocked = true;
            }
            return;
        }// end function

        public function getSubEntities(param1:Boolean = false) : Array
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            if (!this._subEntities)
            {
                return null;
            }
            if (param1)
            {
                return this._subEntities;
            }
            var _loc_2:* = new Array();
            for (_loc_3 in this._subEntities)
            {
                
                _loc_4 = uint(_loc_3);
                if (!_loc_2[_loc_4])
                {
                    _loc_2[_loc_4] = new Array();
                }
                for (_loc_5 in this._subEntities[_loc_3])
                {
                    
                    _loc_6 = uint(_loc_5);
                    _loc_2[_loc_4][_loc_6] = this._subEntities[_loc_3][_loc_5];
                }
            }
            return _loc_2;
        }// end function

        public function getSubEntitiesFromCategory(param1:uint) : Array
        {
            var _loc_3:* = null;
            var _loc_4:* = 0;
            if (!this._subEntities)
            {
                return null;
            }
            var _loc_2:* = new Array();
            for (_loc_3 in this._subEntities[param1])
            {
                
                _loc_4 = uint(_loc_3);
                _loc_2[_loc_4] = this._subEntities[param1][_loc_3];
            }
            return _loc_2;
        }// end function

        public function getSubEntity(param1:uint, param2:uint) : TiphonEntityLook
        {
            if (!this._subEntities)
            {
                return null;
            }
            if (!this._subEntities[param1])
            {
                return null;
            }
            return this._subEntities[param1][param2];
        }// end function

        public function resetSubEntities() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (!this._subEntities)
            {
                return;
            }
            for (_loc_1 in this._subEntities)
            {
                
                for (_loc_2 in this._subEntities[_loc_1])
                {
                    
                    _loc_3 = this._subEntities[_loc_1][_loc_2];
                    _loc_3.removeObserver(this);
                }
            }
            this._subEntities = null;
            if (!this._locked)
            {
                for (_loc_4 in this._observers)
                {
                    
                    _loc_4.subEntitiesChanged(this);
                }
            }
            else
            {
                this._subEntitiesChangedWhileLocked = true;
            }
            return;
        }// end function

        public function addSubEntity(param1:uint, param2:uint, param3:TiphonEntityLook) : void
        {
            var _loc_4:* = null;
            if (!this._subEntities)
            {
                this._subEntities = new Array();
            }
            if (!this._subEntities[param1])
            {
                this._subEntities[param1] = new Array();
            }
            param3.addObserver(this);
            this._subEntities[param1][param2] = param3;
            if (!this._locked)
            {
                for (_loc_4 in this._observers)
                {
                    
                    _loc_4.subEntitiesChanged(this);
                }
            }
            else
            {
                this._subEntitiesChangedWhileLocked = true;
            }
            return;
        }// end function

        public function removeSubEntity(param1:uint, param2:uint = 0) : void
        {
            var _loc_3:* = null;
            if (!this._subEntities || !this._subEntities[param1] || !this._subEntities[param1][param2])
            {
                return;
            }
            delete this._subEntities[param1][param2];
            if (this._subEntities[param1].length == 1)
            {
                delete this._subEntities[param1];
            }
            if (!this._locked)
            {
                for (_loc_3 in this._observers)
                {
                    
                    _loc_3.subEntitiesChanged(this);
                }
            }
            else
            {
                this._subEntitiesChangedWhileLocked = true;
            }
            return;
        }// end function

        public function lock() : void
        {
            if (this._locked)
            {
                return;
            }
            this._locked = true;
            this._boneChangedWhileLocked = false;
            this._skinsChangedWhileLocked = false;
            this._colorsChangedWhileLocked = false;
            this._scalesChangedWhileLocked = false;
            this._subEntitiesChangedWhileLocked = false;
            return;
        }// end function

        public function unlock(param1:Boolean = false) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            if (!this._locked)
            {
                return;
            }
            this._locked = false;
            if (!param1)
            {
                if (this._boneChangedWhileLocked)
                {
                    for (_loc_2 in this._observers)
                    {
                        
                        _loc_2.boneChanged(this);
                    }
                    this._boneChangedWhileLocked = false;
                }
                if (this._skinsChangedWhileLocked)
                {
                    for (_loc_3 in this._observers)
                    {
                        
                        _loc_3.skinsChanged(this);
                    }
                    this._skinsChangedWhileLocked = false;
                }
                if (this._colorsChangedWhileLocked)
                {
                    for (_loc_4 in this._observers)
                    {
                        
                        _loc_4.colorsChanged(this);
                    }
                    this._colorsChangedWhileLocked = false;
                }
                if (this._scalesChangedWhileLocked)
                {
                    for (_loc_5 in this._observers)
                    {
                        
                        _loc_5.scalesChanged(this);
                    }
                    this._scalesChangedWhileLocked = false;
                }
                if (this._subEntitiesChangedWhileLocked)
                {
                    for (_loc_6 in this._observers)
                    {
                        
                        _loc_6.subEntitiesChanged(this);
                    }
                    this._subEntitiesChangedWhileLocked = false;
                }
            }
            return;
        }// end function

        public function addObserver(param1:EntityLookObserver) : void
        {
            if (!this._observers)
            {
                this._observers = new Dictionary(true);
            }
            this._observers[param1] = 1;
            return;
        }// end function

        public function removeObserver(param1:EntityLookObserver) : void
        {
            if (!this._observers)
            {
                return;
            }
            delete this._observers[param1];
            return;
        }// end function

        public function toString() : String
        {
            return EntityLookParser.toString(this);
        }// end function

        public function equals(param1:TiphonEntityLook) : Boolean
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            if (this._bone != param1._bone)
            {
                return false;
            }
            if (this._scaleX != param1._scaleX)
            {
                return false;
            }
            if (this._scaleY != param1._scaleY)
            {
                return false;
            }
            if (this._skins == null && param1._skins != null || this._skins != null && param1._skins == null)
            {
                return false;
            }
            if (this._skins && param1._skins)
            {
                if (this._skins.length != param1._skins.length)
                {
                    return false;
                }
                for each (_loc_2 in this._skins)
                {
                    
                    if (param1._skins.indexOf(_loc_2) == -1)
                    {
                        return false;
                    }
                }
            }
            if (this._colors == null && param1._colors != null || this._colors != null && param1._colors == null)
            {
                return false;
            }
            if (this._colors && param1._colors)
            {
                for (_loc_3 in this._colors)
                {
                    
                    if (param1._colors[_loc_3] != this._colors[_loc_3])
                    {
                        return false;
                    }
                }
                for (_loc_4 in param1._colors)
                {
                    
                    if (this._colors[_loc_4] != param1._colors[_loc_4])
                    {
                        return false;
                    }
                }
            }
            if (this._subEntities == null && param1._subEntities != null || this._subEntities != null && param1._subEntities == null)
            {
                return false;
            }
            if (this._subEntities && param1._subEntities)
            {
                for (_loc_5 in this._subEntities)
                {
                    
                    if (!param1._subEntities || param1._subEntities[_loc_5] == null)
                    {
                        return false;
                    }
                    for (_loc_7 in this._subEntities[_loc_5])
                    {
                        
                        _loc_8 = param1._subEntities[_loc_5][_loc_7];
                        if (_loc_8 == null)
                        {
                            return false;
                        }
                        if (!_loc_8.equals(this._subEntities[_loc_5][_loc_7]))
                        {
                            return false;
                        }
                    }
                }
                for (_loc_6 in param1._subEntities)
                {
                    
                    if (!this._subEntities || this._subEntities[_loc_6] == null)
                    {
                        return false;
                    }
                    for (_loc_9 in param1._subEntities[_loc_6])
                    {
                        
                        _loc_10 = this._subEntities[_loc_6][_loc_9];
                        if (_loc_10 == null)
                        {
                            return false;
                        }
                        if (!_loc_10.equals(param1._subEntities[_loc_6][_loc_9]))
                        {
                            return false;
                        }
                    }
                }
            }
            return true;
        }// end function

        public function updateFrom(param1:TiphonEntityLook) : void
        {
            if (this.equals(param1))
            {
                return;
            }
            this.lock();
            this._boneChangedWhileLocked = true;
            this.setBone(param1.getBone());
            this.resetColors();
            this._colorsChangedWhileLocked = true;
            this._colors = param1.getColors();
            this.resetSkins();
            this._skinsChangedWhileLocked = true;
            this._skins = param1.getSkins();
            this._defaultSkin = param1.defaultSkin;
            this.resetSubEntities();
            this._subEntitiesChangedWhileLocked = true;
            this._subEntities = param1.getSubEntities();
            this.setScales(param1.getScaleX(), param1.getScaleY());
            this._scalesChangedWhileLocked = true;
            this.unlock(false);
            return;
        }// end function

        public function boneChanged(param1:TiphonEntityLook) : void
        {
            var _loc_2:* = null;
            if (!this._locked)
            {
                for (_loc_2 in this._observers)
                {
                    
                    _loc_2.subEntitiesChanged(this);
                }
            }
            else
            {
                this._subEntitiesChangedWhileLocked = true;
            }
            return;
        }// end function

        public function skinsChanged(param1:TiphonEntityLook) : void
        {
            var _loc_2:* = null;
            if (!this._locked)
            {
                for (_loc_2 in this._observers)
                {
                    
                    _loc_2.subEntitiesChanged(this);
                }
            }
            else
            {
                this._subEntitiesChangedWhileLocked = true;
            }
            return;
        }// end function

        public function colorsChanged(param1:TiphonEntityLook) : void
        {
            var _loc_2:* = null;
            if (!this._locked)
            {
                for (_loc_2 in this._observers)
                {
                    
                    _loc_2.subEntitiesChanged(this);
                }
            }
            else
            {
                this._subEntitiesChangedWhileLocked = true;
            }
            return;
        }// end function

        public function scalesChanged(param1:TiphonEntityLook) : void
        {
            var _loc_2:* = null;
            if (!this._locked)
            {
                for (_loc_2 in this._observers)
                {
                    
                    _loc_2.subEntitiesChanged(this);
                }
            }
            else
            {
                this._subEntitiesChangedWhileLocked = true;
            }
            return;
        }// end function

        public function subEntitiesChanged(param1:TiphonEntityLook) : void
        {
            var _loc_2:* = null;
            if (!this._locked)
            {
                for (_loc_2 in this._observers)
                {
                    
                    _loc_2.subEntitiesChanged(this);
                }
            }
            else
            {
                this._subEntitiesChangedWhileLocked = true;
            }
            return;
        }// end function

        public function clone() : TiphonEntityLook
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_1:* = new TiphonEntityLook();
            _loc_1._bone = this._bone;
            _loc_1._colors = this._colors ? (this._colors.concat()) : (this._colors);
            _loc_1._skins = this._skins ? (this._skins.concat()) : (this._skins);
            _loc_1._defaultSkin = this._defaultSkin;
            _loc_1._scaleX = this._scaleX;
            _loc_1._scaleY = this._scaleY;
            if (this._subEntities)
            {
                _loc_1._subEntities = [];
                for (_loc_2 in this._subEntities)
                {
                    
                    _loc_1._subEntities[_loc_2] = [];
                    for (_loc_3 in this._subEntities[_loc_2])
                    {
                        
                        if (this._subEntities[_loc_2][_loc_3])
                        {
                            _loc_1._subEntities[_loc_2][_loc_3] = this._subEntities[_loc_2][_loc_3].clone();
                        }
                    }
                }
            }
            return _loc_1;
        }// end function

        public static function fromString(param1:String) : TiphonEntityLook
        {
            return EntityLookParser.fromString(param1);
        }// end function

    }
}
