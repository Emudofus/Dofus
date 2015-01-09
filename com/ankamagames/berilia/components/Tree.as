package com.ankamagames.berilia.components
{
    import com.ankamagames.berilia.UIComponent;
    import __AS3__.vec.Vector;
    import com.ankamagames.berilia.types.data.TreeData;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.berilia.components.gridRenderer.TreeGridRenderer;
    import flash.errors.IllegalOperationError;
    import com.ankamagames.berilia.managers.SecureCenter;
    import __AS3__.vec.*;

    public class Tree extends Grid implements UIComponent 
    {

        protected var _realDataProvider;
        protected var _treeDataProvider:Vector.<TreeData>;

        public function Tree()
        {
            _sRendererName = getQualifiedClassName(TreeGridRenderer);
        }

        override public function set rendererName(value:String):void
        {
            throw (new IllegalOperationError("rendererName cannot be set"));
        }

        override public function set dataProvider(data:*):void
        {
            this._realDataProvider = data;
            this._treeDataProvider = TreeData.fromArray(data);
            super.dataProvider = this.makeDataProvider(this._treeDataProvider);
        }

        override public function get dataProvider()
        {
            return (this._realDataProvider);
        }

        public function get treeRoot():TreeData
        {
            var treeRoot:TreeData;
            if (_dataProvider.length > 0)
            {
                treeRoot = _dataProvider[0].parent;
            };
            return (treeRoot);
        }

        public function rerender():void
        {
            super.dataProvider = this.makeDataProvider(this._treeDataProvider);
        }

        public function expandItems(pItems:Array):void
        {
            var item:Object;
            var treeData:TreeData;
            if (!(pItems))
            {
                return;
            };
            for each (item in pItems)
            {
                treeData = (SecureCenter.unsecure(item) as TreeData);
                if (treeData.children.length > 0)
                {
                    treeData.expend = true;
                };
            };
            this.rerender();
        }

        private function makeDataProvider(v:Vector.<TreeData>, result:Vector.<TreeData>=null):Vector.<TreeData>
        {
            var node:TreeData;
            if (!(result))
            {
                result = new Vector.<TreeData>();
            };
            for each (node in v)
            {
                result.push(node);
                if (node.expend)
                {
                    this.makeDataProvider(node.children, result);
                };
            };
            return (result);
        }


    }
}//package com.ankamagames.berilia.components

