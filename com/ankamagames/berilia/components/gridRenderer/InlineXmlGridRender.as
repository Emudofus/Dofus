package com.ankamagames.berilia.components.gridRenderer
{
    import flash.geom.ColorTransform;
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import com.ankamagames.berilia.managers.SecureCenter;
    import com.ankamagames.berilia.types.graphic.UiRootContainer;

    [RendererArgs(updateLineMethod="Function", evenLineColor="uint", oddLineColor="uint")]
    public class InlineXmlGridRender extends MultiGridRenderer 
    {

        public function InlineXmlGridRender(args:String)
        {
            super(null);
            var params:Array = args.split(",");
            _updateFunctionName = params[0];
            if (params[1])
            {
                _bgColor1 = new ColorTransform();
                _color1 = parseInt(params[1], 16);
                _bgColor1.color = _color1;
            };
            if (params[2])
            {
                _bgColor2 = new ColorTransform();
                _color2 = parseInt(params[2], 16);
                _bgColor2.color = _color2;
            };
            if (params[3])
            {
                _bgAlpha = Number(params[3]);
            };
            _defaultLineType = "default";
        }

        override public function update(data:*, index:uint, target:DisplayObject, selected:Boolean, subIndex:uint=0):void
        {
            super.update(data, index, target, selected, subIndex);
        }

        override protected function uiUpdate(ui:UiRootContainer, target:DisplayObject, data:*, selected:Boolean, subIndex:uint):void
        {
            if (DisplayObjectContainer(target).numChildren)
            {
                var _local_6 = ui.uiClass;
                (_local_6[_updateFunctionName](SecureCenter.secure(data), _cptNameReferences[DisplayObjectContainer(target).getChildAt(0)], selected));
            };
        }

        override public function renderModificator(childs:Array):Array
        {
            _containerDefinition["default"] = childs[0];
            return ([]);
        }


    }
}//package com.ankamagames.berilia.components.gridRenderer

