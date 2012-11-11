package com.ankamagames.atouin.types
{
    import com.ankamagames.jerakine.interfaces.*;
    import flash.display.*;

    public class GraphicCell extends Sprite implements ICustomUnicNameGetter
    {
        private var _dropValidator:Function;
        private var _removeDropSource:Function;
        private var _processDrop:Function;
        private var _name:String;
        public var cellId:uint;

        public function GraphicCell(param1:uint)
        {
            this._dropValidator = this.returnTrueFunction;
            this._removeDropSource = this.returnTrueFunction;
            this._processDrop = this.returnTrueFunction;
            this.cellId = param1;
            name = param1.toString();
            this._name = "cell::" + param1;
            buttonMode = true;
            mouseChildren = false;
            cacheAsBitmap = true;
            return;
        }// end function

        public function get customUnicName() : String
        {
            return this._name;
        }// end function

        public function set dropValidator(param1:Function) : void
        {
            this._dropValidator = param1;
            return;
        }// end function

        public function get dropValidator() : Function
        {
            return this._dropValidator;
        }// end function

        public function set removeDropSource(param1:Function) : void
        {
            this._removeDropSource = param1;
            return;
        }// end function

        public function get removeDropSource() : Function
        {
            return this._removeDropSource;
        }// end function

        public function set processDrop(param1:Function) : void
        {
            this._processDrop = param1;
            return;
        }// end function

        public function get processDrop() : Function
        {
            return this._processDrop;
        }// end function

        private function returnTrueFunction(... args) : Boolean
        {
            return true;
        }// end function

    }
}
