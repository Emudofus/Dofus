package com.ankamagames.atouin.types
{
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.enums.*;
    import com.ankamagames.atouin.managers.*;
    import com.ankamagames.jerakine.entities.behaviours.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.resources.adapters.impl.*;
    import com.ankamagames.jerakine.resources.events.*;
    import com.ankamagames.jerakine.resources.loaders.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.types.positions.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.system.*;

    public class ZoneClipTile extends Sprite implements IDisplayable, ITransparency
    {
        private var _uri:Uri;
        private var _clipName:String;
        private var _needBorders:Boolean;
        private var _borderSprites:Array;
        private var _borderBitmapData:BitmapData;
        private var _displayMe:Boolean = false;
        private var _currentRessource:LoadedTile;
        private var _displayBehavior:IDisplayBehavior;
        protected var _displayed:Boolean;
        private var _currentCell:Point;
        private var _cellId:uint;
        public var strata:uint = 0;
        protected var _cellInstance:Sprite;
        private static var clips:Array = new Array();
        private static var loader:IResourceLoader;
        private static var no_z_render_strata:Sprite = new Sprite();
        private static const BORDER_CLIP:String = "BlocageMvt";

        public function ZoneClipTile(param1:Uri, param2:String = "Bloc", param3:Boolean = false)
        {
            var _loc_4:* = null;
            this._borderSprites = new Array();
            mouseEnabled = false;
            mouseChildren = false;
            this._needBorders = param3;
            this._uri = param1;
            this._clipName = param2;
            this._currentRessource = getRessource(param1.fileName);
            if (this._currentRessource == null || loader == null && this._currentRessource == null)
            {
                _loc_4 = new LoadedTile(this._uri.fileName);
                _loc_4.addClip(this._clipName);
                clips.push(_loc_4);
                this._currentRessource = _loc_4;
                loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SINGLE_LOADER);
                loader.addEventListener(ResourceLoadedEvent.LOADED, this.onClipLoaded);
                loader.load(this._uri, null, AdvancedSwfAdapter);
            }
            else if (this._currentRessource.getClip(this._clipName) == null || this._currentRessource.getClip(this._clipName).clip == null)
            {
                loader.addEventListener(ResourceLoadedEvent.LOADED, this.onClipLoaded);
            }
            return;
        }// end function

        private function onClipLoaded(event:ResourceLoadedEvent) : void
        {
            loader.removeEventListener(ResourceLoadedEvent.LOADED, this.onClipLoaded);
            var _loc_2:* = event.resource.applicationDomain;
            var _loc_3:* = getRessource(event.uri.fileName);
            if (_loc_3 == null)
            {
                _loc_3 = new LoadedTile(event.uri.fileName);
                _loc_3.addClip(this._clipName, _loc_2.getDefinition(this._clipName));
                clips.push(_loc_3);
            }
            else if (_loc_3.getClip(this._clipName) == null || _loc_3.getClip(this._clipName).clip == null)
            {
                _loc_3.addClip(this._clipName, _loc_2.getDefinition(this._clipName));
            }
            this._currentRessource = _loc_3;
            if (this._displayMe)
            {
                this._displayMe = false;
                this.display();
            }
            return;
        }// end function

        public function display(param1:uint = 0) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = false;
            var _loc_5:* = false;
            var _loc_6:* = false;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            if (this._currentRessource == null || this._currentRessource.getClip(this._clipName) == null || this._currentRessource.getClip(this._clipName).clip == null)
            {
                this._displayMe = true;
            }
            else
            {
                _loc_2 = this._currentRessource.getClip(this._clipName);
                if (_loc_2.clip != null)
                {
                    this._cellInstance = new _loc_2.clip;
                    addChild(this._cellInstance);
                }
                if (this._needBorders)
                {
                    this._borderSprites = new Array();
                    _loc_4 = this.cellId % 14 == 0;
                    _loc_5 = (this.cellId + 1) % 14 == 0;
                    _loc_6 = Math.floor(this.cellId / 14) % 2 == 0;
                    if (_loc_4 && _loc_6)
                    {
                        _loc_3 = this.getFakeTile();
                        _loc_3.x = -AtouinConstants.CELL_HALF_WIDTH;
                        _loc_3.y = -AtouinConstants.CELL_HALF_HEIGHT;
                        this._borderSprites.push(_loc_3);
                        addChildAt(_loc_3, 0);
                    }
                    else if (_loc_5 && !_loc_6)
                    {
                        _loc_3 = this.getFakeTile();
                        _loc_3.x = AtouinConstants.CELL_HALF_WIDTH;
                        _loc_3.y = -AtouinConstants.CELL_HALF_HEIGHT;
                        this._borderSprites.push(_loc_3);
                        addChildAt(_loc_3, 0);
                    }
                    if (this.cellId < 14)
                    {
                        _loc_3 = this.getFakeTile();
                        _loc_3.x = AtouinConstants.CELL_HALF_WIDTH;
                        _loc_3.y = -AtouinConstants.CELL_HALF_HEIGHT;
                        this._borderSprites.push(_loc_3);
                        addChildAt(_loc_3, 0);
                    }
                    else if (this.cellId > 545)
                    {
                        _loc_3 = this.getFakeTile();
                        _loc_3.x = -AtouinConstants.CELL_HALF_WIDTH;
                        _loc_3.y = AtouinConstants.CELL_HALF_HEIGHT;
                        this._borderSprites.push(_loc_3);
                        addChild(_loc_3);
                    }
                    if (this.cellId == 532)
                    {
                        _loc_7 = this.getFakeTile();
                        _loc_7.x = -AtouinConstants.CELL_HALF_WIDTH;
                        _loc_7.y = AtouinConstants.CELL_HALF_HEIGHT;
                        this._borderSprites.push(_loc_7);
                        addChild(_loc_7);
                    }
                    else if (this.cellId == 559)
                    {
                        _loc_8 = this.getFakeTile();
                        _loc_8.x = AtouinConstants.CELL_HALF_WIDTH;
                        _loc_8.y = AtouinConstants.CELL_HALF_HEIGHT;
                        this._borderSprites.push(_loc_8);
                        addChild(_loc_8);
                    }
                }
                if (this.strata != PlacementStrataEnums.STRATA_NO_Z_ORDER)
                {
                    EntitiesDisplayManager.getInstance().displayEntity(this, MapPoint.fromCellId(this.cellId), this.strata);
                }
                else
                {
                    _loc_9 = InteractiveCellManager.getInstance().getCell(MapPoint.fromCellId(this.cellId).cellId);
                    this.x = _loc_9.x + _loc_9.width / 2;
                    this.y = _loc_9.y + _loc_9.height / 2;
                    no_z_render_strata.addChild(this);
                    if (Atouin.getInstance().selectionContainer != null && !Atouin.getInstance().selectionContainer.contains(no_z_render_strata))
                    {
                        Atouin.getInstance().selectionContainer.addChildAt(no_z_render_strata, 0);
                    }
                }
                this._displayed = true;
            }
            return;
        }// end function

        public function get displayBehaviors() : IDisplayBehavior
        {
            return this._displayBehavior;
        }// end function

        public function set displayBehaviors(param1:IDisplayBehavior) : void
        {
            this._displayBehavior = param1;
            return;
        }// end function

        public function get currentCellPosition() : Point
        {
            return this._currentCell;
        }// end function

        public function set currentCellPosition(param1:Point) : void
        {
            this._currentCell = param1;
            return;
        }// end function

        public function get displayed() : Boolean
        {
            return this._displayed;
        }// end function

        public function get absoluteBounds() : IRectangle
        {
            return this._displayBehavior.getAbsoluteBounds(this);
        }// end function

        public function get cellId() : uint
        {
            return this._cellId;
        }// end function

        public function set cellId(param1:uint) : void
        {
            this._cellId = param1;
            return;
        }// end function

        public function remove() : void
        {
            var _loc_1:* = null;
            this._displayed = false;
            if (this._borderSprites.length)
            {
                do
                {
                    
                    removeChild(_loc_1);
                    var _loc_2:* = this._borderSprites.pop();
                    _loc_1 = this._borderSprites.pop();
                }while (_loc_2)
            }
            if (this._cellInstance != null)
            {
                removeChild(this._cellInstance);
            }
            if (this.strata != PlacementStrataEnums.STRATA_NO_Z_ORDER)
            {
                EntitiesDisplayManager.getInstance().removeEntity(this);
            }
            else
            {
                if (no_z_render_strata.contains(this))
                {
                    no_z_render_strata.removeChild(this);
                }
                if (no_z_render_strata.numChildren <= 0 && Atouin.getInstance().selectionContainer && Atouin.getInstance().selectionContainer.contains(no_z_render_strata))
                {
                    Atouin.getInstance().selectionContainer.removeChild(no_z_render_strata);
                }
            }
            return;
        }// end function

        public function getIsTransparencyAllowed() : Boolean
        {
            return true;
        }// end function

        public function get uri() : Uri
        {
            return this._uri;
        }// end function

        public function get clipName() : String
        {
            return this._clipName;
        }// end function

        public function getFakeTile() : Sprite
        {
            var _loc_3:* = null;
            if (this._borderBitmapData == null)
            {
                _loc_3 = new Shape();
                _loc_3.graphics.beginFill(16711680);
                _loc_3.graphics.moveTo(86 / 2, 0);
                _loc_3.graphics.lineTo(86, 43 / 2);
                _loc_3.graphics.lineTo(86 / 2, 43);
                _loc_3.graphics.lineTo(0, 43 / 2);
                _loc_3.graphics.endFill();
                this._borderBitmapData = new BitmapData(86, 43, true, 16711680);
                this._borderBitmapData.draw(_loc_3);
            }
            var _loc_1:* = new Bitmap(this._borderBitmapData);
            _loc_1.x = -86 / 2;
            _loc_1.y = -43 / 2;
            var _loc_2:* = new Sprite();
            _loc_2.addChild(_loc_1);
            return _loc_2;
        }// end function

        private static function getRessource(param1:String) : LoadedTile
        {
            var _loc_2:* = 0;
            var _loc_3:* = clips.length;
            _loc_2 = 0;
            while (_loc_2 < _loc_3)
            {
                
                if (clips[_loc_2].fileName == param1)
                {
                    return clips[_loc_2] as LoadedTile;
                }
                _loc_2 = _loc_2 + 1;
            }
            return null;
        }// end function

        public static function getTile(param1:String, param2:String) : Sprite
        {
            var _loc_3:* = getRessource(param1);
            return new _loc_3.getClip(param2).clip;
        }// end function

    }
}

