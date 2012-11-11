package com.ankamagames.berilia.components
{
    import __AS3__.vec.*;
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.components.gridRenderer.*;
    import com.ankamagames.berilia.types.data.*;
    import flash.errors.*;
    import flash.utils.*;

    public class Tree extends Grid implements UIComponent
    {
        protected var _realDataProvider:Object;
        protected var _treeDataProvider:Vector.<TreeData>;

        public function Tree()
        {
            _sRendererName = getQualifiedClassName(TreeGridRenderer);
            return;
        }// end function

        override public function set rendererName(param1:String) : void
        {
            throw new IllegalOperationError("rendererName cannot be set");
        }// end function

        override public function set dataProvider(param1) : void
        {
            this._realDataProvider = param1;
            this._treeDataProvider = TreeData.fromArray(param1);
            super.dataProvider = this.makeDataProvider(this._treeDataProvider);
            return;
        }// end function

        override public function get dataProvider()
        {
            return this._realDataProvider;
        }// end function

        public function rerender() : void
        {
            super.dataProvider = this.makeDataProvider(this._treeDataProvider);
            return;
        }// end function

        private function makeDataProvider(param1:Vector.<TreeData>, param2:Vector.<TreeData> = null) : Vector.<TreeData>
        {
            var _loc_3:* = null;
            if (!param2)
            {
                param2 = new Vector.<TreeData>;
            }
            for each (_loc_3 in param1)
            {
                
                param2.push(_loc_3);
                if (_loc_3.expend)
                {
                    this.makeDataProvider(_loc_3.children, param2);
                }
            }
            return param2;
        }// end function

    }
}
