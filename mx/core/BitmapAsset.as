package mx.core
{
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.system.*;
    import mx.core.*;

    public class BitmapAsset extends FlexBitmap implements IFlexAsset, IFlexDisplayObject, ILayoutDirectionElement
    {
        private var layoutFeaturesClass:Class;
        private var layoutFeatures:IAssetLayoutFeatures;
        private var _height:Number;
        private var _layoutDirection:String = "ltr";
        static const VERSION:String = "4.6.0.23201";
        private static var FlexVersionClass:Class;
        private static var MatrixUtilClass:Class;

        public function BitmapAsset(param1:BitmapData = null, param2:String = "auto", param3:Boolean = false)
        {
            var _loc_4:* = null;
            super(param1, param2, param3);
            if (FlexVersionClass == null)
            {
                _loc_4 = ApplicationDomain.currentDomain;
                if (_loc_4.hasDefinition("mx.core::FlexVersion"))
                {
                    FlexVersionClass = Class(_loc_4.getDefinition("mx.core::FlexVersion"));
                }
            }
            if (FlexVersionClass && FlexVersionClass["compatibilityVersion"] >= FlexVersionClass["VERSION_4_0"])
            {
                this.addEventListener(Event.ADDED, this.addedHandler);
            }
            return;
        }// end function

        override public function get x() : Number
        {
            return this.layoutFeatures == null ? (super.x) : (this.layoutFeatures.layoutX);
        }// end function

        override public function set x(param1:Number) : void
        {
            if (this.x == param1)
            {
                return;
            }
            if (this.layoutFeatures == null)
            {
                super.x = param1;
            }
            else
            {
                this.layoutFeatures.layoutX = param1;
                this.validateTransformMatrix();
            }
            return;
        }// end function

        override public function get y() : Number
        {
            return this.layoutFeatures == null ? (super.y) : (this.layoutFeatures.layoutY);
        }// end function

        override public function set y(param1:Number) : void
        {
            if (this.y == param1)
            {
                return;
            }
            if (this.layoutFeatures == null)
            {
                super.y = param1;
            }
            else
            {
                this.layoutFeatures.layoutY = param1;
                this.validateTransformMatrix();
            }
            return;
        }// end function

        override public function get z() : Number
        {
            return this.layoutFeatures == null ? (super.z) : (this.layoutFeatures.layoutZ);
        }// end function

        override public function set z(param1:Number) : void
        {
            if (this.z == param1)
            {
                return;
            }
            if (this.layoutFeatures == null)
            {
                super.z = param1;
            }
            else
            {
                this.layoutFeatures.layoutZ = param1;
                this.validateTransformMatrix();
            }
            return;
        }// end function

        override public function get width() : Number
        {
            var _loc_1:* = null;
            if (this.layoutFeatures == null)
            {
                return super.width;
            }
            if (MatrixUtilClass != null)
            {
                var _loc_2:* = MatrixUtilClass;
                _loc_1 = _loc_2.MatrixUtilClass["transformSize"](this.layoutFeatures.layoutWidth, this._height, transform.matrix);
            }
            return _loc_1 ? (_loc_1.x) : (super.width);
        }// end function

        override public function set width(param1:Number) : void
        {
            if (this.width == param1)
            {
                return;
            }
            if (this.layoutFeatures == null)
            {
                super.width = param1;
            }
            else
            {
                this.layoutFeatures.layoutWidth = param1;
                this.layoutFeatures.layoutScaleX = this.measuredWidth != 0 ? (param1 / this.measuredWidth) : (0);
                this.validateTransformMatrix();
            }
            return;
        }// end function

        override public function get height() : Number
        {
            var _loc_1:* = null;
            if (this.layoutFeatures == null)
            {
                return super.height;
            }
            if (MatrixUtilClass != null)
            {
                var _loc_2:* = MatrixUtilClass;
                _loc_1 = _loc_2.MatrixUtilClass["transformSize"](this.layoutFeatures.layoutWidth, this._height, transform.matrix);
            }
            return _loc_1 ? (_loc_1.y) : (super.height);
        }// end function

        override public function set height(param1:Number) : void
        {
            if (this.height == param1)
            {
                return;
            }
            if (this.layoutFeatures == null)
            {
                super.height = param1;
            }
            else
            {
                this._height = param1;
                this.layoutFeatures.layoutScaleY = this.measuredHeight != 0 ? (param1 / this.measuredHeight) : (0);
                this.validateTransformMatrix();
            }
            return;
        }// end function

        override public function get rotationX() : Number
        {
            return this.layoutFeatures == null ? (super.rotationX) : (this.layoutFeatures.layoutRotationX);
        }// end function

        override public function set rotationX(param1:Number) : void
        {
            if (this.rotationX == param1)
            {
                return;
            }
            if (this.layoutFeatures == null)
            {
                super.rotationX = param1;
            }
            else
            {
                this.layoutFeatures.layoutRotationX = param1;
                this.validateTransformMatrix();
            }
            return;
        }// end function

        override public function get rotationY() : Number
        {
            return this.layoutFeatures == null ? (super.rotationY) : (this.layoutFeatures.layoutRotationY);
        }// end function

        override public function set rotationY(param1:Number) : void
        {
            if (this.rotationY == param1)
            {
                return;
            }
            if (this.layoutFeatures == null)
            {
                super.rotationY = param1;
            }
            else
            {
                this.layoutFeatures.layoutRotationY = param1;
                this.validateTransformMatrix();
            }
            return;
        }// end function

        override public function get rotationZ() : Number
        {
            return this.layoutFeatures == null ? (super.rotationZ) : (this.layoutFeatures.layoutRotationZ);
        }// end function

        override public function set rotationZ(param1:Number) : void
        {
            if (this.rotationZ == param1)
            {
                return;
            }
            if (this.layoutFeatures == null)
            {
                super.rotationZ = param1;
            }
            else
            {
                this.layoutFeatures.layoutRotationZ = param1;
                this.validateTransformMatrix();
            }
            return;
        }// end function

        override public function get rotation() : Number
        {
            return this.layoutFeatures == null ? (super.rotation) : (this.layoutFeatures.layoutRotationZ);
        }// end function

        override public function set rotation(param1:Number) : void
        {
            if (this.rotation == param1)
            {
                return;
            }
            if (this.layoutFeatures == null)
            {
                super.rotation = param1;
            }
            else
            {
                this.layoutFeatures.layoutRotationZ = param1;
                this.validateTransformMatrix();
            }
            return;
        }// end function

        override public function get scaleX() : Number
        {
            return this.layoutFeatures == null ? (super.scaleX) : (this.layoutFeatures.layoutScaleX);
        }// end function

        override public function set scaleX(param1:Number) : void
        {
            if (this.scaleX == param1)
            {
                return;
            }
            if (this.layoutFeatures == null)
            {
                super.scaleX = param1;
            }
            else
            {
                this.layoutFeatures.layoutScaleX = param1;
                this.layoutFeatures.layoutWidth = Math.abs(param1) * this.measuredWidth;
                this.validateTransformMatrix();
            }
            return;
        }// end function

        override public function get scaleY() : Number
        {
            return this.layoutFeatures == null ? (super.scaleY) : (this.layoutFeatures.layoutScaleY);
        }// end function

        override public function set scaleY(param1:Number) : void
        {
            if (this.scaleY == param1)
            {
                return;
            }
            if (this.layoutFeatures == null)
            {
                super.scaleY = param1;
            }
            else
            {
                this.layoutFeatures.layoutScaleY = param1;
                this._height = Math.abs(param1) * this.measuredHeight;
                this.validateTransformMatrix();
            }
            return;
        }// end function

        override public function get scaleZ() : Number
        {
            return this.layoutFeatures == null ? (super.scaleZ) : (this.layoutFeatures.layoutScaleZ);
        }// end function

        override public function set scaleZ(param1:Number) : void
        {
            if (this.scaleZ == param1)
            {
                return;
            }
            if (this.layoutFeatures == null)
            {
                super.scaleZ = param1;
            }
            else
            {
                this.layoutFeatures.layoutScaleZ = param1;
                this.validateTransformMatrix();
            }
            return;
        }// end function

        public function get layoutDirection() : String
        {
            return this._layoutDirection;
        }// end function

        public function set layoutDirection(param1:String) : void
        {
            if (param1 == this._layoutDirection)
            {
                return;
            }
            this._layoutDirection = param1;
            this.invalidateLayoutDirection();
            return;
        }// end function

        public function get measuredHeight() : Number
        {
            if (bitmapData)
            {
                return bitmapData.height;
            }
            return 0;
        }// end function

        public function get measuredWidth() : Number
        {
            if (bitmapData)
            {
                return bitmapData.width;
            }
            return 0;
        }// end function

        public function invalidateLayoutDirection() : void
        {
            var _loc_2:* = false;
            var _loc_1:* = parent;
            while (_loc_1)
            {
                
                if (_loc_1 is ILayoutDirectionElement)
                {
                    _loc_2 = this._layoutDirection != null && ILayoutDirectionElement(_loc_1).layoutDirection != null && this._layoutDirection != ILayoutDirectionElement(_loc_1).layoutDirection;
                    if (_loc_2 && this.layoutFeatures == null)
                    {
                        this.initAdvancedLayoutFeatures();
                        if (this.layoutFeatures != null)
                        {
                            this.layoutFeatures.mirror = _loc_2;
                            this.validateTransformMatrix();
                        }
                    }
                    else if (!_loc_2 && this.layoutFeatures)
                    {
                        this.layoutFeatures.mirror = _loc_2;
                        this.validateTransformMatrix();
                        this.layoutFeatures = null;
                    }
                    break;
                }
                _loc_1 = _loc_1.parent;
            }
            return;
        }// end function

        public function move(param1:Number, param2:Number) : void
        {
            this.x = param1;
            this.y = param2;
            return;
        }// end function

        public function setActualSize(param1:Number, param2:Number) : void
        {
            this.width = param1;
            this.height = param2;
            return;
        }// end function

        private function addedHandler(event:Event) : void
        {
            this.invalidateLayoutDirection();
            return;
        }// end function

        private function initAdvancedLayoutFeatures() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            if (this.layoutFeaturesClass == null)
            {
                _loc_1 = ApplicationDomain.currentDomain;
                if (_loc_1.hasDefinition("mx.core::AdvancedLayoutFeatures"))
                {
                    this.layoutFeaturesClass = Class(_loc_1.getDefinition("mx.core::AdvancedLayoutFeatures"));
                }
                if (MatrixUtilClass == null)
                {
                    if (_loc_1.hasDefinition("mx.utils::MatrixUtil"))
                    {
                        MatrixUtilClass = Class(_loc_1.getDefinition("mx.utils::MatrixUtil"));
                    }
                }
            }
            if (this.layoutFeaturesClass != null)
            {
                _loc_2 = new this.layoutFeaturesClass();
                _loc_2.layoutScaleX = this.scaleX;
                _loc_2.layoutScaleY = this.scaleY;
                _loc_2.layoutScaleZ = this.scaleZ;
                _loc_2.layoutRotationX = this.rotationX;
                _loc_2.layoutRotationY = this.rotationY;
                _loc_2.layoutRotationZ = this.rotation;
                _loc_2.layoutX = this.x;
                _loc_2.layoutY = this.y;
                _loc_2.layoutZ = this.z;
                _loc_2.layoutWidth = this.width;
                this._height = this.height;
                this.layoutFeatures = _loc_2;
            }
            return;
        }// end function

        private function validateTransformMatrix() : void
        {
            if (this.layoutFeatures != null)
            {
                if (this.layoutFeatures.is3D)
                {
                    super.transform.matrix3D = this.layoutFeatures.computedMatrix3D;
                }
                else
                {
                    super.transform.matrix = this.layoutFeatures.computedMatrix;
                }
            }
            return;
        }// end function

    }
}
