package com.ankamagames.atouin.managers
{
    import com.ankamagames.atouin.*;
    import com.ankamagames.atouin.enums.*;
    import com.ankamagames.atouin.types.*;
    import com.ankamagames.atouin.utils.errors.*;
    import com.ankamagames.jerakine.entities.interfaces.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.positions.*;
    import com.ankamagames.jerakine.utils.display.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import com.ankamagames.tiphon.display.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.utils.*;

    public class EntitiesDisplayManager extends Object
    {
        public var _dStrataRef:Dictionary;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(EntitiesDisplayManager));
        private static var _self:EntitiesDisplayManager;

        public function EntitiesDisplayManager()
        {
            this._dStrataRef = new Dictionary(true);
            if (_self)
            {
                throw new SingletonError("Warning : MobilesManager is a singleton class and shoulnd\'t be instancied directly!");
            }
            return;
        }// end function

        public function displayEntity(param1:IDisplayable, param2:MapPoint, param3:uint = 0) : void
        {
            var displayObject:DisplayObject;
            var oEntity:* = param1;
            var cellCoords:* = param2;
            var strata:* = param3;
            try
            {
                displayObject = oEntity as DisplayObject;
            }
            catch (te:TypeError)
            {
                throw new AtouinError("Entities implementing IDisplayable should extends DisplayObject.");
            }
            this._dStrataRef[oEntity] = strata;
            if (!cellCoords)
            {
                return;
            }
            var cellSprite:* = InteractiveCellManager.getInstance().getCell(cellCoords.cellId);
            displayObject.x = cellSprite.x + cellSprite.width / 2;
            displayObject.y = cellSprite.y + cellSprite.height / 2;
            if (strata == PlacementStrataEnums.STRATA_NO_Z_ORDER)
            {
                if (Atouin.getInstance().options.transparentOverlayMode && displayObject is ITransparency && ITransparency(displayObject).getIsTransparencyAllowed())
                {
                    displayObject.alpha = displayObject.alpha != 1 ? (displayObject.alpha) : (AtouinConstants.OVERLAY_MODE_ALPHA);
                    Atouin.getInstance().gfxContainer.addChild(displayObject);
                }
                else
                {
                    displayObject.alpha = 1;
                    Atouin.getInstance().selectionContainer.addChild(displayObject);
                }
            }
            else if (strata == PlacementStrataEnums.STRATA_FOREGROUND)
            {
                Atouin.getInstance().gfxContainer.addChild(displayObject);
            }
            else
            {
                this.orderEntity(displayObject, cellSprite);
            }
            return;
        }// end function

        public function refreshAlphaEntity(param1:IDisplayable, param2:MapPoint, param3:uint = 0) : void
        {
            var displayObject:DisplayObject;
            var cellSprite:Sprite;
            var oEntity:* = param1;
            var cellCoords:* = param2;
            var strata:* = param3;
            try
            {
                displayObject = oEntity as DisplayObject;
            }
            catch (te:TypeError)
            {
                throw new AtouinError("Entities implementing IDisplayable should extends DisplayObject.");
            }
            if (cellCoords)
            {
                cellSprite = InteractiveCellManager.getInstance().getCell(cellCoords.cellId);
                this.orderEntity(displayObject, cellSprite);
            }
            else
            {
                _log.error("refreshAlphaEntity  can\'t handle null position");
            }
            return;
        }// end function

        public function removeEntity(param1:IDisplayable) : void
        {
            var displayObject:DisplayObject;
            var oEntity:* = param1;
            try
            {
                displayObject = oEntity as DisplayObject;
            }
            catch (te:TypeError)
            {
                throw new AtouinError("Entities implementing IDisplayable should extends DisplayObject.");
            }
            if (displayObject.parent)
            {
                displayObject.parent.removeChild(displayObject);
            }
            return;
        }// end function

        public function orderEntity(param1:DisplayObject, param2:Sprite) : void
        {
            var _loc_7:DisplayObject = null;
            var _loc_10:DisplayObjectContainer = null;
            var _loc_11:int = 0;
            var _loc_3:Boolean = false;
            var _loc_4:* = param1 as TiphonSprite;
            if (param1 as TiphonSprite && _loc_4.parentSprite)
            {
                _loc_3 = true;
            }
            if (Atouin.getInstance().options.transparentOverlayMode && param1 is ITransparency && ITransparency(param1).getIsTransparencyAllowed())
            {
                param1.alpha = param1.alpha != 1 ? (param1.alpha) : (AtouinConstants.OVERLAY_MODE_ALPHA);
                if (_loc_3)
                {
                    return;
                }
                _loc_10 = Atouin.getInstance().overlayContainer;
                _loc_11 = _loc_10.numChildren;
                var _loc_9:uint = 0;
                while (_loc_9 < _loc_11)
                {
                    
                    _loc_7 = _loc_10.getChildAt(_loc_9);
                    if (param1.y < _loc_7.y)
                    {
                        break;
                    }
                    _loc_9 = _loc_9 + 1;
                }
                if (_loc_10.contains(param1) && _loc_9 > 0)
                {
                    _loc_10.addChildAt(param1, (_loc_9 - 1));
                }
                else
                {
                    _loc_10.addChildAt(param1, _loc_9);
                }
                return;
            }
            else
            {
                if (Math.round(param1.alpha * 10) == AtouinConstants.OVERLAY_MODE_ALPHA * 10)
                {
                    param1.alpha = 1;
                }
                if (_loc_3)
                {
                    return;
                }
            }
            if (!param2 || !param2.parent)
            {
                return;
            }
            var _loc_5:* = param2.parent.getChildIndex(param2);
            var _loc_6:* = param2.parent.numChildren;
            var _loc_8:Boolean = true;
            _loc_9 = _loc_5 + 1;
            while (_loc_9 < _loc_6)
            {
                
                _loc_7 = param2.parent.getChildAt(_loc_9);
                if (_loc_7 is GraphicCell)
                {
                    break;
                }
                if (this._dStrataRef[param1] < this._dStrataRef[_loc_7])
                {
                    break;
                }
                if (_loc_7 !== param2 && _loc_7 != param1)
                {
                    _loc_5 = _loc_5 + 1;
                }
                _loc_8 = false;
                _loc_9 = _loc_9 + 1;
            }
            param2.parent.addChildAt(param1, (_loc_5 + 1));
            return;
        }// end function

        public function getAbsoluteBounds(param1:IDisplayable) : IRectangle
        {
            var _loc_2:* = param1 as DisplayObject;
            var _loc_3:* = new Rectangle2();
            var _loc_4:* = _loc_2.getBounds(StageShareManager.stage);
            _loc_3.x = _loc_4.x;
            _loc_3.width = _loc_4.width;
            _loc_3.height = _loc_4.height;
            _loc_3.y = _loc_4.y;
            return _loc_3;
        }// end function

        public static function getInstance() : EntitiesDisplayManager
        {
            if (!_self)
            {
                _self = new EntitiesDisplayManager;
            }
            return _self;
        }// end function

    }
}