import com.ankamagames.atouin.*;

import com.ankamagames.atouin.enums.*;

import com.ankamagames.atouin.managers.*;

import com.ankamagames.jerakine.entities.behaviours.*;

import com.ankamagames.jerakine.entities.interfaces.*;

import com.ankamagames.jerakine.interfaces.*;

import com.ankamagames.jerakine.resources.adapters.impl.*;

import com.ankamagames.jerakine.resources.events.*;

import com.ankamagames.jerakine.resources.loaders.*;

import com.ankamagames.jerakine.types.*;

import com.ankamagames.jerakine.types.positions.*;

import flash.display.*;

import flash.geom.*;

import flash.system.*;

class LoadedTile extends Object
{
    public var fileName:String;
    private var _clips:Array;

    function LoadedTile(param1:String) : void
    {
        this.fileName = param1;
        this._clips = new Array();
        return;
    }// end function

    public function addClip(param1:String, param2:Object = null) : void
    {
        var _loc_3:* = this.getClip(param1);
        if (_loc_3 == null)
        {
            _loc_3 = new Object();
            _loc_3.clipName = param1;
            _loc_3.clip = param2;
            this._clips.push(_loc_3);
        }
        else
        {
            _loc_3.clip = param2;
        }
        return;
    }// end function

    public function getClip(param1:String) : Object
    {
        var _loc_2:* = null;
        for each (_loc_2 in this._clips)
        {
            
            if (_loc_2.clipName == param1)
            {
                return _loc_2;
            }
        }
        return null;
    }// end function

}

