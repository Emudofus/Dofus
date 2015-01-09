package com.ankamagames.atouin.managers
{
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import flash.utils.Dictionary;
    import com.ankamagames.jerakine.utils.errors.SingletonError;
    import flash.display.DisplayObject;
    import com.ankamagames.atouin.utils.errors.AtouinError;
    import flash.display.Sprite;
    import com.ankamagames.atouin.enums.PlacementStrataEnums;
    import com.ankamagames.atouin.Atouin;
    import com.ankamagames.jerakine.interfaces.ITransparency;
    import com.ankamagames.atouin.AtouinConstants;
    import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
    import com.ankamagames.jerakine.types.positions.MapPoint;
    import flash.display.DisplayObjectContainer;
    import com.ankamagames.tiphon.display.TiphonSprite;
    import com.ankamagames.atouin.types.GraphicCell;
    import com.ankamagames.jerakine.utils.display.Rectangle2;
    import com.ankamagames.jerakine.utils.display.StageShareManager;
    import flash.geom.Rectangle;
    import com.ankamagames.jerakine.interfaces.IRectangle;

    public class EntitiesDisplayManager 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(EntitiesDisplayManager));
        private static var _self:EntitiesDisplayManager;

        public var _dStrataRef:Dictionary;

        public function EntitiesDisplayManager()
        {
            this._dStrataRef = new Dictionary(true);
            super();
            if (_self)
            {
                throw (new SingletonError("Warning : MobilesManager is a singleton class and shoulnd't be instancied directly!"));
            };
        }

        public static function getInstance():EntitiesDisplayManager
        {
            if (!(_self))
            {
                _self = new (EntitiesDisplayManager)();
            };
            return (_self);
        }


        public function displayEntity(oEntity:IDisplayable, cellCoords:MapPoint, strata:uint=0):void
        {
            var displayObject:DisplayObject;
            try
            {
                displayObject = (oEntity as DisplayObject);
            }
            catch(te:TypeError)
            {
                throw (new AtouinError("Entities implementing IDisplayable should extends DisplayObject."));
            };
            if (this._dStrataRef[oEntity] != null)
            {
                strata = this._dStrataRef[oEntity];
            }
            else
            {
                this._dStrataRef[oEntity] = strata;
            };
            if (!(cellCoords))
            {
                return;
            };
            var cellSprite:Sprite = InteractiveCellManager.getInstance().getCell(cellCoords.cellId);
            displayObject.x = (cellSprite.x + (cellSprite.width / 2));
            displayObject.y = (cellSprite.y + (cellSprite.height / 2));
            if (strata == PlacementStrataEnums.STRATA_NO_Z_ORDER)
            {
                if (Atouin.getInstance().options.transparentOverlayMode)
                {
                    if ((((displayObject is ITransparency)) && (ITransparency(displayObject).getIsTransparencyAllowed())))
                    {
                        displayObject.alpha = ((!((displayObject.alpha == 1))) ? displayObject.alpha : AtouinConstants.OVERLAY_MODE_ALPHA);
                    }
                    else
                    {
                        displayObject.alpha = 1;
                    };
                    Atouin.getInstance().gfxContainer.addChild(displayObject);
                }
                else
                {
                    displayObject.alpha = 1;
                    Atouin.getInstance().selectionContainer.addChild(displayObject);
                };
            }
            else
            {
                if (strata == PlacementStrataEnums.STRATA_FOREGROUND)
                {
                    Atouin.getInstance().gfxContainer.addChild(displayObject);
                }
                else
                {
                    this.orderEntity(displayObject, cellSprite);
                };
            };
        }

        public function refreshAlphaEntity(oEntity:IDisplayable, cellCoords:MapPoint, strata:uint=0):void
        {
            var displayObject:DisplayObject;
            var cellSprite:Sprite;
            try
            {
                displayObject = (oEntity as DisplayObject);
            }
            catch(te:TypeError)
            {
                throw (new AtouinError("Entities implementing IDisplayable should extends DisplayObject."));
            };
            if (cellCoords)
            {
                cellSprite = InteractiveCellManager.getInstance().getCell(cellCoords.cellId);
                this.orderEntity(displayObject, cellSprite);
            }
            else
            {
                _log.error("refreshAlphaEntity  can't handle null position");
            };
        }

        public function removeEntity(oEntity:IDisplayable):void
        {
            var displayObject:DisplayObject;
            try
            {
                displayObject = (oEntity as DisplayObject);
            }
            catch(te:TypeError)
            {
                throw (new AtouinError("Entities implementing IDisplayable should extends DisplayObject."));
            };
            if (displayObject.parent)
            {
                displayObject.parent.removeChild(displayObject);
            };
        }

        public function orderEntity(entity:DisplayObject, cellSprite:Sprite):void
        {
            var currentElem:DisplayObject;
            var container:DisplayObjectContainer;
            var num:int;
            var skipZOrder:Boolean;
            var sprite:TiphonSprite = (entity as TiphonSprite);
            if (((sprite) && (sprite.parentSprite)))
            {
                skipZOrder = true;
            };
            if (((((Atouin.getInstance().options.transparentOverlayMode) && ((entity is ITransparency)))) && (ITransparency(entity).getIsTransparencyAllowed())))
            {
                entity.alpha = ((!((entity.alpha == 1))) ? entity.alpha : AtouinConstants.OVERLAY_MODE_ALPHA);
                if (skipZOrder)
                {
                    return;
                };
                container = Atouin.getInstance().overlayContainer;
                num = container.numChildren;
                var i:uint;
                while (i < num)
                {
                    currentElem = container.getChildAt(i);
                    if (entity.y < currentElem.y)
                    {
                        break;
                    };
                    i++;
                };
                if (((container.contains(entity)) && ((i > 0))))
                {
                    container.addChildAt(entity, (i - 1));
                }
                else
                {
                    container.addChildAt(entity, i);
                };
                return;
            };
            if (Math.round((entity.alpha * 10)) == (AtouinConstants.OVERLAY_MODE_ALPHA * 10))
            {
                entity.alpha = 1;
            };
            if (skipZOrder)
            {
                return;
            };
            if (((!(cellSprite)) || (!(cellSprite.parent))))
            {
                return;
            };
            var depth:uint = cellSprite.parent.getChildIndex(cellSprite);
            var nb:int = cellSprite.parent.numChildren;
            var firstLoop:Boolean = true;
            i = (depth + 1);
            while (i < nb)
            {
                currentElem = cellSprite.parent.getChildAt(i);
                if ((currentElem is GraphicCell))
                {
                    break;
                };
                if (this._dStrataRef[entity] < this._dStrataRef[currentElem]) break;
                if (((!((currentElem === cellSprite))) && (!((currentElem == entity)))))
                {
                    depth++;
                };
                firstLoop = false;
                i++;
            };
            cellSprite.parent.addChildAt(entity, (depth + 1));
        }

        public function getAbsoluteBounds(entity:IDisplayable):IRectangle
        {
            var d:DisplayObject = (entity as DisplayObject);
            var r:Rectangle2 = new Rectangle2();
            var r2:Rectangle = d.getBounds(StageShareManager.stage);
            r.x = r2.x;
            r.width = r2.width;
            r.height = r2.height;
            r.y = r2.y;
            return (r);
        }


    }
}//package com.ankamagames.atouin.managers

